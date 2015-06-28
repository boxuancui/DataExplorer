#' PlotMissing Function
#'
#' This function plots frequency of missing values for each feature.
#' @param data data to be analyzed
#' @keywords plotmissing
#' @export
#' @examples
#' PlotMissing()

PlotMissing <- function(data) {
  if (!is.data.table(data)) {data <- data.table(data)}
  # extract missing value distribution
  missing_value <- data.table("feature" = names(data), "num_missing" = sapply(data, function(x) {sum(is.na(x))}))
  missing_value[, feature := factor(feature, levels = feature[order(-rank(num_missing))])]
  missing_value[, pct_missing := num_missing/nrow(data)]
  missing_value[pct_missing<0.05, group:="Good"]
  missing_value[pct_missing>=0.05 & pct_missing<0.4, group:="OK"]
  missing_value[pct_missing>=0.4 & pct_missing<0.8, group:="Bad"]
  missing_value[pct_missing>=0.8, group:="Remove"]
  # create ggplot object
  plot <- ggplot(missing_value, aes_string(x="feature", y="num_missing", fill="group")) +
    geom_bar(stat="identity", alpha=0.4) + geom_bar(stat="identity", colour="black", alpha=0.4, show_guide=FALSE) +
    geom_text(aes(label=paste0(round(100*pct_missing, 0), "%")), hjust=-0.15, size=3.5) +
    scale_fill_manual("Group", values=c("Good"="#1a9641", "OK"="#a6d96a", "Bad"="#fdae61", "Remove"="#d7191c"), breaks=c("Good", "OK", "Bad", "Remove")) +
    scale_y_continuous(labels=comma) + theme(legend.position=c("bottom")) + coord_flip() +
    xlab("Features") + ylab("Number of missing rows")
  # print plot object
  print(plot)
  # set return object but do not print
  return(invisible(missing_value))
}