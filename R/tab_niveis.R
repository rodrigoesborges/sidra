#' Obtenção de dados via API SIDRA - IBGE
#'
#' Esta função retorna uma lista com níveis territoriais disponíveis
#' de uma das tabelas da SIDRA.
#' @param tabela Número da tabela.
#' @keywords IBGE SIDRA dados localidade
#' @export
#' @examples
#' niveis_ipca15 <- tab_niveis(1705)
#' tab_niveis(1705) # imprime os classificadores com sua descrição

tab_niveis <- function(tabela) {
  niveis <- tab_meta(tabela)$nivelTerritorial

  baseref <- paste0("https://servicodados.ibge.gov.br/api/v3/agregados/", tabela)

  rota <- paste0(baseref,"/localidades/",paste0(niveis,collapse="|"))

  resp <- httr::GET(rota)

  nivtab <- httr::content(resp)

    flatniv <- \(x){
    f <- cbind(nivtab[[x]][-3],as.data.frame(t(unlist(nivtab[[x]]$nivel))))
    f[1] <- as.numeric(f[1])
    names(f)[3:4] <- paste0("nivel.",names(f)[3:4])
    f
  }

  nivtab <- data.table::rbindlist(lapply(1:length(nivtab),flatniv))

  nivtab
}
