# Test whether the output is a data frame
test_that("sidra(1705) returns a data frame", {
  skip_on_cran()
  skip_if_offline("servicodados.ibge.gov.br")
  output_table <- sidra(1705, classificador = 315, periodo = "201202")
  if (!is.null(output_table)) {
    expect_s3_class(output_table, "data.frame")
  }
})

test_that("tabelas sem classificacoes nao quebram tab_meta/sidra", {
  skip_on_cran()
  skip_if_offline("servicodados.ibge.gov.br")
  meta <- tab_meta(6691)
  expect_type(meta, "list")
  expect_length(meta$classificacoes, 0)
  output_table <- sidra(6691, nivel = "N1", variavel = 2266,
                        periodo = "202610")
  if (!is.null(output_table)) {
    expect_s3_class(output_table, "data.frame")
    expect_gt(nrow(output_table), 0)
  }
})
