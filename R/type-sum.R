#' @export
type_sum.range <- function(x) {
  "rng"
}


#' @export
obj_sum.range <- function(x) {
  rep("rng", length(x))
}

#' @export
is_vector_s3.range <- function(x) {
  TRUE
}

#' @export
pillar_shaft.range <- function(x, ...) {
  out <- compact_range(x)
  pillar::new_pillar_shaft_simple(out, align = "right", min_width = 10)
}
