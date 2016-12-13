#' Create correlation heatmap for discrete features
#'
#' This function creates a correlation heatmap for all discrete categories.
#' @param data input data to be plotted, in either \link{data.frame} or \link{data.table} format.
#' @param maxcat maximum categories allowed for each feature. The default is 20.
#' @param \dots other arguments to be passed to \link{cor}.
#' @keywords correlationdiscrete
#' @details The function first transposes all discrete categories into columns with binary outcomes, then calculates the correlation matrix (see \link{cor}) and plots it.
#' @import data.table
#' @import ggplot2
#' @importFrom stats cor
#' @export
#' @examples
#' # correlation of discrete categories from diamonds dataset
#' library(ggplot2)
#' data(diamonds)
#' CorrelationDiscrete(diamonds)

CorrelationDiscrete <- function(data, maxcat = 20, ...) {
  ## Declare variable first to pass R CMD check
  Var1 <- Var2 <- value <- discrete_id <- NULL
  ## Set data to data.table
  if (!is.data.table(data)) {data <- data.table(data)}
  ## Stop if no discrete features
  if (SplitColType(data)$num_discrete == 0) stop("No Discrete Features")
  ## Get discrete features
  discrete <- SplitColType(data.table(data))$discrete
  ## Get number of categories for each feature
  n_cat <- sapply(discrete, function(x) {length(unique(x))})
  ign_ind <- which(n_cat > maxcat)
  if (length(ign_ind) > 0) {
    set(discrete, j = ign_ind, value = NULL)
    message(length(ign_ind), " columns ignored with more than ", maxcat, " categories.\n", paste0(names(ign_ind), ": ", n_cat[ign_ind], " categories\n"))
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
  plot_data <- reshape2::melt(cor(discrete_pivot, ...))
  ## Create ggplot object
  plot <- ggplot(plot_data, aes(x = Var1, y = Var2, fill = value)) +
    geom_tile() +
    scale_fill_gradient2("Correlation Meter", low = "#0571b0", high = "#ca0020", space = "Lab") +
    xlab("Features") + ylab("Features") +
    theme(legend.position = "bottom", axis.text.x = element_text(angle = 90))
  if (ncol(discrete_pivot) <= 20) {plot <- plot + geom_text(aes(label = round(value, 2)))}
  ## Print plot object
  print(plot)
}
