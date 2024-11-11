#' API servicodados.ibge ... Todos agregados disponíveis
#'
#' Para utilização inicial, base com todos agregados disponíveis
#'
#' @docType data
#' @usage data(agregados)
#' @usage data(sidrameta)
#'
#' @keywords metadados,agregados
#'
#' @source \href{https://servicodados.ibge.gov.br/api/v3/agregados/}{IBGE API}
#'
#' @examples
#' data(agregados)
#'
"agregados"

#available metadata sidra
library(rvest)

agregados <- tibble::tribble(~id, ~agregado,~rota,
                             "A","Assunto","assunto",
                             "C","Classificação","classificacao",
                             "N","Nível geográfico","nivel",
                             "P","Período","periodo",
                             "E","Periodicidade","periodicidade",
                             "V","Variável","variaveis"
)

agregacao <- \(x="A"){
  baseag <- "https://servicodados.ibge.gov.br/api/v3/agregados"
  resp <- httr::GET(paste0(baseag,"?acervo=",x))
  conteudo <- httr::content(resp)
  agregado <- data.table::rbindlist(lapply(1:length(conteudo),\(x) as.data.frame(conteudo[[x]])))
  agregado$agregacao <- x
  agregado
}

lista_agregados <- lapply(agregados$id,agregacao)
names(lista_agregados) <- agregados$agregado
sidrameta <- data.table::rbindlist(lista_agregados)

dir.create("inst/extdata",showWarnings = F,recursive = T)

readr::write_csv(sidrameta, "inst/extdata/sidrameta.csv")
readr::write_csv(agregados, "inst/extdata/agregados.csv")

usethis::use_data(sidrameta, overwrite = TRUE)
usethis::use_data(agregados, overwrite = TRUE)
