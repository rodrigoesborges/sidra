#' coleta de dados via API SIDRA - IBGE
#'
#' Esta função retorna a tabela solicitada em formato data.frame.
#' @param tabela Número da tabela.
#' @param classificador Classificador a ser detalhado. O padrão é "", retornando os totais da tabela. Para verificar os classificadores disponíveis na tabela em questão use a função tab_class().
#' @param filtro_cats Código para definição de subconjunto do classificador. Para verificar as categorias disponíveis na tabela em questão use a função tab_class().
#' @param nivel Nível geográfico de agregação dos dados 1 = Brasil e 6 = Município, etc. Para verificar os níveis disponíveis na tabela em questão use a função tab_niveis().
#' @param filtro_niveis Código contendo conjunto no nível que será selecionado. Pode-se usar o código de determina UF para obter apenas seus dados ou "all" para todos (padrão). Para mais informações visite http://api.sidra.ibge.gov.br/home/ajuda.
#' @param periodo Período dos dados. O padrão é "all", isto é, todos os anos disponíveis. Para verificar os períodos disponíveis na tabela em questão use a função tab_periodos().
#' @param variavel Quais variáveis devem retornar? O padrão é "allxp", isto é, todas exceto aquelas calculadas pela SIDRA (percentuais). Para verificar as variáveis disponíveis na tabela em questão use a função tab_vars().
#' @param inicio,fim Início e fim do período desejado.
#' @param part interno para quando é preciso fazer várias requisições
#' @param printurl imprime url construído para transparência e debugging
#' @keywords IBGE SIDRA dados
#' @export
#' @examples
#' PAM <- sidra(1612, 81)

