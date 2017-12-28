#' Construct ranges
#'
#' @param lower,upper A numeric vector of values for lower and upper limits.
#' @param level Default `NULL` does not include 'level'. Otherwise values of 
#' length 1 or as length of `lower`, expected between 0 and 100.
#'
#' @return A "range" object
#' @examples
#' tie(lower = rnorm(10), upper = rnorm(10) + 5, level = 95L)
#'
#' @export
tie <- function(lower, upper, level = NULL) {
  if (any(vapply(list(lower, upper), is.null, logical(1)))) {
    stop("no default for `lower` or `upper`.", call. = FALSE)
  }
  if (any(upper < lower, na.rm = TRUE)) {
    stop("'upper' can't be lower than 'lower'.", call. = FALSE)
  }
  len <- length(lower)
  if (is.null(level)) {
    return(as_range(Map(list, lower = lower, upper = upper)))
  } else if (any(level < 0 | level > 100, na.rm = TRUE)) {
    stop("'level' can't be negative or greater than 100.", call. = FALSE)
  } else if (!(length(level) %in% c(1, len))) {
    stop(gettextf("'level' should be of length 1 or %d.", len), call. = FALSE)
  } else {
    as_range(Map(list, lower = lower, upper = upper, level = level))
  }
}

#' Helpers for "range"
#'
#' @param x A "range" object.
#' @rdname helper
#'
#' @export
lower <- function(x) {
  stopifnot(is_range(x))
  x$lower
}

#' @rdname helper
#' @export
upper <- function(x) {
  stopifnot(is_range(x))
  x$upper
}

#' @rdname helper
#' @export
level <- function(x) {
  stopifnot(is_range(x))
  x$level
}

#' @rdname helper
#' @export
is_range <- function(x) {
  inherits(x, "range")
}

#' Validate whether values fall in the ranges
#'
#' @param x A numeric vector of values.
#' @param range A vector of ranges.
#'
#' @details "b/t" is short for "between". To achieve faster performance, one
#' could do `dplyr::between(x, lower(rng), upper(rng))`.
#'
#' @examples
#' rng <- tie(lower = rnorm(10), upper = rnorm(10) + 5)
#' bt(0.2017, rng)
#'
#' @export
bt <- function(x, range) {
  stopifnot(is.numeric(x) || is_range(range))
  x >= range$lower & x <= range$upper
}

#' @export
`$.range` <- function(x, name) {
  fast_unlist(lapply(x, "[[", name))
}

#' @export
`[.range` <- function(x, ..., drop = TRUE) {
  as_range(NextMethod())
}

#' @export
c.range <- function(..., recursive = FALSE) {
  as_range(fast_unlist(lapply(list(...), `[`)))
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
  rowSums(is.na(matrix(c(x$lower, x$upper), ncol = 2))) == 2
}

#' @export
duplicated.range <- function(x, incomparables = FALSE, fromLast = FALSE, ...) {
  mat <- matrix(c(x$lower, x$upper, x$level), ncol = 3)
  duplicated(mat, incomparables = incomparables, fromLast = fromLast, ...)
}

#' @export
unique.range <- function(x, incomparables = FALSE, ...) {
  x[!duplicated(x, incomparables = incomparables, ...)]
}

#' @export
rep.range <- function(x, ...) {
  as_range(NextMethod())
}

# as.data.frame.POSIXct with minor tweaks
#' @export
as.data.frame.range <- function(
  x, row.names = NULL, optional = FALSE, ..., 
  nm = paste(deparse(substitute(x), width.cutoff = 500L), collapse = " ")
) {
  force(nm)
  nr <- length(x)
  row_name_lgl <- is.character(row.names) && length(row.names) == nr
  if (!(is.null(row.names) || row_name_lgl)) {
    warning(
      gettextf("'row.names' is not a character vector of length %d.", nr), 
      domain = NA
    )
    row.names <- NULL
  }
  if (is.null(row.names)) {
    if (nr == 0L) {
      row.names <- character()
    } else if (length(row.names <- names(x)) != nr || anyDuplicated(row.names)) {
      row.names <- .set_row_names(nr)
    }
  }
  if (!is.null(names(x))) {
    names(x) <- NULL
  }
  value <- list(format(x))
  if (!optional) {
    names(value) <- nm
  }
  structure(value, row.names = row.names, class = "data.frame")
}
