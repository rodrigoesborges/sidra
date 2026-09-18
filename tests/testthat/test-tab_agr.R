test_that(
  "function tab_agr returns what is expected",{
    skip_on_cran()
    skip_if_offline("servicodados.ibge.gov.br")
    output <- tab_agr("A70")
    if (!is.null(output)) {
      expect_s3_class(output$tabelas, "data.frame")
    }
  }
)
