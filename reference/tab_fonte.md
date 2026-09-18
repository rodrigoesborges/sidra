# Obtenção de dados via API SIDRA - IBGE

Esta função retorna a fonte de uma das tabelas da SIDRA.

## Usage

``` r
tab_fonte(tabela)
```

## Arguments

- tabela:

  Número da tabela.

## Value

uma \`string\` (vetor de caracteres de comprimento 1) com o nome da
fonte dos dados da tabela solicitada

## Examples

``` r
fonte_ipcaq <- tab_fonte(1705)
tab_fonte(1705) # imprime o nome da fonte
#> [1] "Índice Nacional de Preços ao Consumidor Amplo 15"
```
