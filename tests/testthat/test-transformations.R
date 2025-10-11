# test-transformations.R
# Tests for variable transformations, coding, and derived variables
# Part of the comprehensive testing framework for ISTDP reanalysis

library(testthat)
library(haven)
library(dplyr)
library(tidyr)

# Load and transform data (same as manuscript.Rmd)
data <- read_sav("../../data/RCT Dataset ISTDP vs. Waitlist for Treatment-Resistant Depression.sav")
data <- data %>%
  mutate(
    Time = as_factor(Time),
    Tx_condition = as_factor(Tx_condition),
    id = factor(id),
    Time_numeric = case_when(
      Time == "Baseline" ~ 0,
      Time == "Post-treatment" ~ 1,
      Time == "Follow-up" ~ 2
    )
  )

# ==============================================================================
# Test 1-3: Time Variable Coding
# ==============================================================================

test_that("Time_numeric is correctly coded", {
  # Check coding for each level
  baseline_numeric <- data %>%
    filter(Time == "Baseline") %>%
    pull(Time_numeric) %>%
    unique()

  post_numeric <- data %>%
    filter(Time == "Post-treatment") %>%
    pull(Time_numeric) %>%
    unique()

  followup_numeric <- data %>%
    filter(Time == "Follow-up") %>%
    pull(Time_numeric) %>%
    unique()

  expect_equal(baseline_numeric, 0)
  expect_equal(post_numeric, 1)
  expect_equal(followup_numeric, 2)
})

test_that("Time factor levels are in correct order", {
  expect_equal(levels(data$Time),
               c("Baseline", "Post-treatment", "Follow-up"))
})

test_that("Time_numeric has only 3 unique values", {
  expect_equal(length(unique(data$Time_numeric)), 3)
  expect_setequal(unique(data$Time_numeric), c(0, 1, 2))
})

# ==============================================================================
# Test 4-5: Treatment Coding
# ==============================================================================

test_that("Treatment condition is correctly factorized", {
  expect_true(is.factor(data$Tx_condition))
  expect_equal(nlevels(data$Tx_condition), 2)
})

test_that("Treatment factor levels are named correctly", {
  # Should be "Control" and "ISTDP" (or similar)
  tx_levels <- levels(data$Tx_condition)

  expect_length(tx_levels, 2)
  expect_true("ISTDP" %in% tx_levels || "Treatment" %in% tx_levels)
  expect_true("Control" %in% tx_levels || "Waitlist" %in% tx_levels)
})

# ==============================================================================
# Test 6-7: Change Scores
# ==============================================================================

test_that("Change scores can be calculated without errors", {
  # Test creating change scores (baseline to follow-up)
  change_data <- data %>%
    filter(Time %in% c("Baseline", "Follow-up")) %>%
    dplyr::select(id, Time, Depression) %>%
    pivot_wider(names_from = Time, values_from = Depression) %>%
    mutate(change = `Follow-up` - Baseline)

  expect_true("change" %in% names(change_data))
  expect_true(is.numeric(change_data$change))
})

test_that("Change scores have correct direction for ISTDP group", {
  # ISTDP group should show negative change (improvement)
  change_data <- data %>%
    filter(Time %in% c("Baseline", "Follow-up"), Tx_condition == "ISTDP") %>%
    dplyr::select(id, Time, Depression) %>%
    pivot_wider(names_from = Time, values_from = Depression) %>%
    mutate(change = `Follow-up` - Baseline) %>%
    filter(!is.na(change))

  # Mean change should be negative (depression decreased)
  expect_true(mean(change_data$change, na.rm = TRUE) < 0)
})

# ==============================================================================
# Test 8: Wide Format Conversion
# ==============================================================================

test_that("Data can be converted to wide format without loss", {
  # Convert to wide
  data_wide <- data %>%
    dplyr::select(id, Tx_condition, Time, Depression) %>%
    pivot_wider(
      names_from = Time,
      values_from = Depression,
      names_prefix = "Depression_"
    )

  # Should have one row per participant
  expect_equal(nrow(data_wide), 86)

  # Should have depression columns for each time point
  expect_true("Depression_Baseline" %in% names(data_wide))
  expect_true("Depression_Post-treatment" %in% names(data_wide) ||
              "Depression_Post.treatment" %in% names(data_wide))
})

# ==============================================================================
# Test 9: WAI Repressive/Restraint Composite
# ==============================================================================

test_that("WAI_RRC composite score is present and numeric", {
  # Check if WAI_RRC exists in the dataset
  expect_true("WAI_RRC" %in% names(data))
  expect_true(is.numeric(data$WAI_RRC))
})

test_that("WAI_RRC has plausible values", {
  # Composite should have reasonable range
  non_missing_rrc <- data$WAI_RRC[!is.na(data$WAI_RRC)]

  expect_true(all(non_missing_rrc >= 0))
  expect_true(all(non_missing_rrc <= 200))  # Generous upper bound
})
