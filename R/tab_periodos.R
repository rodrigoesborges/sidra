#' Obtenção de dados via API SIDRA - IBGE
#'
#' Esta função retorna uma lista com periodos de uma das tabelas da SIDRA.
#' @param tabela Número da tabela.
#' @keywords IBGE SIDRA dados periodos
#' @export
#' @examples
#' periodos_ipcaq <- tab_periodos(1705)
#' tab_periodos(1705) # imprime os classificadores com sua descrição

tab_periodos <- function(tabela) {
  tab_meta(tabela)$periodos

}
