# testthat.R
# Main test runner for the ISTDP reanalysis testing framework
# This file is automatically detected by testthat when running tests

library(testthat)

# Set working directory to project root
# (testthat runs from the tests/ directory by default)
setwd("../..")

# Run all tests in tests/testthat/
test_check("heshmati-reanalysis",
           reporter = "progress")
