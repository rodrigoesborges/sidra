#' Conexão do R com a SIDRA - IBGE
#'
#' Esta função retorna a tabela solicitada em formato data.frame.
#' @param tabela Número da tabela.
#' @param classificador Classificador a ser detalhado. O padrão é "", retornando os totais da tabela. Para verificar os classificadores disponíveis na tabela em questão use a função tab_class().
#' @param filtro_cats Código para definição de subconjunto do classificador. Para verificar as categorias disponíveis na tabela em questão use a função tab_class().
#' @param nivel Nível geográfico de agregação dos dados 1 = Brasil e 6 = Município, etc. Para verificar os níveis disponíveis na tabela em questão use a função tab_niveis().
#' @param filtro_nivel Código contendo conjunto no nível que será selecionado. Pode-se usar o código de determina UF para obter apenas seus dados ou "all" para todos (padrão). Para mais informações visite http://api.sidra.ibge.gov.br/home/ajuda.
#' @param periodo Período dos dados. O padrão é "all", isto é, todos os anos disponíveis. Para verificar os períodos disponíveis na tabela em questão use a função tab_periodos().
#' @param variavel Quais variáveis devem retornar? O padrão é "allxp", isto é, todas exceto aquelas calculadas pela SIDRA (percentuais). Para verificar as variáveis disponíveis na tabela em questão use a função tab_vars().
#' @param inicio,fim Início e fim do período desejado.
#' @keywords IBGE SIDRA dados
#' @export
#' @examples
#' PAM <- sidra(1612, 81)

sidra <- function (tabela, classificador="",
                       filtro_cats , nivel = min(tab_niveis(tabela)$nivel.id),
                       filtro_niveis,
                       periodo =
                     paste0(min(tab_periodos(tabela)),"-",
                            max(tab_periodos(tabela))), variavel = "all",
                       inicio, fim)
{
  if (length(tabela) > 1) {
    stop("Solicite os dados de uma tabela por vez. Para mais de uma use funções da família apply",
         call. = FALSE)
  }
  # if (!tabela %in% sidrameta$id) {
  #   stop("A tabela informada não é válida", call. = FALSE)
  # }
  if (!missing(inicio) && !missing(fim)) {
    periodo <- paste0(inicio, "-", fim)
  } else if (missing(fim) && !missing(inicio)) {
    periodo <- periodo[periodo >= inicio]
  } else if (missing(inicio) && !missing(fim)) {
    periodo <- periodo[periodo<=fim]
  } else {
    periodo <- paste0(periodo,collapse="|")
  }
  if (!missing(filtro_niveis) && length(nivel) != length(filtro_niveis)) {
    stop("O argumento filtro_niveis, quando especificado, deve ser uma lista de mesmo tamanho que
         o argumento nivel",
         call. = FALSE)
  }

  if (!missing(filtro_cats) && !missing(classificador) &&
      length(classificador) != length(filtro_cats)) {
    stop("O argumento filtro_cats, quando especificado, deve ser uma lista de mesmo tamanho que
         o argumento classificador",
         call. = FALSE)
  }

  concav <- \(x) paste0(x,collapse=",")
  if(!missing(filtro_cats)) {
    classifs <- paste0(paste0(classificador,"[",lapply(filtro_cats,concav),"]"),collapse="|")
  } else if(!missing(classificador)){
    classifs <- paste0(classificador,"[all]",collapse="|")
  } else {
    classifs <- classificador
  }
  if(!missing(filtro_niveis)) {
    locais <- paste0(paste0(nivel,"[",lapply(filtro_niveis,concav),"]"),collapse="|")
  } else {
    locais <- paste0(nivel,"[all]",collapse="|")
  }

  if(length(variavel)>1) {
    variavel <- paste0(variavel,collapse="|")
  }


  base_url <- "https://servicodados.ibge.gov.br/api/v3/agregados/"
  url <- paste0(base_url, tabela,
                "/periodos/", periodo,
                "/variaveis/", variavel,
                "?classificacao=", classifs,
                "&localidades=", locais)
  print(url)
  #Cálculo do tamanho da requisição:
  if(!grepl("-",periodo[1])) {
  ntemps <- length(periodo)
  } else if (length(periodo)>1){
    ntemps <- length(periodo[periodo >=inicio & periodo<=fim])
  } else {
    ntemps <- length(tab_periodos(tabela))
  }

  if(!missing(filtro_cats)){
    ncats <- sum(sapply(1:length(filtro_cats),\(x){nrow(filtro_cats[[x]])}),na.rm=T)
  } else {
    clg <- tab_class(tabela)
    if(classificador!="") {
    sbclg <- names(clg)[grepl(paste0("-",classificador,"$"),names(clg))]
    class_esc <- clg[sbclg]} else {
      class_esc <- clg
    }

    ncats <- sum(sapply(1:length(class_esc),\(x) {nrow(class_esc[[x]])}),na.rm=T)
  }

  if(!missing(filtro_niveis)){
    nlocs <- sum(sapply(1:length(filtro_niveis),\(x){length(filtro_niveis[[x]])}),na.rm=T)
  } else {
    loc_esc <- tab_locais(tabela)[nivel.id %in% nivel]
    nlocs <- nrow(loc_esc)
  }

  tamanho <- length(variavel)*ntemps*nlocs*ncats
  print(tamanho)

  if (tamanho>1e5) {
      message(paste(
        conteudo,
        "A consulta excederá o limite de 100.000 permitido pela API.",
        "Vamos contornar este problema fazendo varias solicitações menores.",
        "Haverá maior demora", sep = "\n"))

      periodos <- tab_periodos(tabela)
      requisicoes <- (tamanho %/% 100000) + 1

      cada <- periodos %>% split(cut(seq_along(periodos), requisicoes)) %>%
        lapply(range) %>% sapply(paste0, collapse = "-")

      partes <- data.table::rbindlist(lapply(cada, sidra,
                               tabela = tabela, classificador = classificador,
                               filtro_cats = filtro_cats, nivel = nivel,
                               filtro_niveis = filtro_niveis, variavel = variavel))

    }


  # Fazer a requisição GET
  response <- httr::GET(url)

  # verificação do conteúdo
  # Checar se a requisição foi bem-sucedida
  if (httr::status_code(response) != 200) {
    stop("Erro ao acessar a API do SIDRA.")
  }

  # Converter o JSON para um data frame
  json_data <- httr::content(response, "text",encoding="UTF-8")

  # Conteúdo já verificado
res <- rjson::fromJSON(json_data)

    arrumado <- \(x) {
      amplia_colunas <- cbind(id=res[[x]]$id,variavel=res[[x]]$variavel,
                              periodo = names(res[[x]]$resultados[[1]]$series[[1]]$serie),
                                   do.call(cbind,lapply(1:length(res[[x]]$resultados),
               \(y) {
                 df <- data.frame(
                   valor=unlist(res[[x]]$resultados[[y]]$series[[1]]$serie))
                 names(df) <- paste0(
                   paste0(res[[x]]$resultados[[y]]$classificacoes[[1]][c("id","nome")],
                          collapse="|"),"|",
                   res[[x]]$resultados[[y]]$classificacoes[[1]][["categoria"]][[1]],
                   "|",
                   res[[x]]$resultados[[y]]$series[[1]]$localidade$nome)
                 df})))|>
        tidyr::pivot_longer(-(1:3),names_to = c("cod_class","classificador","categoria","local"),
                            names_sep="\\|",values_to="valor")

    }
res <- data.table::rbindlist(
  lapply(1:length(res),\(x) arrumado(x))

)
res$valor <- as.numeric(res$valor)
    return(res)

}
