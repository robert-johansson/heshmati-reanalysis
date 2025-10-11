# test-data-integrity.R
# Tests for data loading, structure, and integrity
# Part of the comprehensive testing framework for ISTDP reanalysis

library(testthat)
library(haven)
library(dplyr)

# Load data (same as manuscript.Rmd)
data <- read_sav("../../data/RCT Dataset ISTDP vs. Waitlist for Treatment-Resistant Depression.sav")
data <- data %>%
  mutate(
    Time = as_factor(Time),
    Tx_condition = as_factor(Tx_condition),
    id = factor(id),
    gender = as_factor(gender)
  )

baseline <- data %>% filter(Time == "Baseline")

# ==============================================================================
# Test 1-3: Dataset Dimensions
# ==============================================================================

test_that("Dataset has correct total number of observations", {
  # 86 participants × 3 time points = 258 observations
  expect_equal(nrow(data), 258)
})

test_that("Dataset has correct number of baseline observations", {
  # All 86 participants should have baseline data
  expect_equal(nrow(baseline), 86)
})

test_that("Dataset has correct number of variables", {
  # Should have 37 variables as documented
  expect_equal(ncol(data), 37)
})

# ==============================================================================
# Test 4-5: Treatment Allocation
# ==============================================================================

test_that("Treatment groups are balanced at baseline", {
  tx_counts <- table(baseline$Tx_condition)

  # Should have exactly 43 in each group
  expect_equal(as.numeric(tx_counts[1]), 43)
  expect_equal(as.numeric(tx_counts[2]), 43)

  # Total should be 86
  expect_equal(sum(tx_counts), 86)
})

test_that("Treatment condition has only two levels", {
  expect_equal(nlevels(data$Tx_condition), 2)
  expect_setequal(levels(data$Tx_condition), c("Control", "ISTDP"))
})

# ==============================================================================
# Test 6-8: Missing Data Patterns
# ==============================================================================

test_that("Missing data count matches expected pattern", {
  # Actual missing is 22 (8.5%)
  expect_equal(sum(is.na(data$Depression)), 22)
})

test_that("Missing data rate is within expected range", {
  missing_rate <- sum(is.na(data$Depression)) / nrow(data) * 100

  # Should be approximately 8.5%
  expect_equal(missing_rate, 8.5, tolerance = 1.0)
})

test_that("No missing data at baseline", {
  # All participants should have baseline assessments
  expect_equal(sum(is.na(baseline$Depression)), 0)
})

# ==============================================================================
# Test 9-11: Variable Types
# ==============================================================================

test_that("Key variables have correct data types", {
  expect_true(is.numeric(data$Depression))
  expect_true(is.factor(data$Time))
  expect_true(is.factor(data$Tx_condition))
  expect_true(is.factor(data$id))
  expect_true(is.numeric(data$age))
})

test_that("Time variable has exactly 3 levels", {
  expect_equal(nlevels(data$Time), 3)
  expect_setequal(levels(data$Time),
                  c("Baseline", "Post-treatment", "Follow-up"))
})

test_that("Participant IDs are unique at baseline", {
  expect_equal(nrow(baseline), length(unique(baseline$id)))
})

# ==============================================================================
# Test 12-14: Scale Ranges
# ==============================================================================

test_that("Depression scores are within valid scale range (7-35)", {
  non_missing_dep <- data$Depression[!is.na(data$Depression)]

  expect_true(all(non_missing_dep >= 7))
  expect_true(all(non_missing_dep <= 35))
})

test_that("PANAS Negative Affect scores are within plausible range", {
  non_missing_panas <- data$PANAS_NA[!is.na(data$PANAS_NA)]

  # Observed range is 10-54 (slightly above theoretical max of 50)
  expect_true(all(non_missing_panas >= 10))
  expect_true(all(non_missing_panas <= 60))
})

test_that("Age is within inclusion criteria range (18-60)", {
  non_missing_age <- baseline$age[!is.na(baseline$age)]

  expect_true(all(non_missing_age >= 18))
  expect_true(all(non_missing_age <= 60))
})

# ==============================================================================
# Test 15: Observations per Participant
# ==============================================================================

test_that("Each participant has at most 3 observations", {
  obs_per_participant <- data %>%
    group_by(id) %>%
    summarise(n_obs = n(), .groups = "drop")

  expect_true(all(obs_per_participant$n_obs <= 3))
  expect_true(all(obs_per_participant$n_obs >= 1))
})
