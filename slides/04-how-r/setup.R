# setup file to save data in various formats and to create the metadata

#' Gather variable metadata in Dataset JSON compliant format
#'
#' @param n Variable name
#' @param .data Dataset to gather attributes
#'
#' @returns Columns compliant data frame
extract_xpt_meta <- function(n, .data) {
  attrs <- attributes(.data[[n]]) # nolint
  
  out <- list()
  
  # Identify the variable type
  if (inherits(.data[[n]], "Date")) {
    out$dataType <- "date"
    out$targetDataType <- "integer"
  } else if (inherits(.data[[n]], "POSIXt")) {
    out$dataType <- "datetime"
    out$targetDataType <- "integer"
  } else if (inherits(.data[[n]], "numeric")) {
    if (any(is.double(.data[[n]]))) {
      out$dataType <- "float"
    } else {
      out$dataType <- "integer"
    }
  } else if (inherits(.data[[n]], "hms")) {
    out$dataType <- "time"
    out$targetDataType <- "integer"
  } else {
    out$dataType <- "string"
    out$length <- max(purrr::map_int(.data[[n]], nchar), 1L)
  }
  
  out$itemOID <- n
  out$name <- n
  out$label <- attr(.data[[n]], "label")
  out$displayFormat <- attr(.data[[n]], "format.sas")
  tibble::as_tibble(out)
}

# adsl ----
adsl <- pharmaverseadam::adsl
adsl_meta <- purrr::map_df(names(adsl), extract_xpt_meta, .data=adsl)

## rds
saveRDS(adsl, "data/adam/adsl.rds")
saveRDS(adsl_meta, "data/adam/metadata/adsl_meta.rds")

## arrow
arrow::write_parquet(adsl, "data/adam/adsl.parquet")
arrow::write_parquet(adsl_meta, "data/adam/metadata/adsl_meta.parquet")

# adae ----
adae <- pharmaverseadam::adae
adae_meta <- purrr::map_df(names(adae), extract_xpt_meta, .data=adae)

## rds
saveRDS(adae, "data/adam/adae.rds")
saveRDS(adae_meta, "data/adam/metadata/adae_meta.rds")

## arrow
arrow::write_parquet(adae, "data/adam/adae.parquet")
arrow::write_parquet(adae_meta, "data/adam/metadata/adae_meta.parquet")
