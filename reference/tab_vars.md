# Obtenção de dados via API SIDRA - IBGE

Esta função retorna uma lista com variáveis de uma das tabelas da SIDRA.

## Usage

``` r
tab_vars(tabela)
```

## Arguments

- tabela:

  Número da tabela.

## Value

um \`data.frame\` (\`data.table\`) com as seguintes colunas:

- `id`: ids dos indicadores

- `nome`: nome dos indicadores

- `unidade`: unidade de medida do indicador.

- `sumarizacao`: tipo de agregação.

## Examples

``` r
vars_ipcaq <- tab_vars(1705)
tab_vars(1705) # imprime os classificadores com sua descrição
#>       id                                    nome unidade sumarizacao
#>    <int>                                  <char>  <char>      <list>
#> 1:   355                IPCA15 - Variação mensal       %      [NULL]
#> 2:   356      IPCA15 - Variação acumulada no ano       %      [NULL]
#> 3:  1120 IPCA15 - Variação acumulada em 12 meses       %      [NULL]
#> 4:   357                    IPCA15 - Peso mensal       %      [NULL]
```
