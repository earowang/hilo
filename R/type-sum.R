#' @export
type_sum.range <- function(x) {
  "rng"
}

#' @export
tbl_sum.range <- function(x) {
  c("Ranges" = dim_rng(x))
}

#' @export
obj_sum.range <- function(x) {
  compact_range(x)
}
