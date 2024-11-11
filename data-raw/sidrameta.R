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

### Diretas sem agregagacao

agsem <- jsonlite::fromJSON(httr::content(httr::GET("https://servicodados.ibge.gov.br/api/v3/agregados"),"text"),simplifyDataFrame = F)

agsem <- data.table::rbindlist(lapply(agsem,\(x) x <- cbind(t(unlist(x[1])),t(unlist(x[2])),data.table::rbindlist(x[[3]]))))

names(agsem)[2:4] <- c("Nome Pesquisa/AG",paste0("agregado.",names(agsem)[3:4]))
agsem$agregado.id <- as.numeric(agsem$agregado.id)

sidrameta <- rbind(sidrameta,agsem[,c(3,4,1,2)],use.names=F,fill=T)


rm(list = c("lista_agregados","agsem"))

