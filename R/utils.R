cat_line <- function(...) {
  cat(paste0(..., "\n"), sep = "")
}

big_mark <- function(x, ...) {
  mark <- if (identical(getOption("OutDec"), ",")) "." else ","
  formatC(x, big.mark = mark, ...)
}

dim_rng <- function(x) {
  dim_x <- dim(x)
  format_dim <- vapply(dim_x, big_mark, character(1))
  paste(format_dim, collapse = " x ")
}

surround <- function(x, bracket = "(") {
  if (bracket == "(") {
    return(paste0("(", x, ")"))
  } else if (bracket == "[") {
    return(paste0("[", x, "]"))
  } else {
    paste0("<", x, ">")
  }
}

compact_range <- function(x) {
  bound <- paste(
    format(x$lower, justify = "left"),
    format(x$upper, justify = "left"),
    sep = ", "
  )
  surround(bound, "[")
}
