#' Visualize principle component analysis
#'
#' Visualize output of \link{prcomp}.
#' @param data input data
#' @param variance_cap maximum cumulative explained variance allowed for all principle components. Default is 80\%.
#' @param maxcat maximum categories allowed for each discrete feature. The default is 50.
#' @param title plot title starting from page 2.
#' @param ggtheme complete ggplot2 themes. The default is \link{theme_gray}.
#' @param theme_config a list of configurations to be passed to \link{theme}.
#' @param \dots other arguments to be passed to \link{prcomp}.
#' @keywords plot_prcomp
#' @details When cumulative explained variance exceeds \code{variance_cap}, remaining principle components will be ignored. Set \code{variance_cap} to 1 for all principle components.
#' @details Discrete features containing more categories than \code{maxcat} specifies will be ignored.
#' @details To change default font family and size, you may pass \code{base_size} and \code{base_family} to \code{ggtheme} options, e.g., \code{ggtheme = theme_gray(base_size = 15, base_family = "serif")}
#' @details \code{theme_config} argument expects all inputs to be wrapped in a list object, e.g., to change the text color: \code{theme_config = list("text" = element_text(color = "blue"))}
#' @note Discrete features will be \link{dummify}-ed first before passing to \link{prcomp}.
#' @import data.table
#' @import ggplot2
#' @import scales
#' @importFrom stats prcomp
#' @export
#' @examples
#' data("diamonds", package = "ggplot2")
#' plot_prcomp(diamonds, maxcat = 5)

plot_prcomp <- function(data, variance_cap = 0.8, maxcat = 50L, title = NULL, ggtheme = theme_gray(), theme_config = list(), ...) {
  ## Declare variable first to pass R CMD check
  pc <- pct <- cum_pct <- Feature <- variable <- value <- NULL
  ## Check if input is data.table
  if (!is.data.table(data)) data <- data.table(data)
  ## Dummify data
  dt <- split_columns(dummify(data, maxcat = maxcat))$continuous
  ## Analyze principle components
  pca <- prcomp(dt, retx = FALSE, center = TRUE, scale. = TRUE, ...)
  ## Calcualte principle components standard deviation
  pcsd <- data.table(
    "pc" = paste0("PC", seq.int(length(pca$sdev))),
    "sd" = pca$sdev,
    "pct" = pca$sdev / sum(pca$sdev),
    "cum_pct" = cumsum(pca$sdev) / sum(pca$sdev)
  )
  pcsd2 <- pcsd[cum_pct <= variance_cap]
  ## Create explained variance plot
  varexp_plot <- ggplot(pcsd2, aes(x = reorder(pc, pct), y = pct)) +
    geom_bar(stat = "identity") +
    geom_text(aes(label = percent(cum_pct)), color = "white", hjust = 1.1) +
    scale_y_continuous(labels = percent) +
    coord_flip() +
    ggtitle(
      label = "% Variance Explained By Principle Components",
      subtitle = "Note: White texts indicate cumulative % explained variance"
    ) +
    labs(x = "Principle Components", y = "% Variance Explained", caption = "Page 1")
  print(varexp_plot)
  ## Format rotation data
  rotation_dt <- data.table("Feature" = rownames(pca$rotation), pca$rotation[, seq.int(nrow(pcsd2))])
  melt_rotation_dt <- melt.data.table(rotation_dt, id.vars = "Feature")
  ## Calculate number of pages
  p <- ncol(rotation_dt) - 1L
  pages <- ceiling(p / 9L)
  ## Plot rotation matrix
  for (pg in seq.int(pages)) {
    col_names <- names(rotation_dt)[seq.int(9L * pg - 8L, min(p, 9L * pg)) + 1L]
    n_col <- ifelse(length(col_names) %% 3L, length(col_names) %/% 3L + 1L, length(col_names) %/% 3L)
    plot <- ggplot(melt_rotation_dt[variable %in% col_names], aes(x = Feature, y = value)) +
      geom_bar(stat = "identity") +
      facet_wrap(~ variable, ncol = n_col, scales = "free_x") +
      coord_flip() +
      labs(y = "Relative Importance", title = title, caption = paste("Page", pg + 1L)) +
      ggtheme +
      do.call(theme, theme_config)
    print(plot)
  }
}
