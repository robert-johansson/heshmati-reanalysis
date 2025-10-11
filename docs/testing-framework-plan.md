# Testing Framework Plan for Statistical Analyses

**Document created:** 2025-10-11
**Purpose:** Roadmap for implementing a comprehensive testing framework to validate statistical analyses in the ISTDP reanalysis manuscript.

---

## Table of Contents
1. [Why Testing Matters](#why-testing-matters)
2. [Current State Analysis](#current-state-analysis)
3. [Testing Framework Options](#testing-framework-options)
4. [What Should Be Tested](#what-should-be-tested)
5. [Implementation Plan](#implementation-plan)
6. [Example Test Code](#example-test-code)
7. [Resources](#resources)

---

## Why Testing Matters

Statistical analyses in research manuscripts often lack formal validation, leading to:
- **Undetected errors** in data transformations or model specifications
- **Non-reproducible results** due to random seed issues or software version changes
- **Difficult debugging** when reviewers question results
- **Low confidence** in published findings

A testing framework provides:
- ✅ **Automatic error detection** before submission
- ✅ **Reproducibility guarantees** across environments
- ✅ **Documentation** of expected behavior
- ✅ **Confidence** in results accuracy
- ✅ **Easier collaboration** with clear validation

---

## Current State Analysis

### ✅ What's Good
- Seed is set (`set.seed(2025)`) for reproducible bootstrap
- All analyses in single `.Rmd` file (reproducible)
- Clear data transformations
- Comprehensive documentation in Methods section

### ❌ What's Missing
- No formal unit tests
- No validation against original study results
- No automated checks for data integrity
- No regression tests to catch breaking changes
- No CI/CD pipeline for continuous validation

---

## Testing Framework Options

### Option 1: Lightweight Testing (Quick Start)
**Description:** Add simple `stopifnot()` assertions directly in `manuscript.Rmd`

**Pros:**
- Quick to implement (1-2 hours)
- No new dependencies
- Runs automatically every time you knit
- Easy to understand

**Cons:**
- Limited functionality
- Not comprehensive
- Harder to organize as tests grow
- No test reports

**When to use:** Small projects, quick validation, proof of concept

---

### Option 2: testthat Framework (Gold Standard)
**Description:** Full R testing framework with dedicated test files in `tests/` directory

**Pros:**
- Industry standard for R packages
- Comprehensive test organization
- Detailed test reports
- CI/CD compatible
- Expectation syntax is readable
- Test coverage metrics available

**Cons:**
- More setup required (3-4 hours)
- Requires learning testthat syntax
- Need to run tests separately from knitting

**When to use:** Research projects intended for publication, when reproducibility is critical

---

### Option 3: Hybrid Approach (Recommended)
**Description:** Combine lightweight assertions in manuscript + comprehensive testthat suite

**Pros:**
- Best of both worlds
- Critical checks run during knitting
- Comprehensive validation available on demand
- Gradual implementation (start light, add comprehensive)

**Cons:**
- Some duplication of tests
- Need to maintain both

**When to use:** High-stakes research projects, manuscripts for top-tier journals

---

## What Should Be Tested

### 1. Data Integrity Tests (15 tests)

**Purpose:** Verify data loads correctly and matches expected structure

**Tests:**
```r
✓ Dataset loads without errors
✓ N = 86 participants (43 ISTDP, 43 Control)
✓ Total observations = 258 (86 × 3 time points)
✓ Missing observations = 33 (12.8%)
✓ Depression variable is numeric
✓ Time is factor with 3 levels
✓ Treatment condition is factor with 2 levels
✓ No unexpected NA patterns
✓ All variable names present as expected
✓ Participant IDs are unique
✓ Each participant has ≤ 3 observations
✓ Time points are Baseline, Post-treatment, Follow-up
✓ Treatment conditions are ISTDP, Control
✓ Baseline observations = 86 (no missing)
✓ Age range is 18-60 (per inclusion criteria)
```

---

### 2. Transformation Accuracy Tests (10 tests)

**Purpose:** Verify variable coding and transformations are correct

**Tests:**
```r
✓ Time_numeric: 0 for Baseline, 1 for Post, 2 for Follow-up
✓ Treatment coding: 0 for Control, 1 for ISTDP
✓ Factor levels in correct order
✓ Change scores = Follow-up - Baseline
✓ Wide format has expected columns
✓ No data lost in pivot operations
✓ WAI_RRC calculated correctly (Restraint/3 + Repression)
✓ Process measures in expected range
✓ Depression scores between 7-35 (scale range)
✓ PANAS scores between 10-50 (scale range)
```

---

### 3. Statistical Model Validity Tests (12 tests)

**Purpose:** Check that models are specified correctly and converge

**Tests:**
```r
✓ LMM converges without warnings
✓ Random effects structure is (1 | id)
✓ Fixed effects include Time, Treatment, Time×Treatment
✓ REML estimation used
✓ Degrees of freedom > 0
✓ Variance components > 0
✓ Residuals approximately normal (Shapiro-Wilk p > .01)
✓ No extreme outliers (|residuals| < 4 SD)
✓ Homogeneity of variance (Levene p > .05)
✓ Bootstrap mediation uses 5000 resamples
✓ Cross-lagged models include autoregressive terms
✓ All models control for baseline depression
```

---

### 4. Results Validation Tests (20 tests)

**Purpose:** Verify statistical results are in plausible ranges

**Tests:**
```r
✓ All p-values between 0 and 1
✓ All confidence intervals have lower < upper
✓ Effect sizes (d) between -5 and 5
✓ Cohen's d at baseline ≈ 0 (groups balanced)
✓ Cohen's d at follow-up > 1.0 (large effect expected)
✓ Correlations between -1 and 1
✓ Proportion mediated between 0 and 1
✓ Standard errors > 0
✓ Sample sizes match for each analysis
✓ Degrees of freedom reasonable (not > N)
✓ Bootstrap CIs don't include impossible values
✓ EMMs in plausible range for scales
✓ Depression decreases in ISTDP group
✓ Depression stable in waitlist group
✓ Process measures show expected directions
✓ ISTDP > Control for all effect sizes
✓ No effect size CIs entirely below 0
✓ Indirect effects sum to total effect (mediation)
✓ Cross-lagged coefficients are standardized
✓ All Time × Treatment interactions p < .05
```

---

### 5. Reproducibility Tests (8 tests)

**Purpose:** Ensure analyses produce identical results across runs

**Tests:**
```r
✓ Same seed → same bootstrap results (mediation)
✓ Re-running produces identical effect sizes
✓ Figures regenerate identically
✓ Tables have same values across runs
✓ Random effects same with same seed
✓ Model summaries identical
✓ Saved workspace loads correctly
✓ Session info documents package versions
```

---

### 6. Comparison with Original Study (10 tests)

**Purpose:** Cross-validate against published results (Heshmati et al., 2023)

**Tests:**
```r
✓ Baseline depression means within ±1 of published
✓ Baseline age M ≈ 36.9, SD ≈ 11.7
✓ Gender: ~62% female
✓ Medication: ~79% currently receiving
✓ Previous trials: M ≈ 1.8
✓ Depression decreases in ISTDP (matches original)
✓ Waitlist shows minimal change (matches original)
✓ Effect sizes similar magnitude (±0.3)
✓ Dropout rates: ISTDP ~14%, Waitlist ~12%
✓ Missing data pattern matches (12.8% total)
```

---

### 7. Assumption Checks (8 tests)

**Purpose:** Verify statistical assumptions are met

**Tests:**
```r
✓ Normality: Shapiro-Wilk test on residuals (p > .01)
✓ Homogeneity: Levene's test (p > .05)
✓ Independence: No autocorrelation in residuals
✓ Linearity: Residuals vs. fitted shows no pattern
✓ No multicollinearity: VIF < 5
✓ Missing data: Little's MCAR test documented
✓ Outliers: Cook's D < 1 for all observations
✓ Sample size adequate: Power > .80 for main effects
```

---

## Implementation Plan

### Phase 1: Lightweight Assertions (1-2 hours)

**Goal:** Add critical inline checks to `manuscript.Rmd`

**Tasks:**
1. After `load-data` chunk, add:
   ```r
   # Validate data structure
   stopifnot(nrow(baseline) == 86)
   stopifnot(nrow(data) == 258)
   stopifnot(sum(is.na(data$Depression)) == 33)
   ```

2. After each LMM, add:
   ```r
   # Check model convergence
   stopifnot(length(model_final@optinfo$conv$lme4$messages) == 0)
   ```

3. After effect size calculations:
   ```r
   # Sanity check effect sizes
   stopifnot(all(effect_sizes$Cohens_d > -5 & effect_sizes$Cohens_d < 5))
   stopifnot(effect_sizes$Cohens_d[3] > 1.0)  # Large effect at follow-up
   ```

**Deliverable:** Enhanced `manuscript.Rmd` with 15-20 inline assertions

---

### Phase 2: testthat Framework (3-4 hours)

**Goal:** Create comprehensive test suite

**File Structure:**
```
tests/
├── testthat/
│   ├── test-data-integrity.R       # 15 tests
│   ├── test-transformations.R      # 10 tests
│   ├── test-models.R               # 12 tests
│   ├── test-results.R              # 20 tests
│   ├── test-reproducibility.R      # 8 tests
│   └── test-original-comparison.R  # 10 tests
├── testthat.R                      # Test runner
└── fixtures/
    └── expected-results.rds        # Saved regression baseline
```

**Tasks:**

1. **Setup** (30 min)
   ```r
   # Install testthat
   install.packages("testthat")

   # Create directory structure
   usethis::use_testthat()
   ```

2. **Write test files** (2 hours)
   - Start with `test-data-integrity.R`
   - Add `test-transformations.R`
   - Add `test-models.R`
   - Add `test-results.R`
   - Add `test-reproducibility.R`
   - Add `test-original-comparison.R`

3. **Create test runner script** (30 min)
   ```r
   # check-analyses.R
   library(testthat)
   test_dir("tests/testthat")
   ```

4. **Document** (1 hour)
   - Write `docs/testing.md` with usage instructions
   - Update README.md with testing section
   - Add comments to test files

**Deliverable:** Complete test suite with ~75 tests

---

### Phase 3: Continuous Integration (1-2 hours)

**Goal:** Automate testing with GitHub Actions

**Tasks:**

1. Create `.github/workflows/test-analyses.yml`:
   ```yaml
   name: Test Statistical Analyses

   on: [push, pull_request]

   jobs:
     test:
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v2
         - uses: r-lib/actions/setup-r@v2
         - name: Install dependencies
           run: |
             install.packages(c("testthat", "haven", "dplyr",
                              "lme4", "lmerTest", "emmeans",
                              "mediation", "effsize"))
         - name: Run tests
           run: Rscript tests/testthat.R
   ```

2. Add test badge to README.md
3. Configure to run on every commit

**Deliverable:** Automated testing on every push

---

## Example Test Code

### Data Integrity Test Example

**File:** `tests/testthat/test-data-integrity.R`

```r
library(testthat)
library(haven)
library(dplyr)

# Load data
data <- read_sav("data/RCT Dataset ISTDP vs. Waitlist for Treatment-Resistant Depression.sav")

test_that("Dataset has correct dimensions", {
  # Total observations
  expect_equal(nrow(data), 258)

  # Participants per condition
  baseline <- data %>% filter(as_factor(Time) == "Baseline")
  expect_equal(nrow(baseline), 86)

  istdp_count <- sum(as_factor(baseline$Tx_condition) == "ISTDP")
  control_count <- sum(as_factor(baseline$Tx_condition) == "Control")

  expect_equal(istdp_count, 43)
  expect_equal(control_count, 43)
})

test_that("Missing data pattern is as expected", {
  expect_equal(sum(is.na(data$Depression)), 33)

  # Missing rate should be 12.8%
  missing_rate <- sum(is.na(data$Depression)) / nrow(data) * 100
  expect_equal(missing_rate, 12.8, tolerance = 0.1)
})

test_that("Variables have correct types", {
  data <- data %>%
    mutate(
      Time = as_factor(Time),
      Tx_condition = as_factor(Tx_condition)
    )

  expect_true(is.numeric(data$Depression))
  expect_true(is.factor(data$Time))
  expect_true(is.factor(data$Tx_condition))
  expect_equal(nlevels(data$Time), 3)
  expect_equal(nlevels(data$Tx_condition), 2)
})

test_that("Scale ranges are plausible", {
  # Depression (WAI): 7-35
  expect_true(all(data$Depression >= 7 | is.na(data$Depression)))
  expect_true(all(data$Depression <= 35 | is.na(data$Depression)))

  # PANAS Negative Affect: 10-50
  expect_true(all(data$PANAS_NA >= 10 | is.na(data$PANAS_NA)))
  expect_true(all(data$PANAS_NA <= 50 | is.na(data$PANAS_NA)))
})
```

---

### Model Validity Test Example

**File:** `tests/testthat/test-models.R`

```r
library(testthat)
library(lme4)
library(lmerTest)

test_that("LMM converges without errors", {
  # Fit model
  model <- lmer(Depression ~ Time * Tx_condition + (1 | id),
                data = data, REML = TRUE)

  # Check convergence
  expect_length(model@optinfo$conv$lme4$messages, 0)

  # Check variance components are positive
  vc <- VarCorr(model)
  expect_true(all(as.numeric(vc) > 0))

  # Check residual variance is positive
  expect_true(sigma(model)^2 > 0)
})

test_that("Model has correct structure", {
  model <- lmer(Depression ~ Time * Tx_condition + (1 | id),
                data = data, REML = TRUE)

  # Check fixed effects
  fixed_names <- names(fixef(model))
  expect_true("(Intercept)" %in% fixed_names)
  expect_true(any(grepl("Time", fixed_names)))
  expect_true(any(grepl("Tx_condition", fixed_names)))

  # Check random effects
  random_names <- names(ranef(model))
  expect_equal(random_names, "id")
})

test_that("Model assumptions are reasonably met", {
  model <- lmer(Depression ~ Time * Tx_condition + (1 | id),
                data = data, REML = TRUE)

  # Extract residuals
  resids <- residuals(model)

  # Shapiro-Wilk test for normality (p > .01 acceptable)
  shapiro_result <- shapiro.test(sample(resids, size = min(length(resids), 5000)))
  expect_gt(shapiro_result$p.value, 0.01)

  # Check for extreme outliers (|z| > 4)
  z_scores <- scale(resids)
  expect_lt(sum(abs(z_scores) > 4), length(resids) * 0.01)  # < 1% outliers
})
```

---

### Reproducibility Test Example

**File:** `tests/testthat/test-reproducibility.R`

```r
library(testthat)
library(mediation)

test_that("Bootstrap mediation is reproducible with seed", {
  # First run
  set.seed(2025)
  med_model1 <- lm(M ~ treatment, data = data_wide_med)
  out_model1 <- lm(Y ~ M + treatment + C, data = data_wide_med)
  result1 <- mediate(med_model1, out_model1,
                     treat = "treatment", mediator = "M",
                     boot = TRUE, sims = 1000, boot.ci.type = "bca")

  # Second run with same seed
  set.seed(2025)
  med_model2 <- lm(M ~ treatment, data = data_wide_med)
  out_model2 <- lm(Y ~ M + treatment + C, data = data_wide_med)
  result2 <- mediate(med_model2, out_model2,
                     treat = "treatment", mediator = "M",
                     boot = TRUE, sims = 1000, boot.ci.type = "bca")

  # Should be identical
  expect_equal(result1$d0, result2$d0, tolerance = 1e-10)
  expect_equal(result1$d0.ci, result2$d0.ci, tolerance = 1e-10)
})

test_that("Results match saved regression baseline", {
  # Load expected results
  expected <- readRDS("tests/fixtures/expected-results.rds")

  # Run current analysis
  current <- run_all_analyses()  # Helper function

  # Compare key statistics
  expect_equal(current$depression_d_followup,
               expected$depression_d_followup,
               tolerance = 0.01)

  expect_equal(current$mediation_indirect,
               expected$mediation_indirect,
               tolerance = 0.01)
})
```

---

### Original Study Comparison Test Example

**File:** `tests/testthat/test-original-comparison.R`

```r
library(testthat)

test_that("Baseline demographics match original study", {
  # From Heshmati et al. (2023): Mean age = 36.9, SD = 11.7
  baseline_age <- baseline %>%
    summarise(M = mean(age, na.rm = TRUE),
              SD = sd(age, na.rm = TRUE))

  expect_equal(baseline_age$M, 36.9, tolerance = 1.0)
  expect_equal(baseline_age$SD, 11.7, tolerance = 1.0)

  # Gender: ~62% female
  female_pct <- sum(baseline$gender == "female") / nrow(baseline) * 100
  expect_equal(female_pct, 62, tolerance = 5)

  # Medication: ~79% currently receiving
  med_pct <- sum(baseline$medicationreceiving == "yes") / nrow(baseline) * 100
  expect_equal(med_pct, 79, tolerance = 5)
})

test_that("Treatment effects match original direction", {
  # ISTDP should show decrease
  istdp_change <- data %>%
    filter(Tx_condition == "ISTDP", Time %in% c("Baseline", "Follow-up")) %>%
    group_by(id) %>%
    summarise(change = Depression[Time == "Follow-up"] - Depression[Time == "Baseline"],
              .groups = "drop")

  expect_true(mean(istdp_change$change, na.rm = TRUE) < 0)  # Decrease

  # Effect size should be large (d > 1.0) at follow-up
  # (Original study found very large effects)
  effect_size <- cohen.d(istdp_followup, control_followup)
  expect_gt(abs(effect_size$estimate), 1.0)
})
```

---

## Running Tests

### Quick Check (During Development)
```r
# In RStudio console
source("tests/testthat.R")
```

### Full Test Suite
```bash
# In terminal
Rscript -e "testthat::test_dir('tests/testthat')"
```

### With Coverage Report
```r
# Requires covr package
library(covr)
coverage <- package_coverage(type = "tests")
report(coverage)
```

### Continuous Integration
Tests run automatically on every GitHub push via Actions workflow.

---

## Best Practices

### 1. Test-Driven Development
- Write tests BEFORE making changes
- Ensures changes don't break existing analyses
- Documents expected behavior

### 2. Keep Tests Fast
- Use smaller bootstrap samples in tests (1000 vs 5000)
- Cache expensive computations
- Run full tests before submission only

### 3. Descriptive Test Names
```r
# Good
test_that("Depression effect size at follow-up is large (d > 1.0)", { ... })

# Bad
test_that("effect size test", { ... })
```

### 4. One Assertion Per Test (When Possible)
```r
# Easier to debug failures
test_that("Sample size is correct", {
  expect_equal(nrow(data), 258)
})

test_that("Missing data count is correct", {
  expect_equal(sum(is.na(data$Depression)), 33)
})
```

### 5. Use Tolerance for Floating Point
```r
# Good - accounts for rounding
expect_equal(result, 0.123, tolerance = 0.001)

# Bad - may fail due to precision
expect_equal(result, 0.123)
```

---

## Benefits for Publication

### For Authors
- ✅ Confidence in results accuracy
- ✅ Easy to respond to reviewer questions
- ✅ Reproducibility guaranteed
- ✅ Faster debugging of issues

### For Reviewers
- ✅ Transparent validation process
- ✅ Can verify claims programmatically
- ✅ Clear documentation of checks

### For Readers
- ✅ Trustworthy findings
- ✅ Replicable analyses
- ✅ Open science best practices

---

## Resources

### testthat Documentation
- Package website: https://testthat.r-lib.org/
- Hadley Wickham's R Packages book: https://r-pkgs.org/testing-basics.html

### Examples in Research
- `rOpenSci` packages: https://github.com/ropensci
- `tidyverse` testing practices: https://github.com/tidyverse

### Related Tools
- `covr`: Test coverage reports
- `assertthat`: Runtime assertions
- `checkmate`: Fast argument checks
- `pointblank`: Data validation

---

## Time Estimates

| Phase | Task | Time |
|-------|------|------|
| **Phase 1** | Lightweight assertions | 1-2 hours |
| **Phase 2** | testthat framework | 3-4 hours |
| **Phase 3** | GitHub Actions CI | 1-2 hours |
| **Total** | Full implementation | **5-8 hours** |

---

## Priority Assessment

**Recommendation:** **HIGH PRIORITY** for publication

**Rationale:**
1. Manuscript has advanced statistical analyses (mediation, cross-lagged)
2. Bootstrap methods involve randomness (need reproducibility checks)
3. Multiple transformations increase error risk
4. Reviewers will scrutinize methods carefully
5. Testing framework adds credibility to findings

---

## Next Steps

1. ✅ Review this plan
2. ⬜ Decide on approach (lightweight, full testthat, or hybrid)
3. ⬜ Implement Phase 1 (quick wins)
4. ⬜ Implement Phase 2 (comprehensive)
5. ⬜ Set up CI/CD (optional but recommended)
6. ⬜ Document testing in manuscript supplementary materials
7. ⬜ Add testing badge to README

---

**Document maintained by:** Claude Code
**Last updated:** 2025-10-11
