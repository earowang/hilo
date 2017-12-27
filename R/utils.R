surround <- function(x, bracket = "(") {
  if (bracket == "(") {
    return(paste0("(", x, ")"))
  } else if (bracket == "[") {
    return(paste0("[", x, "]"))
  } else {
    paste0("<", x, ">")
  }
}

compact_range <- function(x, digits = NULL) {
  limit <- paste(
    format(x$lower, justify = "right", digits = digits),
    format(x$upper, justify = "right", digits = digits),
    sep = ", "
  )
  surround(limit, "[")
}

as_range <- function(x) {
  structure(x, class = "range")
}
