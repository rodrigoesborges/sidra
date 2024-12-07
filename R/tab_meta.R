#' Obtenção de dados via API SIDRA - IBGE
#'
#' Esta função retorna uma lista com os ids e o conteúdo da descrição da tabela solicitada.
#' @param tabela Número da tabela.
#' @keywords IBGE SIDRA dados metadados
#' @importFrom data.table rbindlist
#' @export
#'
#' @examples
#' meta_ipcaq <- tab_meta(1705)

# library(rvest)

tab_meta <- function(tabela) {



  baseref <- paste0("https://servicodados.ibge.gov.br/api/v3/agregados/", tabela)

  rota <- paste0(baseref,"/metadados")

  resp <- httr::GET(rota)


  metatabela <- httr::content(resp)
  metatabela$nivelTerritorial <- unlist(metatabela$nivelTerritorial)
  metatabela$variaveis <- suppressWarnings(data.table::rbindlist(metatabela$variaveis))
  metatabela$periodos <- seq(from=metatabela$periodicidade$inicio,to=metatabela$periodicidade$fim)
  if(metatabela$periodicidade$frequencia=="mensal") {
  metatabela$periodos <- metatabela$periodos[substr(metatabela$periodos,5,6)%in% sprintf("%02d",1:12)]
  }
  ### extrai grupo classificador
  extclass <- \(x=1){
    suppressWarnings(data.table::rbindlist(metatabela$classificacoes[[x]]$categorias))
  }
  extnclass <- \(x=1){ paste0(metatabela$classificacoes[[x]][c('id',"nome")],collapse="-")}

  classificacoes <- lapply(1:length(metatabela$classificacoes),extclass)
  names(classificacoes) <- sapply(1:length(metatabela$classificacoes),extnclass)
  metatabela$classificacoes <- classificacoes

  metatabela
}

