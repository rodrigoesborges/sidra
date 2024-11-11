#' Obtenção de dados via API SIDRA - IBGE
#'
#' Esta função retorna uma lista com variáveis de uma das tabelas da SIDRA.
#' @param tabela Número da tabela.
#' @keywords IBGE SIDRA dados variáveis
#' @export
#' @examples
#' vars_pam <- tab_vars(1612)
#' tab_vars(1612) # imprime os classificadores com sua descrição

tab_vars <- function(tabela) {
  tab_meta(tabela)$variaveis

}
