context("ontology")

test_that("ontology endpoint", {
  url <- getOption("epigraphdb.api.url")
  efo_term <- "blood pressure"
  r <- httr::GET(glue::glue("{url}/ontology/gwas-efo"),
    query = list(
      efo_term = efo_term
    )
  )
  expect_equal(httr::status_code(r), 200)
})

test_that("ontology mode = \"table\"", {
  efo_term <- "blood pressure"
  expect_error(
    df <- ontology_gwas_efo(
      efo_term = efo_term
    ),
    NA
  )
  expect_is(df, "tbl_df")
})

test_that("mr mode = \"raw\"", {
  efo_term <- "blood pressure"
  expect_error(
    response <- ontology_gwas_efo(
      efo_term = efo_term,
      mode = "raw"
    ),
    NA
  )
  expect_equal(length(response), 2L)
})
