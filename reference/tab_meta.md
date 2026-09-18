# Obtenção de dados via API SIDRA - IBGE

Esta função retorna uma lista com os ids e o conteúdo da descrição da
tabela solicitada.

## Usage

``` r
tab_meta(tabela)
```

## Arguments

- tabela:

  Número da tabela.

## Value

Uma \`lista\` contendo os metadados da tabela solicitada. A lista inclui
elementos como:

- `nivelTerritorial`: um vetor com os níveis territoriais disponíveis.

- `variaveis`: um \`data.frame\` com as variáveis da tabela.

- `periodos`: um vetor com os períodos disponíveis.

- `classificacoes`: uma lista de \`data.frame\`s, onde cada um
  representa um classificador e suas categorias.

- Outros metadados diversos da tabela, como nome, pesquisa, assunto,
  etc.

## Examples

``` r
meta_ipcaq <- tab_meta(1705)
```
