# Test whether the output is a data frame
test_that("sidra(1705) returns a data frame", {
  skip_on_cran()
  skip_if_offline("servicodados.ibge.gov.br")
  output_table <- sidra(1705, classificador = 315, periodo = "201202")
  if (!is.null(output_table)) {
    expect_s3_class(output_table, "data.frame")
  }
})

# Tabelas sem classificacao (ex.: 6579, populacao residente estimada)
test_that("tabelas sem classificacao funcionam", {
  skip_on_cran()
  skip_if_offline("servicodados.ibge.gov.br")
  meta <- tab_meta(6579)
  expect_true(length(meta$periodos) > 0)
  expect_equal(length(meta$classificacoes), 0)

  output_table <- sidra(6579, nivel = "N6", variavel = 9324,
                        inicio = 2024, fim = 2024)
  if (nrow(output_table) > 0) {
    expect_s3_class(output_table, "data.frame")
    expect_true("valor" %in% names(output_table))
    expect_true(is.numeric(output_table$valor))
    expect_true(is.numeric(output_table$localidade_id))
  }
})

test_that("tab_niveis funciona em tabela sem classificacao", {
  skip_on_cran()
  skip_if_offline("servicodados.ibge.gov.br")
  nvl <- tab_niveis(6579)
  expect_true(is.data.frame(nvl))
  expect_true("N6" %in% nvl$nivel.id)
})
