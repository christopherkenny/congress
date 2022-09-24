endpt <- function(type, ...) {
  if (missing(type)) {
    cli::cli_abort('{.arg type} missing in url building.')
  }

  out <- type

  dlist <- list(...)
  if (type == 'bill') {
    if (!is.null(dlist[['congress']])) {
      out <- paste0(type, '/', dlist[['congress']])
    }

  }

  out
}
