## code to prepare `agregados` dataset goes here


usethis::use_data(agregados, overwrite = TRUE)

requireNamespace("tibble")
#available metadata sidra
agregados <- tibble::tribble(
  ~id,~agregado,~rota,
  "A","Assunto","assunto",
  "C","Classifica\u00e7\u00e3o","classificacao",
  "N","N\u00edvel geogr\u00e1fico","nivel",
  "P","Per\u00edodo","periodo",
  "E","Periodicidade","periodicidade",
  "V","Vari\u00e1vel","variaveis"
)
