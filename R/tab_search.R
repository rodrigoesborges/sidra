#' Busca de tabelas/agregados ou variáveis via API SIDRA - IBGE
#'
#' Esta função retorna uma lista com agregados, tabelas ou variáveis da SIDRA
#' que possuem o termo buscado.
#' @param termo Termo.
#' @keywords IBGE SIDRA dados search
#' @importFrom dplyr arrange
#' @export
#'
#' @examples
#' tabs_ipca <- tab_search('IPCA15')
#' tab_search('IPCA15') # imprime tabelas/agregados/variáveis com o termo pesquisado.

tab_search <- function(termo) {
  df <- sidra::sidrameta
  resp <- df[grepl(termo,df[[2]],ignore.case=T)|grepl(termo,df[[4]],ignore.case=T),c("id","literal","agregacao")]|>
    dplyr::arrange("id")
  resp[[3]] <- resp[[3]]=="V"
  names(resp) <- c("ID do Agregado/Tabela","Descri\u00e7\u00e3o","Vari\u00e1vel")
  resp
}
