is_ggplot <- if (exists("is_ggplot", envir = asNamespace("ggplot2"), inherits = FALSE)) {
  get("is_ggplot", envir = asNamespace("ggplot2"), inherits = FALSE)
} else {
  function(x) inherits(x, "ggplot")
}
