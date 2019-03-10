#' Plot missing value profile
#'
#' This function returns and plots frequency of missing values for each feature.
#' @param data input data
#' @param group missing profile band taking a list of group name and group upper bounds. Default is \code{list("Good" = 0.05, "OK" = 0.4, "Bad" = 0.8, "Remove" = 1)}.
#' @param title plot title
#' @param ggtheme complete ggplot2 themes. The default is \link{theme_gray}.
#' @param theme_config a list of configurations to be passed to \link{theme}.
#' @return invisibly return the ggplot object
#' @keywords plot_missing
#' @import ggplot2
#' @export
#' @seealso \link{profile_missing}
#' @examples
#' plot_missing(airquality)
#' plot_missing(airquality, group = list("B1" = 0, "B2" = 0.06, "B3" = 1))

plot_missing <- function(data, group = list("Good" = 0.05, "OK" = 0.4, "Bad" = 0.8, "Remove" = 1), title = NULL, ggtheme = theme_gray(), theme_config = list("legend.position" = c("bottom"))) {
  ## Declare variable first to pass R CMD check
  pct_missing <- Band <- NULL
  ## Profile missing values
  missing_value <- data.table(profile_missing(data))
  ## Sort group based on value
  group <- group[sort.list(unlist(group))]
  invisible(lapply(seq_along(group), function(i) {
    if (i == 1) {
      missing_value[pct_missing <= group[[i]], Band := names(group)[i]]
    } else {
      missing_value[pct_missing > group[[i-1]] & pct_missing <= group[[i]], Band := names(group)[i]]
    }
  }))
  ## Create ggplot object
  output <- ggplot(missing_value, aes_string(x = "feature", y = "num_missing", fill = "Band")) +
    geom_bar(stat = "identity") +
    geom_label(aes(label = paste0(round(100 * pct_missing, 2), "%"))) +
    scale_fill_discrete("Band") +
    coord_flip() +
    xlab("Features") + ylab("Missing Rows")
  ## Plot object
  class(output) <- c("single", class(output))
  plotDataExplorer(
    plot_obj = output,
    title = title,
    ggtheme = ggtheme,
    theme_config = theme_config
  )
}
