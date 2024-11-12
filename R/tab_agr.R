#' Obtenção de tabelas por agregado via API SIDRA - IBGE
#'
#' Esta função retorna uma lista com Todas as tabelas para  agregado indicado
#' @param agregado Número do agregado.
#' @keywords IBGE SIDRA dados variáveis
#' @export
#' @examples
#' tabs_a70 <- tab_agrs('A70')
#' tab_agrs('A70') # imprime os classificadores com sua descrição
#'
#'


## Função auxiliar
tab_agrs <- \(agregado) {
  baseag <- "https://servicodados.ibge.gov.br/api/v3/agregados"
  rc <- substr(agregado,1,1)
  x <- substr(agregado,2,nchar(agregado))
  rota <- sidra::agregados[sidra::agregados$id==rc,]$rota
  url <- paste0(baseag,"?",rota,"=",x)
  print(url)
  resp <- httr::content(httr::GET(url))
  pesquisas <- try(
    data.table::rbindlist(lapply(seq_along(resp),
                                 \(x) resp[[x]][c("id","nome")]),fill=T,use.names = F))
  tabelas <- try(
    data.table::rbindlist(lapply(seq_along(resp),
                                 \(x) resp[[x]]$agregados),fill=T,use.names = F))
  resp <- list(pesquisas=pesquisas,
               tabelas=tabelas)
  return(resp)
}
