# Busca de tabelas/agregados ou variáveis via API SIDRA - IBGE

Esta função retorna uma lista com agregados, tabelas ou variáveis da
SIDRA que possuem o termo buscado.

## Usage

``` r
tab_search(termo)
```

## Arguments

- termo:

  Termo a buscar.

## Value

um \`data.frame\` (especificamente um \`data.table\`) com as colunas:

- `id`: um vetor com os ids das tabelas em que termo encontrado

- `literal`: o texto onde ocorreu match

- `agregacao`: codigo string da agregação, cf. \`tab_agr()\`.

## Examples

``` r
tabs_ipca <- tab_search('IPCA15')
tab_search('IPCA15') # imprime tabelas/agregados/variáveis com o termo pesquisado.
#>     ID do Agregado/Tabela
#>                    <char>
#>  1:                  1117
#>  2:                   357
#>  3:                  1120
#>  4:                  1118
#>  5:                  1119
#>  6:                   356
#>  7:                   355
#>  8:                  1387
#>  9:                  1646
#> 10:                  1705
#> 11:                  3065
#> 12:                  7062
#>                                                                                                                                                                                                 Descrição
#>                                                                                                                                                                                                    <char>
#>  1:                                                                                                                                                 IPCA15 - Número-índice (base: dezembro de 1993 = 100)
#>  2:                                                                                                                                                                                  IPCA15 - Peso mensal
#>  3:                                                                                                                                                               IPCA15 - Variação acumulada em 12 meses
#>  4:                                                                                                                                                                IPCA15 - Variação acumulada em 3 meses
#>  5:                                                                                                                                                                IPCA15 - Variação acumulada em 6 meses
#>  6:                                                                                                                                                                    IPCA15 - Variação acumulada no ano
#>  7:                                                                                                                                                                              IPCA15 - Variação mensal
#>  8:                           IPCA15 - Variação mensal, acumulada no ano e peso mensal, para o índice geral, grupos, subgrupos, itens e subitens de produtos e serviços (de agosto/2006 até janeiro/2012)
#>  9:                               IPCA15 - Variação mensal, acumulada no ano e peso mensal, para o índice geral, grupos, subgrupos, itens e subitens de produtos e serviços (de maio/2000 até julho/2006)
#> 10: IPCA15 - Variação mensal, acumulada no ano, acumulada em 12 meses e peso mensal, para o índice geral, grupos, subgrupos, itens e subitens de produtos e serviços (de fevereiro/2012 até janeiro/2020)
#> 11:                                               IPCA15 - Série histórica com número-índice, variação mensal e variações acumuladas em 3 meses, em 6 meses, no ano e em 12 meses (a partir de maio/2000)
#> 12:         IPCA15 - Variação mensal, acumulada no ano, acumulada em 12 meses e peso mensal, para o índice geral, grupos, subgrupos, itens e subitens de produtos e serviços (a partir de fevereiro/2020)
#>     Variável
#>       <lgcl>
#>  1:     TRUE
#>  2:     TRUE
#>  3:     TRUE
#>  4:     TRUE
#>  5:     TRUE
#>  6:     TRUE
#>  7:     TRUE
#>  8:    FALSE
#>  9:    FALSE
#> 10:    FALSE
#> 11:    FALSE
#> 12:    FALSE
```
