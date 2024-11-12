#' Obtenção de dados via API SIDRA - IBGE
#'
#' Esta função retorna a fontede uma das tabelas da SIDRA.
#' @param tabela Número da tabela.
#' @keywords IBGE SIDRA metadados fonte
#' @export
#' @examples
#' fonte_ipcaq <- tab_fonte(1705)
#' tab_fonte(1705) # imprime os classificadores com sua descrição

tab_fonte <- function(tabela) {
  tab_meta(tabela)$pesquisa
}
