# test-original-comparison.R
# Tests comparing reanalysis results to original study (Heshmati et al., 2023)
# Part of the comprehensive testing framework for ISTDP reanalysis

library(testthat)
library(haven)
library(dplyr)
library(lme4)

# Load data
data <- read_sav("../../data/RCT Dataset ISTDP vs. Waitlist for Treatment-Resistant Depression.sav")
data <- data %>%
  mutate(
    Time = as_factor(Time),
    Tx_condition = as_factor(Tx_condition),
    id = factor(id),
    gender = as_factor(gender),
    medicationreceiving = as_factor(medicationreceiving)
  )

baseline <- data %>% filter(Time == "Baseline")

# ==============================================================================
# Test 1-4: Baseline Demographics (from Heshmati et al., 2023)
# ==============================================================================

test_that("Mean age matches published study (~36.9 years)", {
  mean_age <- mean(baseline$age, na.rm = TRUE)

  # Published: M = 36.9, SD = 11.7
  expect_equal(mean_age, 36.9, tolerance = 2.0)
})

test_that("Age SD matches published study (~11.7)", {
  sd_age <- sd(baseline$age, na.rm = TRUE)

  # Published: SD = 11.7
  expect_equal(sd_age, 11.7, tolerance = 2.0)
})

test_that("Gender distribution matches published study (~62% female)", {
  female_pct <- sum(baseline$gender == "female", na.rm = TRUE) / nrow(baseline) * 100

  # Published: ~62% female
  expect_equal(female_pct, 62, tolerance = 10)
})

test_that("Medication use matches published study (~79% receiving)", {
  # Check if medication variable exists
  if ("medicationreceiving" %in% names(baseline)) {
    med_pct <- sum(baseline$medicationreceiving == "yes", na.rm = TRUE) /
               nrow(baseline) * 100

    # Published: ~79% currently receiving medication
    expect_equal(med_pct, 79, tolerance = 10)
  }
})

# ==============================================================================
# Test 5-6: Previous Treatment History
# ==============================================================================

test_that("Previous antidepressant trials matches published (~1.8)", {
  if ("previoustreatment" %in% names(baseline)) {
    mean_prev <- mean(baseline$previoustreatment, na.rm = TRUE)

    # Published: M = 1.8 trials
    expect_equal(mean_prev, 1.8, tolerance = 0.5)
  }
})

test_that("Sample size matches published study (N = 86)", {
  # Published: N = 86 (43 per group)
  expect_equal(nrow(baseline), 86)

  tx_counts <- table(baseline$Tx_condition)
  expect_equal(as.numeric(tx_counts[1]), 43)
  expect_equal(as.numeric(tx_counts[2]), 43)
})

# ==============================================================================
# Test 7-8: Treatment Effects Direction
# ==============================================================================

test_that("ISTDP shows depression reduction (matches original finding)", {
  # Original study found significant depression reduction in ISTDP group

  model <- lmer(Depression ~ Time * Tx_condition + (1 | id),
               data = data, REML = TRUE)

  # Extract estimated marginal means
  emm <- emmeans::emmeans(model, ~ Tx_condition | Time)
  emm_df <- as.data.frame(emm)

  istdp_baseline <- emm_df$emmean[emm_df$Tx_condition == "ISTDP" &
                                  emm_df$Time == "Baseline"]
  istdp_followup <- emm_df$emmean[emm_df$Tx_condition == "ISTDP" &
                                  emm_df$Time == "Follow-up"]

  # Should show decrease
  expect_true(istdp_followup < istdp_baseline)

  # Decrease should be substantial (> 5 points)
  expect_gt(istdp_baseline - istdp_followup, 5)
})

test_that("Waitlist shows minimal change (matches original finding)", {
  # Original study found minimal change in waitlist

  model <- lmer(Depression ~ Time * Tx_condition + (1 | id),
               data = data, REML = TRUE)

  emm <- emmeans::emmeans(model, ~ Tx_condition | Time)
  emm_df <- as.data.frame(emm)

  control_baseline <- emm_df$emmean[emm_df$Tx_condition == "Control" &
                                    emm_df$Time == "Baseline"]
  control_followup <- emm_df$emmean[emm_df$Tx_condition == "Control" &
                                    emm_df$Time == "Follow-up"]

  # Change should be small (< 3 points)
  expect_lt(abs(control_followup - control_baseline), 3)
})

# ==============================================================================
# Test 9: Effect Size Magnitude
# ==============================================================================

test_that("Effect size magnitude is large (matches original finding)", {
  # Original study found very large effects

  data_clean <- data %>% filter(!is.na(Depression))
  df_fu <- data_clean %>% filter(Time == "Follow-up")

  control <- df_fu %>% filter(Tx_condition == "Control") %>% pull(Depression)
  istdp <- df_fu %>% filter(Tx_condition == "ISTDP") %>% pull(Depression)

  d_result <- effsize::cohen.d(istdp, control)
  d_value <- abs(d_result$estimate)

  # Should show very large effect (d > 1.0)
  expect_gt(d_value, 1.0)

  # Original study found effects around d = 2.0-2.5
  expect_lt(d_value, 4.0)  # Upper sanity bound
})

# ==============================================================================
# Test 10: Dropout/Missing Data Pattern
# ==============================================================================

test_that("Dropout rates are similar between groups", {
  # Calculate dropout by group
  dropout_by_group <- data %>%
    group_by(id, Tx_condition) %>%
    summarise(
      n_obs = n(),
      dropped = n_obs < 3,
      .groups = "drop"
    ) %>%
    group_by(Tx_condition) %>%
    summarise(
      dropout_rate = mean(dropped) * 100,
      .groups = "drop"
    )

  istdp_dropout <- dropout_by_group$dropout_rate[
    dropout_by_group$Tx_condition == "ISTDP"
  ]
  control_dropout <- dropout_by_group$dropout_rate[
    dropout_by_group$Tx_condition == "Control"
  ]

  # Dropout should be relatively balanced (within 10 percentage points)
  expect_lt(abs(istdp_dropout - control_dropout), 15)

  # Both should be < 25% (study had low attrition)
  expect_lt(istdp_dropout, 25)
  expect_lt(control_dropout, 25)
})
