#' Construct ranges
#'
#' @param lower,upper Numerics for lower and upper limits.
#' @param level Corresponding levels between 0 and 100.
#'
#' @return A "range" object
#' @examples
#' tie(lower = rnorm(10), upper = rnorm(10) + 5, level = 95)
#'
#' @export
tie <- function(lower, upper, level = NA_integer_) {
  if (any(upper < lower)) {
    stop("oops! 'upper' can't be lower than 'lower'.", call. = FALSE)
  }
  if (any(level < 0 | level > 100, na.rm = TRUE)) {
    stop("oops! 'level' can't be negative or greater than 100.", call. = FALSE)
  }
  out <- as.list(data.frame( 
    # use data.frame to take advantage of recycling "level"
    lower = lower, upper = upper, level = level,
    check.names = FALSE, fix.empty.names = FALSE, 
    stringsAsFactors = FALSE
  ))
  structure(out, class = "range")
}

#' @export
print.range <- function(x, ..., digits = NULL) {
  print(format(x, digits = digits), ...)
  invisible(x)
}

#' @export
format.range <- function(x, digits = NULL, ...) {
  format(compact_range(x, digits = digits), ...)
}

#' @export
is.na.range <- function(x) {
  # both lower and upper are NA's
  rowSums(is.na(as.data.frame(x))[1:2]) == 2
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
rep.range <- function(x, ...) {
  result <- lapply(x, FUN = rep, ...)
  attributes(result) <- attributes(x)
  result
}

#' @export
as.data.frame.range <- function(x, row.names = NULL, optional = FALSE, ...) {
  as.data.frame(unclass(x))
}

#' @export
duplicated.range <- function(x, incomparables = FALSE, ...) {
  duplicated(as.data.frame(x), incomparables = incomparables, ...)
}

#' @export
unique.range <- function(x, incomparables = FALSE, ...) {
  x[!duplicated(x, incomparables = incomparables, ...)]
}

#' @export
c.range <- function(..., recursive = FALSE) {
  as_range(as.list(do.call("rbind", lapply(list(...), as.data.frame))))
}
