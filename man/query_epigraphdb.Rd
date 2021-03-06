% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/request_and_response.R
\name{query_epigraphdb}
\alias{query_epigraphdb}
\title{Send data request to an EpiGraphDB API endpoint}
\usage{
query_epigraphdb(
  route,
  params,
  mode = c("raw", "table"),
  method = c("GET", "POST")
)
}
\arguments{
\item{route}{An EpiGraphDB API endpoint route, e.g. \code{"/mr"} or \code{"/confounder"}.
Consult the \href{https://api.epigraphdb.org}{EpiGraphDB API documentation}.}

\item{params}{A list of parameters associated with the query endpoint.}

\item{mode}{\code{c("raw", "table")}, if \code{"table"} then the query handler will try
to convert the returned data to a tibble dataframe.
NOTE: The default mode is "raw" which will NOT convert the returned response to
a dataframe.
This is different to functions that query topic endpoints which
default to return a dataframe.
Explicitly specify \code{mode = "table"} when needed.}

\item{method}{Type of HTTP (GET, POST, PUT, etc.) method.

NOTE: When sending a POST request where a specific parameter is specified as a list on the API,
and if the equivalent in R is a vector of length 1, you should wrap this parameter
in \code{I()}, e.g. I(c("APOE")) to avoid auto unboxing.
For details, please refer to \href{https://httr.r-lib.org/reference/POST.html}{\code{httr::POST}}}
}
\value{
Data from an EpiGraphDB API endpoint.
}
\description{
This is a general purpose function to send data request
which can be used when there has not been an R equivalent package function
to an API endpoint.
Underneath this is a wrapper around \code{httr} functions with better handling of
returned status.
}
\examples{
# GET /mr
# equivalent to `mr(exposure_trait = "Body mass index", outcome_trait = "Coronary heart disease")`
query_epigraphdb(
  route = "/mr",
  params = list(
    exposure_trait = "Body mass index",
    outcome_trait = "Coronary heart disease"
  ),
  mode = "table"
)

# GET /meta/nodes/Gwas/list
query_epigraphdb(
  route = "/meta/nodes/Gwas/list",
  params = list(
    limit = 5,
    offset = 0
  )
) \%>\% str(1)

# POST /protein/ppi
query_epigraphdb(
  route = "/protein/ppi",
  params = list(
    uniprot_id_list = c("P30793", "Q9NZM1", "O95236")
  ),
  method = "POST"
)

# error handling
tryCatch(
  query_epigraphdb(
    route = "/mr",
    params = list(
      exposure_trait = NULL,
      outcome_trait = NULL
    )
  ),
  error = function(e) {
    message(e)
  }
)
}
