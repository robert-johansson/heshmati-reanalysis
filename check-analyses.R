#!/usr/bin/env Rscript
# check-analyses.R
# Standalone script to run all statistical analysis tests
# Usage: Rscript check-analyses.R

cat("╔══════════════════════════════════════════════════════════════════════╗\n")
cat("║  ISTDP Reanalysis - Statistical Analysis Test Suite                 ║\n")
cat("║  Running comprehensive validation tests...                           ║\n")
cat("╚══════════════════════════════════════════════════════════════════════╝\n\n")

# Check for required packages
required_packages <- c("testthat", "haven", "dplyr", "lme4", "lmerTest",
                      "emmeans", "effsize", "mediation")

missing_packages <- required_packages[!sapply(required_packages,
                                              requireNamespace,
                                              quietly = TRUE)]

if (length(missing_packages) > 0) {
  cat("❌ Missing required packages:", paste(missing_packages, collapse = ", "), "\n")
  cat("   Install with: install.packages(c('", paste(missing_packages, collapse = "', '"), "'))\n\n")
  quit(status = 1)
}

# Load testthat
library(testthat)

cat("✓ All required packages are installed\n\n")

# Run all tests
cat("Running test suite...\n")
cat(rep("─", 70), "\n\n", sep = "")

test_results <- test_dir("tests/testthat",
                        reporter = "progress",
                        stop_on_failure = FALSE)

cat("\n")
cat(rep("─", 70), "\n", sep = "")

# Print summary
n_tests <- length(test_results)
n_passed <- sum(sapply(test_results, function(x) length(x$results) > 0 &&
                      all(sapply(x$results, function(r) !inherits(r, "expectation_failure")))))
n_failed <- n_tests - n_passed

cat("\n")
cat("╔══════════════════════════════════════════════════════════════════════╗\n")
cat("║  TEST SUMMARY                                                        ║\n")
cat("╠══════════════════════════════════════════════════════════════════════╣\n")
cat(sprintf("║  Total test files:  %-47d ║\n", n_tests))
cat(sprintf("║  Passed:            %-47d ║\n", n_passed))
cat(sprintf("║  Failed:            %-47d ║\n", n_failed))
cat("╚══════════════════════════════════════════════════════════════════════╝\n\n")

# Exit with appropriate code
if (n_failed > 0) {
  cat("❌ Some tests failed. Review output above for details.\n\n")
  quit(status = 1)
} else {
  cat("✅ All tests passed! Statistical analyses are validated.\n\n")
  quit(status = 0)
}
