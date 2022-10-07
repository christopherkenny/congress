check_format <- function(x) {
  match.arg(x, choices = c('json', 'xml'))
}

check_date <- function(date) {
  if (is.null(date)) return(NULL)
  if (is.character(date)) {
    if (nchar(date) == 10) {
      date <- paste0(date, 'T00:00:00Z')
    }
  }
  date
}
