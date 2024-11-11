Introdução ao pacote sidra
================
Rodrigo E. S. Borges

``` r
library(sidra)
```

# Introdução

O pacote `sidra` fornece uma interface simples para acessar a API de
dados do SIDRA (Sistema IBGE de Recuperação Automática), permitindo que
você consulte dados do IBGE diretamente do R, **a partir da api rest
tornada disponível em
[servicodados.ibge.gov.br](https://servicodados.ibge.gov.br/api/docs/agregados?versao=3)**.

Este documento fornece uma introdução ao pacote e apresenta exemplos
básicos para ajudá-lo a começar.

# Instalação

Para instalar o pacote diretamente do GitHub, utilize o código abaixo:

``` r
# Instalar remotes, se necessário
# install.packages("remotes")

# Instalar o pacote sidra
remotes::install_github("rodrigoesborges/sidra")
```

Após a instalação, carregue o pacote com:

library(sidra)

# Funções Principais

O pacote sidra contém diversas funções para acessar diferentes seções da
API SIDRA. Abaixo, uma descrição das funções principais.

1.  Função sidra()

Esta é a função principal do pacote, que permite fazer consultas gerais
à API SIDRA com diversos parâmetros. Use esta função para acessar dados
diretamente especificando a tabela, variáveis, classificadores, períodos
e níveis geográficos.

    sidra(tabela, classificador = "", filtro_cats = "", nivel = 1, filtro_niveis = "all", periodo = "all", variavel = "allxp", inicio = NULL, fim = NULL)
        tabela: Número da tabela desejada.
        classificador: Classificador a ser detalhado. O padrão retorna todos os classificadores disponíveis.
        filtro_cats: Define subconjunto do classificador.
        nivel: Define o nível geográfico, por exemplo, N1 para Brasil, N6 para Município.
        filtro_niveis: Define um subconjunto do nível especificado.
        periodo: Período dos dados; "all" para todos os períodos disponíveis.
        variavel: Variáveis a serem retornadas; "allxp" exclui variáveis calculadas pela SIDRA.
        inicio, fim: Início e fim do período desejado.

2.  Funções para Classificações (tab_class.R)

Essas funções retornam informações sobre classificações disponíveis para
uma tabela específica, incluindo os códigos de classificadores.

    tab_class(tabela): Retorna classificações disponíveis para uma tabela específica.
        tabela: Número da tabela de interesse.

3.  Funções para Fonte dos Dados (tab_fonte.R)

Essa função retorna a fonte dos dados, i.e. a Pesquisa primária fonte,
para uma tabela específica, permitindo entender a origem e
confiabilidade dos dados.

    tab_fonte(tabela): Retorna a fonte de dados para a tabela especificada.
        tabela: Número da tabela de interesse.

4.  Funções para Metadados da Tabela (tab_meta.R)

Essas funções fornecem metadados sobre uma tabela específica, oferecendo
informações detalhadas sobre o conteúdo da tabela.

    tab_meta(tabela): Retorna metadados para uma tabela específica.
        tabela: Número da tabela de interesse.

5.  Funções para Níveis Geográficos (tab_niveis.R)

Essas funções retornam informações sobre os níveis geográficos
disponíveis para uma tabela, como Brasil, Região, Estado, ou Município.

    tab_niveis(tabela): Retorna níveis geográficos disponíveis para a tabela especificada.
        tabela: Número da tabela de interesse.

6.  Funções para Períodos (tab_periodos.R)

Essas funções permitem listar os períodos disponíveis para uma tabela,
como anos ou meses, dependendo da periodicidade dos dados.

    tab_periodos(tabela): Retorna os períodos disponíveis para a tabela especificada.
        tabela: Número da tabela de interesse.

7.  Funções para Variáveis (tab_vars.R)

Essas funções listam as variáveis disponíveis em uma tabela específica,
como diferentes métricas ou indicadores que podem ser selecionados.

    tab_vars(tabela): Retorna variáveis disponíveis para a tabela especificada.
        tabela: Número da tabela de interesse.

## Exemplos de Uso

Aqui estão exemplos de como usar essas funções para consultar dados
específicos na API SIDRA.

### Listar Classificações

Para listar as classificações disponíveis para uma tabela específica,
como a tabela 1612:

``` r
classificacoes <- tab_class(1612)
print(classificacoes)
```

Para obter a fonte dos dados de uma tabela específica:

### Obter Fonte dos Dados

``` r
fonte <- tab_fonte(1612)
print(fonte)
```

### Obter Metadados da Tabela

Para acessar os metadados de uma tabela específica, como a tabela 1612:

``` r
metadados <- tab_meta(1612)
print(metadados)
```

### Listar Níveis Geográficos

Para listar os níveis geográficos disponíveis para a tabela 1612:

``` r
niveis <- tab_niveis(1612)
print(niveis)
```

### Listar Períodos Disponíveis

Para listar os períodos disponíveis para a tabela 1612:

``` r
periodos <- tab_periodos(1612)
print(periodos)
```

### Listar Variáveis Disponíveis

Para listar as variáveis disponíveis para uma tabela específica, como a
tabela 1612:

``` r
variaveis <- tab_vars(1612)
print(variaveis)
```

### Consultar Dados Específicos com sidra()

A função sidra() permite fazer consultas específicas de dados. Neste
exemplo, buscamos dados da tabela 1612, com o classificador 81, no nível
geográfico de Estados.

``` r
dados <- sidra(1612, classificador = 81, nivel = 3)
head(dados)
```

# Avisos e Dicas

    Limites de consulta: Algumas consultas podem exceder o limite de 100.000 registros permitido pela API do IBGE. Nesse caso, por definição o pacote busca dividir a consulta em requisições menores a partir de segmentação dos períodos requisitados. Ainda que robusto, pode não funcionar para todos os casos, pelo qual sugerimos faça a segmentação manualmente da requisição se necessário.
    Níveis e Classificadores: Ao utilizar filtro_niveis ou filtro_cats, certifique-se de que eles tenham o mesmo tamanho do argumento nivel ou classificador, respectivamente.

# Conclusão

O pacote sidra facilita a consulta aos dados do IBGE, possibilitando um
fluxo de trabalho mais ágil para análises de dados diretamente no R.
Para maiores informações, visite a documentação da API SIDRA e explore
as funções adicionais do pacote.

Esperamos que esta vignette ajude você a começar a usar o sidra e
realizar análises com dados do IBGE.
