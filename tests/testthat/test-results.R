# test-results.R
# Tests for statistical results validity and plausibility
# Part of the comprehensive testing framework for ISTDP reanalysis

library(testthat)
library(haven)
library(dplyr)
library(lme4)
library(lmerTest)
library(emmeans)
library(effsize)

# Load and transform data
data <- read_sav("../../data/RCT Dataset ISTDP vs. Waitlist for Treatment-Resistant Depression.sav")
data <- data %>%
  mutate(
    Time = as_factor(Time),
    Tx_condition = as_factor(Tx_condition),
    id = factor(id)
  )

data_clean <- data %>% filter(!is.na(Depression))

# Fit primary model
model <- lmer(Depression ~ Time * Tx_condition + (1 | id),
              data = data, REML = TRUE)

# Calculate EMMs
emm <- emmeans(model, ~ Tx_condition | Time)
emm_summary <- summary(emm)

# Calculate effect sizes
calculate_effect_sizes <- function() {
  effect_sizes <- data.frame()

  for (time_point in c("Baseline", "Post-treatment", "Follow-up")) {
    df_time <- data_clean %>% filter(Time == time_point)

    control_scores <- df_time %>%
      filter(Tx_condition == "Control") %>%
      pull(Depression)

    istdp_scores <- df_time %>%
      filter(Tx_condition == "ISTDP") %>%
      pull(Depression)

    d_result <- cohen.d(istdp_scores, control_scores)

    effect_sizes <- rbind(effect_sizes, data.frame(
      Time = time_point,
      Cohens_d = -d_result$estimate,
      CI_lower = -d_result$conf.int[2],
      CI_upper = -d_result$conf.int[1]
    ))
  }

  return(effect_sizes)
}

effect_sizes <- calculate_effect_sizes()

# ==============================================================================
# Test 1-4: Effect Size Validity
# ==============================================================================

test_that("Effect sizes are in plausible range", {
  # Cohen's d should be between -5 and 5
  expect_true(all(effect_sizes$Cohens_d > -5))
  expect_true(all(effect_sizes$Cohens_d < 5))
})

test_that("Confidence intervals are properly ordered", {
  # Lower CI should always be less than upper CI
  expect_true(all(effect_sizes$CI_lower < effect_sizes$CI_upper))
})

test_that("Baseline effect size is small (groups balanced)", {
  baseline_d <- effect_sizes$Cohens_d[effect_sizes$Time == "Baseline"]

  # Groups should be balanced at baseline (|d| < 0.5)
  expect_lt(abs(baseline_d), 0.5)
})

test_that("Follow-up effect size is large", {
  followup_d <- effect_sizes$Cohens_d[effect_sizes$Time == "Follow-up"]

  # Should show large effect at follow-up (d > 1.0)
  expect_gt(followup_d, 1.0)
})

# ==============================================================================
# Test 5-7: Effect Size Patterns
# ==============================================================================

test_that("Effect sizes increase over time", {
  # Should be monotonically increasing
  expect_true(effect_sizes$Cohens_d[2] > effect_sizes$Cohens_d[1])
  expect_true(effect_sizes$Cohens_d[3] > effect_sizes$Cohens_d[2])
})

test_that("ISTDP shows advantage over control at follow-up", {
  # All post-baseline effect sizes should favor ISTDP (positive d)
  post_baseline <- effect_sizes$Cohens_d[effect_sizes$Time != "Baseline"]

  expect_true(all(post_baseline > 0))
})

test_that("Follow-up effect size CI excludes zero", {
  followup_ci_lower <- effect_sizes$CI_lower[effect_sizes$Time == "Follow-up"]

  # Lower bound should be > 0 (significant effect)
  expect_gt(followup_ci_lower, 0)
})

# ==============================================================================
# Test 8-11: Estimated Marginal Means Validity
# ==============================================================================

test_that("EMMs are within valid scale range", {
  # Depression scale: 7-35
  expect_true(all(emm_summary$emmean >= 7))
  expect_true(all(emm_summary$emmean <= 35))
})

test_that("Standard errors are positive", {
  expect_true(all(emm_summary$SE > 0))
  expect_true(all(is.finite(emm_summary$SE)))
})

test_that("Confidence intervals are valid", {
  # Lower CL should be less than upper CL
  expect_true(all(emm_summary$lower.CL < emm_summary$upper.CL))

  # CIs should contain the estimate
  expect_true(all(emm_summary$emmean >= emm_summary$lower.CL))
  expect_true(all(emm_summary$emmean <= emm_summary$upper.CL))
})

test_that("Degrees of freedom are positive", {
  expect_true(all(emm_summary$df > 0))
  expect_true(all(is.finite(emm_summary$df)))
})

