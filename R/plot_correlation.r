#' Create correlation heatmap for discrete features
#'
#' This function creates a correlation heatmap for all discrete categories.
#' @param data input data to be plotted, in either \link{data.frame} or \link{data.table} format.
#' @param type column type to be included in correlation calculation. "all" for all columns, "discrete" for discrete features, "continuous" for continuous features.
#' @param maxcat maximum categories allowed for each discrete feature. The default is 20.
#' @param title plot title
#' @param \dots other arguments to be passed to \link{cor}.
#' @keywords plot_correlation
#' @aliases CorrelationDiscrete CorrelationContinuous
#' @details For discrete features, the function first dummifies all categories, then calculates the correlation matrix (see \link{cor}) and plots it.
#' @import data.table
#' @import ggplot2
#' @importFrom stats cor
#' @export plot_correlation CorrelationDiscrete CorrelationContinuous
#' @examples
#' # load diamonds dataset from ggplot2
#' data("diamonds", package = "ggplot2")
#'
#' # Plot correlation heatmap with all columns
#' plot_correlation(diamonds)
#' # Plot correlation heatmap with discrete features only
#' plot_correlation(diamonds, type = "d")
#' # Plot correlation heatmap with continuous features only
#' plot_correlation(diamonds, type = "c")

plot_correlation <- function(data, type = c("all", "discrete", "continuous"), maxcat = 20, title = NULL, ...) {
  ## Declare variable first to pass R CMD check
  Var1 <- Var2 <- value <- discrete_id <- NULL
  ## Set data to data.table
  if (!is.data.table(data)) {data <- data.table(data)}
  ## Split data
  split_data <- split_columns(data)
  ## Match column type and raise appropriate alerts if necessary
  col_type <- match.arg(type)
  if (col_type %in% c("all", "continuous")) {
    if ((col_type == "continuous") & (split_data$num_continuous <= 1)) stop("Not enough continuous features!")
    continuous <- split_data$continuous
  }
  if (col_type %in% c("all", "discrete")) {
    if ((col_type == "discrete") & (split_data$num_discrete == 0)) stop("No discrete features found!")
    discrete <- split_data$discrete
    ## Get number of categories for each feature
    n_cat <- sapply(discrete, function(x) {length(unique(x))})
    ign_ind <- which(n_cat > maxcat)
    n_true_discrete <- split_data$num_discrete - length(ign_ind)
    if (all(split_data$num_discrete, length(ign_ind), !n_true_discrete)) warning("Ignored all discrete features since `maxcat` set to ", maxcat, " categories!")
    if (n_true_discrete > 0) {
      if (length(ign_ind) > 0) {
        set(discrete, j = ign_ind, value = NULL)
        message(length(ign_ind), " features with more than ", maxcat, " categories ignored!\n", paste0(names(ign_ind), ": ", n_cat[ign_ind], " categories\n"))
      }
      ## Calculate categorical correlation and melt into tidy data format
      discrete[, discrete_id := seq(nrow(discrete))]
      discrete_pivot <- Reduce(
        function(x, y) {merge(x, y, by = "discrete_id")},
        lapply(names(discrete)[names(discrete) != "discrete_id"], function(x) {
          dcast.data.table(discrete, discrete_id ~ paste0(x, "_", get(x)), length, value.var = "discrete_id")
        })
      )
      discrete_pivot[, discrete_id := NULL]
    }
  }

  if (col_type == "all") {
    if (all(nrow(continuous), n_true_discrete)) {
      all_data <- cbind(continuous, discrete_pivot)
    } else if (nrow(continuous)) {
      all_data <- continuous
    } else if (n_true_discrete) {
      all_data <- discrete_pivot
    } else {
      stop("No data to plot!")
    }
  }

  ## Calculate correlation and melt into tidy data format
  final_data <- switch(col_type, "all" = all_data, "discrete" = discrete_pivot, "continuous" = continuous)
  plot_data <- reshape2::melt(cor(final_data, ...))
  ## Create ggplot object
  plot <- ggplot(plot_data, aes(x = Var1, y = Var2, fill = value)) +
    geom_tile() +
    scale_fill_gradient2("Correlation Meter", limits = c(-1, 1), low = "#0571b0", high = "#ca0020", space = "Lab") +
    xlab("Features") + ylab("Features") +
    theme(legend.position = "bottom", axis.text.x = element_text(angle = 90)) +
    ggtitle(label = title)
  if (ncol(final_data) <= 20) {plot <- plot + geom_text(aes(label = round(value, 2)))}
  ## Print plot object
  print(plot)
}

CorrelationDiscrete <- function(data, maxcat = 20, title = NULL, ...) {
  .Deprecated("plot_correlation")
  plot_correlation(data = data, type = "discrete", maxcat = maxcat, title = title, ...)
}

CorrelationContinuous <- function(data, title = NULL, ...) {
  .Deprecated("plot_correlation")
  plot_correlation(data = data, type = "continuous", title = title, ...)
}
