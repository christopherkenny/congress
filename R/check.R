check_format <- function(x) {
  match.arg(x, choices = c('json', 'xml'))
}
