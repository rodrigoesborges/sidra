# Obtenção de tabelas por agregado via API SIDRA - IBGE

Esta função retorna uma lista com Todas as tabelas para agregado
indicado

## Usage

``` r
tab_agr(agregado)
```

## Arguments

- agregado:

  Número do agregado.

## Value

Uma lista contendo dois \`data.table\`s:

- `pesquisas`: Um \`data.table\` com o ID e o nome das pesquisas
  relacionadas.

- `tabelas`: Um \`data.table\` com o ID e o nome das tabelas (agregados)
  disponíveis para a consulta indicada.

## Examples

``` r
tabs_a70 <- tab_agr('A70')
tab_agr('A70') # imprime os agregados com sua descrição
#> $pesquisas
#>        id                                    nome
#>    <char>                                  <char>
#> 1:     AB     Pesquisa Mensal de Abate de Animais
#> 2:     AX Pesquisa Trimestral do Abate de Animais
#> 
#> $tabelas
#>         id
#>     <char>
#>  1:     19
#>  2:     20
#>  3:     41
#>  4:     42
#>  5:     43
#>  6:     44
#>  7:     45
#>  8:     46
#>  9:     47
#> 10:     48
#> 11:   1092
#> 12:   1093
#> 13:   1094
#> 14:   6669
#> 15:   6829
#> 16:   9395
#>                                                                                                                                                                                   nome
#>                                                                                                                                                                                 <char>
#>  1:                                                                                                                                   Quantidade de outros animais de criação abatidos
#>  2:                                                                                                                            Peso das carcaças de outros animais de criação abatidos
#>  3:                                                                                                                                                     Quantidade de bovinos abatidos
#>  4:                                                                                                                                                      Quantidade de suínos abatidos
#>  5:                                                                                                                                                    Quantidade de equídeos abatidos
#>  6:                                                                                                                                                        Quantidade de aves abatidas
#>  7:                                                                                                                                              Peso das carcaças de bovinos abatidos
#>  8:                                                                                                                                               Peso das carcaças de suínos abatidos
#>  9:                                                                                                                                             Peso das carcaças de equídeos abatidos
#> 10:                                                                                                                                                 Peso das carcaças de aves abatidas
#> 11:                                    Número de informantes, Quantidade e Peso total das carcaças dos bovinos abatidos, no mês e no trimestre, por tipo de rebanho e tipo de inspeção
#> 12:                                                       Número de informantes, Quantidade e Peso total das carcaças dos suínos abatidos, no mês e no trimestre, por tipo de inspeção
#> 13:                                                      Número de informantes, Quantidade e Peso total das carcaças dos frangos abatidos, no mês e no trimestre, por tipo de inspeção
#> 14:                                                            Quantidade e Peso total das carcaças dos animais abatidos, por tipo de rebanho - Primeiros Resultados (série encerrada)
#> 15:                                                       Quantidade e Peso total das carcaças dos animais abatidos, no mês e no trimestre, por tipo de rebanho - Primeiros Resultados
#> 16: Número de informantes, Quantidade e Peso total das carcaças dos frangos abatidos, no mês e no trimestre, por tipo de inspeção (série encerrada com última divulgação em 7/12/2022)
#> 

```
