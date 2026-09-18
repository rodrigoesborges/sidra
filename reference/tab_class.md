# Obtenção de dados via API SIDRA - IBGE

Esta função retorna uma lista com classificadores de uma das tabelas da
SIDRA.

## Usage

``` r
tab_class(tabela)
```

## Arguments

- tabela:

  Número da tabela.

## Value

uma lista de \`data.frame\`s, onde cada um representa um classificador e
suas categorias.

## Examples

``` r
class_ipcaq <- tab_class(1705)
tab_class(1705) # imprime os classificadores com sua descrição
#> $`315-Geral, grupo, subgrupo, item e subitem`
#>          id                                    nome unidade nivel
#>       <int>                                  <char>  <lgcl> <int>
#>   1:   7169                            Índice geral      NA     0
#>   2:   7170                 1.Alimentação e bebidas      NA     1
#>   3:   7171             11.Alimentação no domicílio      NA     2
#>   4:   7172 1101.Cereais, leguminosas e oleaginosas      NA     3
#>   5:   7173                           1101002.Arroz      NA     4
#>  ---                                                             
#> 442:   7792                9101008.Telefone celular      NA     4
#> 443: 107688               9101018.Acesso à internet      NA     4
#> 444:   7794             9101019.Aparelho telefônico      NA     4
#> 445:  12429  9101021.Telefone com internet - pacote      NA     4
#> 446:  12430  9101022.TV por assinatura com internet      NA     4
#> 
```
