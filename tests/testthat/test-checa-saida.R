context("checa-saida")  # Script "test-checa-saida.R"
library(testthat)        # load testthat package
library(sidra)       # load our package


# Test whether the output is a data frame
test_that("sidra(1705) returns a data frame", {
  output_table <- sidra(1705)
  expect_is(output_table, "data.frame")
})
