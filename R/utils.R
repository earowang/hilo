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
  limit <- paste(
    format(x$lower, justify = "left"),
    format(x$upper, justify = "left"),
    sep = ", "
  )
  surround(limit, "[")
}

as_range <- function(x) {
  structure(x, class = "range")
}
