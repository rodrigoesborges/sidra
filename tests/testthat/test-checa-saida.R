# context("checa-saida")  # Script "test-checa-saida.R"
library(testthat)        # load testthat package
library(sidra)       # load our package


# Test whether the output is a data frame
test_that("sidra(1705) returns a data frame", {
  output_table <- sidra(1705)
  if(is.null(sidra:::call_ibge({httr::GET('https://servicodados.ibge.gov.br/api/v3/agregados')}))) {
    expect_null(output_table)
  } else {
  expect_type(output_table, "data.frame")
  succeed("API was reachable and a data.frame was returned.")
}})
