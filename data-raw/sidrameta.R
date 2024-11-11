##code to get sidra metadata as data for package

#available metadata sidra


agregacao <- \(x="A"){
  baseag <- "https://servicodados.ibge.gov.br/api/v3/agregados"
  resp <- httr::GET(paste0(baseag,"?acervo=",x))
  conteudo <- httr::content(resp)
  agregado <- data.table::rbindlist(lapply(1:length(conteudo),\(x) as.data.frame(conteudo[[x]])))
  agregado$agregacao <- x
  agregado
}

lista_agregados <- lapply(agregados$id,agregacao)
names(lista_agregados) <- agregados$agregado
sidrameta <- data.table::rbindlist(lista_agregados)
rm("lista_agregados")

