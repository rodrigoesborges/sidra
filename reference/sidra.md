# coleta de dados via API SIDRA - IBGE

Esta função retorna a tabela solicitada em formato data.frame.

## Usage

``` r
sidra(
  tabela,
  classificador = "",
  filtro_cats = "",
  nivel = "N1",
  filtro_niveis,
  periodo = tab_meta(tabela)$periodos,
  variavel = "all",
  inicio,
  fim,
  part = FALSE,
  printurl = FALSE
)
```

## Arguments

- tabela:

  Número da tabela.

- classificador:

  Classificador a ser detalhado. O padrão é "", retornando os totais da
  tabela. Para verificar os classificadores disponíveis na tabela em
  questão use a função tab_class().

- filtro_cats:

  Código para definição de subconjunto do classificador. Para verificar
  as categorias disponíveis na tabela em questão use a função
  tab_class().

- nivel:

  Nível geográfico de agregação dos dados 1 = Brasil e 6 = Município,
  etc. Para verificar os níveis disponíveis na tabela em questão use a
  função tab_niveis().

- filtro_niveis:

  Código contendo conjunto no nível que será selecionado. Pode-se usar o
  código de determina UF para obter apenas seus dados ou "all" para
  todos (padrão). Para mais informações visite
  http://api.sidra.ibge.gov.br/home/ajuda.

- periodo:

  Período dos dados. O padrão é "all", isto é, todos os anos
  disponíveis. Para verificar os períodos disponíveis na tabela em
  questão use a função tab_periodos().

- variavel:

  Quais variáveis devem retornar? O padrão é "allxp", isto é, todas
  exceto aquelas calculadas pela SIDRA (percentuais). Para verificar as
  variáveis disponíveis na tabela em questão use a função tab_vars().

- inicio, fim:

  Início e fim do período desejado.

- part:

  interno para quando é preciso fazer várias requisições

- printurl:

  imprime url construído para transparência e debugging

## Value

Um \`data.frame\` (\`tibble\`) contendo os dados solicitados da tabela
SIDRA. A estrutura do `data.frame` está em formato amplo (wide), onde
cada linha geralmente corresponde a um nível geográfico e período de
tempo específico. As colunas incluem detalhes sobre a localidade, o
período e as variáveis, com as categorias de classificação transformadas
em colunas separadas.

## Examples

``` r
ipcaq <- sidra(1705,classificador=315,periodo='201202')
```
