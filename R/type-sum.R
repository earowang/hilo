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

#' @export
is_vector_s3.range <- function(x) {
  TRUE
}

#' @export
pillar_shaft.range <- function(x, ...) {
  out <- compact_range(x)
  pillar::new_pillar_shaft_simple(out, align = "right")
}
