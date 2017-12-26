#' Construct ranges
#'
#' @param lower,upper lower and upper limits
#' @param level between 0 and 100
#'
#' @export
tie <- function(lower, upper, level = NA_integer_) {
  out <- tibble::tibble(lower = lower, upper = upper, level = level)
  structure(out, class = c("range", "data.frame"))
}

#' @export
print.range <- function(x, ..., n = NULL, width = NULL, n_extra = NULL) {
  cat_line(format(x, ..., n = n, width = width, n_extra = n_extra))
  invisible(x)
}

#' @export
format.range <- function(x, ..., n = NULL, width = NULL, n_extra = NULL) {
  format(tibble::trunc_mat(x, n = n, width = width, n_extra = n_extra))
}
