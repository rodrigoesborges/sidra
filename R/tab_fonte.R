#' Obtenção de dados via API SIDRA - IBGE
#'
#' Esta função retorna a fontede uma das tabelas da SIDRA.
#' @param tabela Número da tabela.
#' @keywords IBGE SIDRA metadados fonte
#' @export
#' @examples
#' fonte_pam <- tab_fonte(1612)
#' tab_fonte(1612) # imprime os classificadores com sua descrição

tab_fonte <- function(tabela) {
  tab_meta(tabela)$pesquisa
}
