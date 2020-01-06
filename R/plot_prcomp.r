#' Visualize principal component analysis
#'
#' Visualize output of \link{prcomp}.
#' @param data input data
#' @param variance_cap maximum cumulative explained variance allowed for all principal components. Default is 80\%.
#' @param maxcat maximum categories allowed for each discrete feature. The default is 50.
#' @param prcomp_args a list of other arguments to \link{prcomp}
#' @param geom_label_args a list of other arguments to \link{geom_label}
#' @param title plot title starting from page 2.
#' @param ggtheme complete ggplot2 themes. The default is \link{theme_gray}.
#' @param theme_config a list of configurations to be passed to \link{theme}.
#' @param nrow number of rows per page
#' @param ncol number of columns per page
#' @param parallel enable parallel? Default is \code{FALSE}.
#' @return invisibly return the named list of ggplot objects
#' @keywords plot_prcomp
#' @details When cumulative explained variance exceeds \code{variance_cap}, remaining principal components will be ignored. Set \code{variance_cap} to 1 for all principal components.
#' @details Discrete features containing more categories than \code{maxcat} specifies will be ignored.
#' @note Discrete features will be \link{dummify}-ed first before passing to \link{prcomp}.
#' @note Missing values may create issues in \link{prcomp}. Consider \link{na.omit} your input data first.
#' @note Features with zero variance are dropped.
#' @import data.table
#' @import ggplot2
#' @importFrom scales percent
#' @importFrom stats prcomp
#' @export
#' @examples
#' plot_prcomp(na.omit(airquality), nrow = 2L, ncol = 2L)

plot_prcomp <- function(data,
                        variance_cap = 0.8,
                        maxcat = 50L,
                        prcomp_args = list("scale." = TRUE),
                        geom_label_args = list(),
                        title = NULL,
                        ggtheme = theme_gray(),
                        theme_config = list(), nrow = 3L, ncol = 3L,
                        parallel = FALSE) {
  ## Declare variable first to pass R CMD check
  pc <- pct <- cum_pct <- Feature <- variable <- value <- NULL
  ## Check if input is data.table
  if (!is.data.table(data)) data <- data.table(data)
  ## Dummify data
  dt <- suppressWarnings(split_columns(dummify(data, maxcat = maxcat))$continuous)
  zv_search <- sapply(dt, function(x) length(unique(x)) == 1)
  if (any(zv_search)) {
    warning("The following features are dropped due to zero variance:\n",
            paste0("\t* ", names(zv_search)[which(zv_search)], "\n"))
    drop_columns(dt, which(zv_search))
  }
  prcomp_args_list <- list("x" = dt, "retx" = FALSE)
  ## Analyze principal components
  pca <- tryCatch(
    do.call("prcomp", c(prcomp_args_list, prcomp_args)),
    error = function(e) {
      message(e$message)
      if (grepl("missing", e$message)) stop("\nConsider passing `na.omit(data)` as input.")
    }
  )
  
  ## Calcualte principal components standard deviation
  var_exp <- pca$sdev ^ 2
  pc_var <- data.table(
    "pc" = paste0("PC", seq_along(pca$sdev)),
    "var" = var_exp,
    "pct" = var_exp / sum(var_exp),
    "cum_pct" = cumsum(var_exp) / sum(var_exp)
  )
  min_cum_pct <- min(pc_var$cum_pct)
  pc_var2 <- pc_var[cum_pct <= max(variance_cap, min_cum_pct)]
  ## Create explained variance plot
  varexp_plot <- ggplot(pc_var2, aes(x = reorder(pc, pct), y = pct)) +
    geom_bar(stat = "identity") +
    scale_y_continuous(labels = percent) +
    coord_flip() +
    labs(x = "Principal Components", y = "% Variance Explained")
  geom_label_args_list <- list("mapping" = aes(label = percent(cum_pct)))
  varexp_plot <- varexp_plot +
    do.call("geom_label", c(geom_label_args_list, geom_label_args))
  ## Format rotation data
  rotation_dt <- data.table(
    "Feature" = rownames(pca$rotation),
    data.table(pca$rotation)[, seq.int(nrow(pc_var2)), with = FALSE]
  )
  melt_rotation_dt <- melt.data.table(rotation_dt, id.vars = "Feature")
  feature_names <- rotation_dt[["Feature"]]
  ## Calculate number of pages
  layout <- .getPageLayout(nrow, ncol, ncol(rotation_dt) - 1L)
  ## Create list of ggplot objects
  plot_list <- .lapply(
    parallel = parallel,
    X = layout,
    FUN = function(x) {
      ggplot(melt_rotation_dt[variable %in% paste0("PC", x)], aes(x = Feature, y = value)) +
        geom_bar(stat = "identity") +
        coord_flip() +
        ylab("Relative Importance")
    }
  )
  ## Plot objects
  class(varexp_plot) <- c("single", class(varexp_plot))
  class(plot_list) <- c("multiple", class(plot_list))
  invisible(c(
    list(
      "page_0" = plotDataExplorer(
        plot_obj = varexp_plot,
        title = "% Variance Explained By Principal Components\n(Note: Labels indicate cumulative % explained variance)",
        ggtheme = ggtheme,
        theme_config = theme_config
      )),
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
        "scales" = "free_x"
      )
    )
  ))
}
