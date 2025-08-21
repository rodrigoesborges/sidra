## Resubmission
This is a resubmission of the 'sidra' package.

## R CMD check results

There were no ERRORs or WARNINGs.

There is one NOTE regarding a possibly invalid URL:

*   **URL: https://servicodados.ibge.gov.br/api/docs/agregados?versao=3**
    *   **Message:** `Connection timed out after 60000 milliseconds`

### Comments on the URL check NOTE

The URL `https://servicodados.ibge.gov.br` is the official and stable API endpoint for the Brazilian Institute of Geography and Statistics (IBGE), a major government agency in Brazil.

This URL is correct and valid. However, it appears to be intermittently inaccessible from some servers outside of Brazil, which likely includes some of the CRAN check servers. This is a known issue with this specific government service.

The URL is essential for the package's documentation as it points to the source of the data and the API's official documentation. I have verified that the link is active and correct. I kindly ask you to accept this NOTE, as it is due to external network conditions beyond my control.

Thank you for your consideration.


## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.
