# Obtenção de dados via API SIDRA - IBGE

Esta função retorna uma lista com níveis territoriais disponíveis de uma
das tabelas da SIDRA.

## Usage

``` r
tab_niveis(tabela)
```

## Arguments

- tabela:

  Número da tabela.

## Value

Um \`data.frame\` (especificamente, um \`data.table\`) que lista todas
as localidades disponíveis para a tabela, detalhando o ID e o nome de
cada localidade, bem como o ID e o nome do nível geográfico
correspondente (ex: 'N3' para "Unidade da Federação").

## Examples

``` r
niveis_ipca15 <- tab_niveis(1705)
tab_niveis(1705) # imprime os níveis territoriais da tabela solicitada
#>         id     nome nivel.id nivel.nome
#>      <num>   <char>   <char>     <char>
#> 1: 5208707  Goiânia       N6  Município
#> 2: 5300108 Brasília       N6  Município
#> 3:       1   Brasil       N1     Brasil
```
