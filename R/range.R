#' Construct ranges
#'
#' @param lower,upper lower and upper limits
#' @param level between 0 and 100
#'
#' @export
tie <- function(lower, upper, level = NA_integer_) {
  out <- as.list(data.frame(
    lower = lower, upper = upper, level = level,
    check.names = FALSE, fix.empty.names = FALSE, 
    stringsAsFactors = FALSE
  ))
  structure(out, class = "range")
}

#' @export
print.range <- function(x, ..., n = NULL, width = NULL, n_extra = NULL) {
  print(format(x, ..., n = n, width = width, n_extra = n_extra))
  invisible(x)
}

#' @export
format.range <- function(x, ...) {
  format(compact_range(x))
}

#' @export
length.range <- function(x) {
  length(x[[1L]])
}

#' @export
`[.range` <- function(x, ..., drop = TRUE) {
  result <- lapply(x, FUN = "[", ..., drop = drop)
  attributes(result) <- attributes(x)
  result
}

#' @export
as.data.frame.range <- function(x, row.names = NULL, optional = FALSE, ...) {
  as.data.frame(unclass(x))
}

#' @export
c.range <- function(..., recursive = FALSE) {
  as_range(as.list(do.call("rbind", (lapply(list(...), as.data.frame)))))
}
