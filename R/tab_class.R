#' Obtenção de dados via API SIDRA - IBGE
#'
#' Esta função retorna uma lista com classificadores de uma das tabelas da SIDRA.
#' @param tabela Número da tabela.
#' @keywords IBGE SIDRA dados classificadores
#' @export
#' @examples
#' class_pam <- tab_class(1612)
#' tab_class(1612) # imprime os classificadores com sua descrição

tab_class <- function(tabela) {
  tab_meta(tabela)$classificacoes

}
