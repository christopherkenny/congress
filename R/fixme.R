year_to_congress <- function(x) {
    ceiling(x / 2) - 894
}
congress_to_start_year <- function(x) {
    2 * (x + 893)
}
