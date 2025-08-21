
test_that(
  "function tab_agr returns what is expected",{
    output_table <- tab_agr('A70')
    if(is.null(call_ibge({httr::GET('https://servicodados.ibge.gov.br/api/v3/agregados',config = httr::timeout(2))}))) {
      expect_null(output_table,info = "API was not reacheable,
                function should have returned NULL")

    } else {
      expect_type(output_table, "data.frame")
      succeed("API was reachable and a data.frame was returned.")
    }
  }
)