sidra <- function (tabela, classificador="",
                   filtro_cats , nivel = "N1",
                   filtro_niveis,
                   periodo = "all", variavel = "all",
                   inicio, fim,part=F,printurl=F)
{
  if (length(tabela) > 1) {
    stop("Solicite os dados de uma tabela por vez. Para mais de uma use fun\u00e7\u00f5es da fam\u00edlia apply",
         call. = FALSE)
  }
  if (!tabela %in% sidra::sidrameta$id) {
    stop("A tabela informada n\u00e3o \u00e9 v\u00e1lida", call. = FALSE)
  }

  ##obtendo metadados única vez
  metatab <- tab_meta(tabela)

  #Determinação do período de forma vetorizada
  perido <-   if (!missing(inicio) && !missing(fim)) {
    paste0(inicio, "-", fim)
  } else if (missing(fim) && !missing(inicio)) {
    metatab$periodo[metatab$periodo >= inicio]
  } else if (missing(inicio) && !missing(fim)) {
    metatab$periodo[metatab$periodo <= inicio]
  } else {
    paste0(periodo,collapse="|")
  }

  #Validando e ajustando `filtro_niveis` e `filtro_cats`
  if (!missing(filtro_niveis) && length(nivel) != length(filtro_niveis)) {
    stop("O argumento filtro_niveis, quando especificado, deve ser uma lista de
         mesmo tamanho que o argumento n\u00edvel",
         call. = FALSE)
  }

  if (!missing(filtro_cats) && !missing(classificador) &&
      length(classificador) != length(filtro_cats)) {
    stop("O argumento filtro_cats, quando especificado,
         deve ser uma lista de mesmo tamanho que o argumento classificador",
         call. = FALSE)
  }

  # Função interna para concatenar elementos
  concav <- \(x) paste0(x,collapse=",")

  # Preparação de classificadores e localidades
  classifs <- if(!missing(filtro_cats)) {
    paste0(paste0(classificador,"[",sapply(filtro_cats,concav),"]"),collapse="|")
  } else if(length(classificador)==0){
    paste0(classificador,"[all]",collapse="|")
  } else {
    classificador
  }

  locais <- if(!missing(filtro_niveis)) {
    paste0(paste0(nivel,"[",sapply(filtro_niveis,concav),"]"),collapse="|")
  } else {
    paste0(nivel,"[all]",collapse="|")
  }

  # Concatenando variáveis de forma otimizada
  variavel <-
  if(length(variavel)>1) {
    paste0(variavel,collapse="|")
  } else {variavel}


  #Construindo URL
  base_url <- "https://servicodados.ibge.gov.br/api/v3/agregados/"
  url <- paste0(base_url, tabela,
                "/periodos/", periodo,
                "/variaveis/", variavel,
                "?classificacao=", classifs,
                "&localidades=", locais)

  if(printurl){print(url)}

  # C\u00e1lculo do tamanho da requisi\u00e7\u00e3o:
  ntemps <- if(is.character(periodo) && !grepl("-",periodo[1])) {
    length(periodo)
  } else if (length(periodo)>1){
    length(periodo[periodo >=inicio & periodo<=fim])
  } else {
    length(metatab$periodos)
  }

  # Definindo ncats
  ncats <- if(!missing(filtro_cats)){
    ncats <- sum(sapply(filtro_cats,nrow),na.rm=T)
  } else {
    class_esc <-
    if(classificador!="") {
      metatab$classificacoes[grepl(paste0("-",classificador,"$"),names(metatab$classificacoes))]
      } else {
        metatab$classificacoes
      }

    sum(sapply(class_esc,nrow),na.rm=T)
  }

  #Definindo nlocs
  nlocs <-
  if(!missing(filtro_niveis)){
    sum(sapply(filtro_niveis,length),na.rm=T)
  } else {
    nvl <- tab_niveis(tabela)
    nlocs <- nrow(nvl[nvl$nivel.id %in% nivel])
  }

  # Calculando tamanho da consulta e particionando se necessário
  tamanho <- length(variavel)*ntemps*nlocs*ncats

  if (tamanho>1e5 & part) {
    message(paste(
      "A consulta exceder\u00e1 o limite de 100.000 permitido pela API.",
      "Vamos contornar este problema fazendo v\u00e1rias solicita\u00e7\u00f5es menores.",
      "Haver\u00e1 maior demora", sep = "\n"))

    periodos <- metatab$periodos
    requisicoes <- (tamanho %/% 100000) + 1

    cada <- periodos |> split(cut(seq_along(periodos), requisicoes)) |>
      lapply(range) |> sapply(paste0, collapse = "-")


    partes <- data.table::rbindlist(lapply(cada, sidra,
                                           tabela = tabela, classificador = classificador,
                                           filtro_cats = filtro_cats, nivel = nivel,
                                           filtro_niveis = filtro_niveis, variavel = variavel,part=T))

  }


  # Fazer a requisi\u00e7\u00e3o GET
  response <- httr::GET(url)

  # verificação do conteúdo
  # Checar se a requisição foi bem-sucedida
  if (httr::status_code(response) != 200) {
    stop("Erro ao acessar a API do SIDRA.")
  }

  # Converter o JSON para um data frame
  json_data <- httr::content(response, "text",encoding="UTF-8")

  # Conte\u00fado j\u00e1 verificado

  res <- rjson::fromJSON(json_data)

  #Transformando json
  arrumado <- \(x) {
    cbind(id=x$id,variavel=x$variavel,
                            periodo = names(x$resultados[[1]]$series[[1]]$serie),
                            do.call(cbind,lapply(1:length(x$resultados),
                                                 \(y) {
                                                   df <- data.frame(
                                                     valor=unlist(x$resultados[[y]]$series[[1]]$serie))
                                                   names(df) <- paste0(
                                                     paste0(x$resultados[[y]]$classificacoes[[1]][c("id","nome")],
                                                            collapse="|"),"|",
                                                     x$resultados[[y]]$classificacoes[[1]]$categoria[[1]],
                                                     "|",
                                                     x$resultados[[y]]$series[[1]]$localidade$nome)
                                                   df})))|>
      tidyr::pivot_longer(-(1:3),names_to = c("cod_class","classificador","categoria","local"),
                          names_sep="\\|",values_to="valor")

  }
  res <- data.table::rbindlist(
    lapply(res,\(x) arrumado(x))

  )
  res$valor <- base::suppressWarnings(as.numeric(res$valor))
  return(res)

}
