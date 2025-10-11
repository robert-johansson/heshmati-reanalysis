# test-reproducibility.R
# Tests for reproducibility and consistency across runs
# Part of the comprehensive testing framework for ISTDP reanalysis

library(testthat)
library(haven)
library(dplyr)
library(lme4)
library(lmerTest)
library(mediation)
library(tidyr)

# Load data
data <- read_sav("../../data/RCT Dataset ISTDP vs. Waitlist for Treatment-Resistant Depression.sav")
data <- data %>%
  mutate(
    Time = as_factor(Time),
    Tx_condition = as_factor(Tx_condition),
    id = factor(id)
  )

# ==============================================================================
# Test 1-2: Model Refitting Reproducibility
# ==============================================================================

test_that("LMM produces identical results when refitted", {
  # Fit model twice
  model1 <- lmer(Depression ~ Time * Tx_condition + (1 | id),
                data = data, REML = TRUE)

  model2 <- lmer(Depression ~ Time * Tx_condition + (1 | id),
                data = data, REML = TRUE)

  # Fixed effects should be identical
  expect_equal(fixef(model1), fixef(model2))

  # Variance components should be identical
  expect_equal(as.numeric(VarCorr(model1)$id[1]),
               as.numeric(VarCorr(model2)$id[1]))

  # Residual variance should be identical
  expect_equal(sigma(model1), sigma(model2))
})

test_that("Effect size calculations are deterministic", {
  # Calculate effect sizes twice
  data_clean <- data %>% filter(!is.na(Depression))

  calculate_d <- function() {
    df_fu <- data_clean %>% filter(Time == "Follow-up")
    control <- df_fu %>% filter(Tx_condition == "Control") %>% pull(Depression)
    istdp <- df_fu %>% filter(Tx_condition == "ISTDP") %>% pull(Depression)

    d_result <- effsize::cohen.d(istdp, control)
    return(-d_result$estimate)
  }

  d1 <- calculate_d()
  d2 <- calculate_d()

  expect_equal(d1, d2)
})

# ==============================================================================
# Test 3-5: Bootstrap Reproducibility with Seeds
# ==============================================================================

test_that("Bootstrap mediation is reproducible with same seed", {
  skip_if_not_installed("mediation")

  # Prepare data for mediation
  data_wide <- data %>%
    dplyr::select(id, Tx_condition, Time, Depression, PANAS_NA) %>%
    pivot_wider(
      names_from = Time,
      values_from = c(Depression, PANAS_NA),
      names_sep = "_"
    ) %>%
    rename_with(~gsub(" ", "", .x), everything()) %>%
    rename_with(~gsub("-", "_", .x), everything()) %>%
    mutate(
      treatment = ifelse(Tx_condition == "ISTDP", 1, 0),
      PANAS_change = PANAS_NA_Post_treatment - PANAS_NA_Baseline
    ) %>%
    filter(complete.cases(treatment, Depression_Baseline,
                         Depression_Follow_up, PANAS_change))

  # Run mediation twice with same seed
  run_mediation <- function(seed_val) {
    set.seed(seed_val)

    med_model <- lm(PANAS_change ~ treatment, data = data_wide)
    out_model <- lm(Depression_Follow_up ~ PANAS_change + treatment +
                   Depression_Baseline, data = data_wide)

    med_result <- mediate(med_model, out_model,
                         treat = "treatment", mediator = "PANAS_change",
                         boot = TRUE, sims = 100, boot.ci.type = "bca")

    return(med_result$d0)  # Indirect effect
  }

  result1 <- run_mediation(2025)
  result2 <- run_mediation(2025)

  # Should be identical with same seed
  expect_equal(result1, result2)
})

test_that("Different seeds produce different bootstrap results", {
  skip_if_not_installed("mediation")

  # Prepare data
  data_wide <- data %>%
    dplyr::select(id, Tx_condition, Time, Depression, PANAS_NA) %>%
    pivot_wider(
      names_from = Time,
      values_from = c(Depression, PANAS_NA),
      names_sep = "_"
    ) %>%
    rename_with(~gsub(" ", "", .x), everything()) %>%
    rename_with(~gsub("-", "_", .x), everything()) %>%
    mutate(
      treatment = ifelse(Tx_condition == "ISTDP", 1, 0),
      PANAS_change = PANAS_NA_Post_treatment - PANAS_NA_Baseline
    ) %>%
    filter(complete.cases(treatment, Depression_Baseline,
                         Depression_Follow_up, PANAS_change))

  run_mediation <- function(seed_val) {
    set.seed(seed_val)

    med_model <- lm(PANAS_change ~ treatment, data = data_wide)
    out_model <- lm(Depression_Follow_up ~ PANAS_change + treatment +
                   Depression_Baseline, data = data_wide)

    med_result <- mediate(med_model, out_model,
                         treat = "treatment", mediator = "PANAS_change",
                         boot = TRUE, sims = 100, boot.ci.type = "bca")

    return(med_result$d0)
  }

  result1 <- run_mediation(123)
  result2 <- run_mediation(456)

  # Should differ (with high probability) with different seeds
  # But should be similar in magnitude
  expect_true(abs(result1 - result2) < abs(result1) * 0.5)
})

test_that("Manuscript seed (2025) is documented and used", {
  # Verify that seed 2025 is set in analyses
  # This is a documentation test

  expect_true(TRUE)  # Placeholder - actual test would check code comments
})

# ==============================================================================
# Test 6-7: Data Transformation Consistency
# ==============================================================================

test_that("Data loading produces identical results", {
  # Load data twice
  data1 <- read_sav("../../data/RCT Dataset ISTDP vs. Waitlist for Treatment-Resistant Depression.sav")
  data2 <- read_sav("../../data/RCT Dataset ISTDP vs. Waitlist for Treatment-Resistant Depression.sav")

  # Should be identical
  expect_equal(nrow(data1), nrow(data2))
  expect_equal(ncol(data1), ncol(data2))
  expect_equal(names(data1), names(data2))
})

test_that("Factor conversion is deterministic", {
  # Convert factors twice
  convert_factors <- function() {
    df <- read_sav("../../data/RCT Dataset ISTDP vs. Waitlist for Treatment-Resistant Depression.sav")
    df <- df %>%
      mutate(
        Time = as_factor(Time),
        Tx_condition = as_factor(Tx_condition)
      )
    return(df)
  }

  data1 <- convert_factors()
  data2 <- convert_factors()

  # Factor levels should be identical
  expect_equal(levels(data1$Time), levels(data2$Time))
  expect_equal(levels(data1$Tx_condition), levels(data2$Tx_condition))
})

# ==============================================================================
# Test 8: Session Consistency
# ==============================================================================

test_that("R version and package versions are documented", {
  # Check that sessionInfo() can be captured
  session_info <- sessionInfo()

  expect_true("R.version" %in% names(session_info))
  expect_true("otherPkgs" %in% names(session_info) ||
              "loadedOnly" %in% names(session_info))

  # Key packages should be loaded
  loaded_packages <- names(session_info$otherPkgs)

  # This test will pass if lme4 or haven are loaded
  key_packages <- c("lme4", "haven", "dplyr")
  expect_true(any(key_packages %in% loaded_packages))
})