# ==============================================================================
# Test 12-15: Treatment Effects Direction
# ==============================================================================

test_that("ISTDP group shows depression decrease", {
  # Compare ISTDP baseline to follow-up
  istdp_baseline <- emm_summary$emmean[
    emm_summary$Tx_condition == "ISTDP" &
    emm_summary$Time == "Baseline"
  ]

  istdp_followup <- emm_summary$emmean[
    emm_summary$Tx_condition == "ISTDP" &
    emm_summary$Time == "Follow-up"
  ]

  # Should decrease (lower depression at follow-up)
  expect_true(istdp_followup < istdp_baseline)
})

test_that("Control group shows minimal change", {
  # Compare Control baseline to follow-up
  control_baseline <- emm_summary$emmean[
    emm_summary$Tx_condition == "Control" &
    emm_summary$Time == "Baseline"
  ]

  control_followup <- emm_summary$emmean[
    emm_summary$Tx_condition == "Control" &
    emm_summary$Time == "Follow-up"
  ]

  # Change should be small (< 3 points)
  expect_lt(abs(control_followup - control_baseline), 3)
})

test_that("ISTDP improvement is larger than control", {
  istdp_baseline <- emm_summary$emmean[
    emm_summary$Tx_condition == "ISTDP" &
    emm_summary$Time == "Baseline"
  ]
  istdp_followup <- emm_summary$emmean[
    emm_summary$Tx_condition == "ISTDP" &
    emm_summary$Time == "Follow-up"
  ]

  control_baseline <- emm_summary$emmean[
    emm_summary$Tx_condition == "Control" &
    emm_summary$Time == "Baseline"
  ]
  control_followup <- emm_summary$emmean[
    emm_summary$Tx_condition == "Control" &
    emm_summary$Time == "Follow-up"
  ]

  istdp_change <- istdp_baseline - istdp_followup
  control_change <- control_baseline - control_followup

  # ISTDP should show more improvement
  expect_true(istdp_change > control_change)
})

test_that("Groups do not differ significantly at baseline", {
  # Extract baseline EMMs
  baseline_emms <- emm_summary[emm_summary$Time == "Baseline", ]

  istdp_baseline <- baseline_emms$emmean[baseline_emms$Tx_condition == "ISTDP"]
  control_baseline <- baseline_emms$emmean[baseline_emms$Tx_condition == "Control"]

  # Difference should be small (< 2 points)
  expect_lt(abs(istdp_baseline - control_baseline), 2)
})

# ==============================================================================
# Test 16-18: Model Coefficients
# ==============================================================================

test_that("Fixed effects are finite", {
  fixed_effects <- fixef(model)

  expect_true(all(is.finite(fixed_effects)))
  expect_false(any(is.na(fixed_effects)))
})

test_that("p-values are between 0 and 1", {
  coef_summary <- coef(summary(model))
  p_values <- coef_summary[, "Pr(>|t|)"]

  expect_true(all(p_values >= 0))
  expect_true(all(p_values <= 1))
})

test_that("Time × Treatment interaction is significant", {
  coef_summary <- coef(summary(model))

  # Find interaction terms (any row with both Time and Tx_condition)
  interaction_rows <- grepl("Time", rownames(coef_summary)) &
                     grepl("Tx_condition", rownames(coef_summary))

  # At least one interaction should be significant (p < .05)
  if (any(interaction_rows)) {
    interaction_p <- coef_summary[interaction_rows, "Pr(>|t|)"]
    expect_true(any(interaction_p < 0.05))
  }
})

# ==============================================================================
# Test 19-20: Correlations and Associations
# ==============================================================================

test_that("Process-outcome correlations are in valid range", {
  # Calculate correlations between process and depression changes
  change_data <- data %>%
    filter(Tx_condition == "ISTDP", Time %in% c("Baseline", "Follow-up")) %>%
    dplyr::select(id, Time, Depression, PANAS_NA) %>%
    tidyr::pivot_wider(names_from = Time, values_from = c(Depression, PANAS_NA)) %>%
    mutate(
      dep_change = `Depression_Follow-up` - Depression_Baseline,
      panas_change = `PANAS_NA_Follow-up` - PANAS_NA_Baseline
    ) %>%
    filter(!is.na(dep_change) & !is.na(panas_change))

  if (nrow(change_data) > 10) {
    cor_result <- cor(change_data$dep_change, change_data$panas_change)

    # Correlation should be between -1 and 1
    expect_true(cor_result >= -1 && cor_result <= 1)
  }
})

test_that("Sample sizes are consistent across analyses", {
  # Number of observations should match
  expect_equal(nobs(model), nrow(data[!is.na(data$Depression), ]))
})
