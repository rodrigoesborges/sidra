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

requireNamespace('readr')

agregados <- utils::read.csv("agregados.csv")

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

utils::write.csv(sidrameta, "inst/extdata/sidrameta.csv",row.names=F)
utils::write.csv(agregados, "inst/extdata/agregados.csv",row.names=F)

