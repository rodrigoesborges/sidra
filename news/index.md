# Changelog

## sidra 0.2.2

- Added CRAN downloads badge to README

## sidra 0.2.1

CRAN release: 2026-11-24

- tab_meta() no longer crashes on aggregates without classifications
  (e.g. table 6691): `lapply(1:length(...))` evaluated `1:0` and failed
  with ‘subscript out of bounds’ on `classificacoes[[1]]`
- sidra() omits the `classificacao` query parameter when the table has
  no classifications, instead of sending `classificacao=[all]`, and
  parses the response without classification columns in a dedicated
  branch

## sidra 0.2.0

CRAN release: 2026-09-18

- Suporte a tabelas sem classificacao (por exemplo a 6579, de populacao
  residente estimada). Antes, tab_meta() e tab_niveis() falhavam com
  “indice fora dos limites” e sidra() quebrava ao montar a consulta.
- Corrige a conversao de valores para numerico: o suppressWarnings
  envolvendo o mutate() inteiro anulava o as.numeric, devolvendo as
  colunas de codigos e valores como texto.
- Network-dependent tests now skip on CRAN and when the IBGE API is
  unreachable, removing intermittent test failures on CRAN check servers
- Fixed test of tab_agr, which was incorrectly exercising the sidra
  function
- Increased default timeout of API calls from 2 to 10 seconds for
  robustness on slow connections

## sidra 0.1.9

CRAN release: 2025-09-06

- fixes call_ibge for tests in Mac M1 and defaulting to not printing url
  in main function

## sidra 0.1.8

- added and fixed test of main function, gracefully handling
  connectivity issues

## sidra 0.1.7

CRAN release: 2025-08-27

- Added helper function and api url check handling with graceful exit if
  no access

## sidra 0.1.6

- Fixes documentation of functions and DESCRIPTION for resubmitting to
  CRAN

## sidra 0.1.5

- Fixes on sidra function return and optimization for reducing build and
  test times for CRAN

## sidra 0.1.4

- Fixes for CRAN and added tab_agrs function

## sidra 0.1.3

- Initial CRAN submission.

## sidra 0.1.2

- Added tab_search function

## sidra 0.1.1

- first preliminary main sidra function

## sidra 0.1.0

- Initial version
