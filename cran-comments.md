## Resubmission
This is a resubmission of the 'sidra' package. It fixes a bug in the
0.2.0 release (2026-09-18):

 * tab_meta() crashed with 'subscript out of bounds' when the aggregate
   has no classifications (e.g. IBGE table 6691, GDP of municipalities),
   because `1:length(NULL)` evaluated to `c(1, 0)`.
 * sidra() sent `classificacao=[all]` even for aggregates without
   classifications; the query parameter is now omitted and the response
   is parsed in a dedicated branch that handles the absence of the
   classification columns.

## R CMD check results

There were no ERRORs, WARNINGs, or NOTEs (R 4.5.3, x86_64 Linux).

The previous submission carried a NOTE about a possibly invalid URL
(https://servicodados.ibge.gov.br): the endpoint is correct and
reachable, but is intermittently inaccessible from servers outside
Brazil. Should the NOTE reappear on some CRAN check server, it is due
to these external network conditions; the URL is the official IBGE API
documentation and is essential to the package.
