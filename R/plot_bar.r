#' Plot bar chart
#'
#' Plot bar chart for each discrete feature, based on either frequency or another continuous feature.
#' @param data input data
#' @param with name of continuous feature to be summed. Default is \code{NULL}, i.e., frequency.
#' @param by discrete feature name to be broken down by.
#' @param by_position position argument in \link{geom_bar} if \code{by} is supplied. Default is \code{"fill"}.
#' @param maxcat maximum categories allowed for each feature. Default is 50.
#' @param order_bar logical, indicating if bars should be ordered. Default is \code{TRUE}.
#' @param binary_as_factor treat binary as categorical? Default is \code{TRUE}.
#' @param title plot title
#' @param ggtheme complete ggplot2 themes. Default is \link{theme_gray}.
#' @param theme_config a list of configurations to be passed to \link{theme}
#' @param nrow number of rows per page. Default is 3.
#' @param ncol number of columns per page. Default is 3.
#' @param parallel enable parallel? Default is \code{FALSE}.
#' @param ... aesthetic mappings (e.g., fill = Species, alpha = 0.5)
#' @return invisibly return the named list of ggplot objects
#' @import data.table
#' @import ggplot2
#' @importFrom rlang enquos quo_is_symbolic eval_tidy expr
#' @importFrom stats reorder
#' @importFrom tools toTitleCase
#' @export

plot_bar <- function(data, with = NULL,
                     by = NULL, by_position = "fill",
                     maxcat = 50, order_bar = TRUE, binary_as_factor = TRUE,
                     title = NULL,
                     ggtheme = theme_gray(), theme_config = list(),
                     nrow = 3L, ncol = 3L,
                     parallel = FALSE,
                     ...) {
  ## Declare vars to avoid CMD check warnings
  frequency <- measure <- variable <- value <- facet_value <- NULL
  
  if (!is.data.table(data)) data <- data.table(data)
  
  split_data <- split_columns(data, binary_as_factor = binary_as_factor)
  if (split_data$num_discrete == 0) stop("No discrete features found!")
  
  discrete <- split_data$discrete
  
  ## Drop high-cardinality columns
  ind <- .ignoreCat(discrete, maxcat = maxcat)
  if (length(ind)) {
    message(length(ind), " columns ignored with more than ", maxcat, " categories.\n", paste0(names(ind), ": ", ind, " categories\n"))
    drop_columns(discrete, names(ind))
    if (length(discrete) == 0) stop("Note: All discrete features ignored! Nothing to plot!")
  }
  
  ## Aggregate values
  feature_names <- names(discrete)
  if (is.null(with)) {
    dt <- discrete[, list(frequency = .N), by = feature_names]
  } else {
    if (is.factor(data[[with]])) {
      measure_var <- suppressWarnings(as.numeric(levels(data[[with]]))[data[[with]]])
    } else if (is.character(data[[with]])) {
      measure_var <- as.numeric(data[[with]])
    } else {
      measure_var <- data[[with]]
    }
    if (all(is.na(measure_var))) stop("Failed to convert `", with, "` to continuous!")
    if (with %in% names(discrete)) drop_columns(discrete, with)
    tmp_dt <- data.table(discrete, "measure" = measure_var)
    dt <- tmp_dt[, list(frequency = sum(measure, na.rm = TRUE)), by = feature_names]
  }
  
  ## Reshape for plotting
  if (is.null(by)) {
    dt_tmp <- suppressWarnings(melt.data.table(dt, measure.vars = feature_names))
    dt2 <- dt_tmp[, list(frequency = sum(frequency)), by = list(variable, value)]
  } else {
    if (!(by %in% feature_names)) stop(paste0(by, " is not found as a discrete feature!"))
    dt_tmp <- suppressWarnings(melt.data.table(dt, measure.vars = setdiff(feature_names, by)))
    dt2 <- dt_tmp[, list(frequency = sum(frequency)), by = c("variable", "value", by)]
  }
  
  dt2[, facet_value := paste0(value, "___", variable)]
  
  ## Aesthetic handling
  dots_list <- enquos(...)
  flags <- vapply(dots_list, rlang::quo_is_symbolic, logical(1))
  mapped_aes <- dots_list[flags]
  constant_aes <- dots_list[!flags]
  
  layout <- .getPageLayout(nrow, ncol, ncol(discrete))
  
  plot_list <- .lapply(
    parallel = parallel,
    X = layout,
    FUN = function(x) {
      df <- dt2[variable %in% feature_names[x]]
      
      if (order_bar) {
        aes_base <- aes(x = reorder(facet_value, frequency), y = frequency)
      } else {
        aes_base <- aes(x = value, y = frequency)
      }
      
      aes_all <- modifyList(aes_base, eval_tidy(expr(aes(!!!mapped_aes))))
      
      layer_args <- c(
        list(stat = "identity", position = by_position),
        lapply(constant_aes, eval_tidy)
      )
      
      p <- ggplot(df, aes_all) +
        do.call("geom_bar", layer_args) +
        ylab(ifelse(is.null(with), "Frequency", toTitleCase(with))) +
        scale_x_discrete(labels = function(x) tstrsplit(x, "___")[[1]]) +
        coord_flip() +
        xlab("")
    }
  )
  
  class(plot_list) <- c("multiple", class(plot_list))
  plotDataExplorer(
    plot_obj = plot_list,
    page_layout = layout,
    title = title,
    ggtheme = ggtheme,
    theme_config = theme_config,
    facet_wrap_args = list(
      "facet" = ~ variable,
      "nrow" = nrow,
      "ncol" = ncol,
      "scales" = "free"
    )
  )
}
