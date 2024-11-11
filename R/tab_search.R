#' Busca de tabelas/agregados ou variáveis via API SIDRA - IBGE
#'
#' Esta função retorna uma lista com agregados, tabelas ou variáveis da SIDRA
#' que possuem o termo buscado.
#' @param termo Termo.
#' @keywords IBGE SIDRA dados search
#' @export
#' @examples
#' class_pam <- tab_class(1612)
#' tab_class(1612) # imprime os classificadores com sua descrição

tab_search <- function(termo) {
  df <- sidra::sidrameta
  resp <- df[grepl(termo,df[[2]],ignore.case=T)|grepl(termo,df[[4]],ignore.case=T),c("id","literal","agregacao")]|>
    dplyr::arrange(id)
  resp[[3]] <- resp[[3]]=="V"
  names(resp) <- c("ID do Agregado/Tabela","Descrição","Variável")
  resp
}
