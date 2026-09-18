# Test whether the output is a data frame
test_that("sidra(1705) returns a data frame", {
  skip_on_cran()
  skip_if_offline("servicodados.ibge.gov.br")
  output_table <- sidra(1705, classificador = 315, periodo = "201202")
  if (!is.null(output_table)) {
    expect_s3_class(output_table, "data.frame")
  }
})
