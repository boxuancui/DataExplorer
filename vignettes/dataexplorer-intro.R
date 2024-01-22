## ----setup, include=FALSE-----------------------------------------------------
library(rmarkdown)
library(knitr)
library(parallel)
library(DataExplorer)
library(data.table)
library(ggplot2)
library(nycflights13)
library(networkD3)
set.seed(1)

opts_chunk$set(
collapse = TRUE,
fig.width = 6,
fig.height = 6,
fig.align = "center",
warning = FALSE,
screenshot.force = FALSE
)


## ----install-data, eval=FALSE-------------------------------------------------
## install.packages("nycflights13")
## library(nycflights13)


## ----plot-str-template, eval=FALSE--------------------------------------------
## library(DataExplorer)
## data_list <- list(airlines, airports, flights, planes, weather)
## plot_str(data_list)


## ----plot-str-run, echo=FALSE-------------------------------------------------
data_list <- list(airlines, airports, flights, planes, weather)
diagonalNetwork(
  plot_str(data_list, print_network = FALSE),
  width = 800,
  height = 800,
  fontSize = 20,
  margin = list(
    "left" = 50,
    "right" = 50
  )
)


## ----merge-data---------------------------------------------------------------
merge_airlines <- merge(flights, airlines, by = "carrier", all.x = TRUE)
merge_planes <- merge(merge_airlines, planes, by = "tailnum", all.x = TRUE, suffixes = c("_flights", "_planes"))
merge_airports_origin <- merge(merge_planes, airports, by.x = "origin", by.y = "faa", all.x = TRUE, suffixes = c("_carrier", "_origin"))
final_data <- merge(merge_airports_origin, airports, by.x = "dest", by.y = "faa", all.x = TRUE, suffixes = c("_origin", "_dest"))


## ----eda-introduce-template, eval=FALSE---------------------------------------
## introduce(final_data)


## ----eda-introduce-run, echo=FALSE--------------------------------------------
kable(t(introduce(final_data)), row.names = TRUE, col.names = "", format.args = list(big.mark = ","))


## ----eda-plot-intro, fig.width=10, fig.height=8-------------------------------
plot_intro(final_data)


## ----eda-plot-missing-template, eval=FALSE------------------------------------
## plot_missing(final_data)


## ----eda-plot-missing, echo=FALSE, fig.width=8, fig.height=8------------------
plot_missing(final_data, geom_label_args = list(size = 3, label.padding = unit(0.1, "lines")))


## ----eda-drop-speed-----------------------------------------------------------
final_data <- drop_columns(final_data, "speed")


## ----eda-plot-bar-template, eval=FALSE----------------------------------------
## plot_bar(final_data)


## ----eda-plot-bar-run, echo=FALSE, fig.width=8, fig.height=12-----------------
plot_bar(final_data, theme_config = list("text" = element_text(size = 6)), nrow = 4L, ncol = 3L)


## ----eda-update-manufacturer--------------------------------------------------
final_data[which(final_data$manufacturer == "AIRBUS INDUSTRIE"),]$manufacturer <- "AIRBUS"
final_data[which(final_data$manufacturer == "CANADAIR LTD"),]$manufacturer <- "CANADAIR"
final_data[which(final_data$manufacturer %in% c("MCDONNELL DOUGLAS AIRCRAFT CO", "MCDONNELL DOUGLAS CORPORATION")),]$manufacturer <- "MCDONNELL DOUGLAS"

plot_bar(final_data$manufacturer)


## ----eda-drop-bar-features----------------------------------------------------
final_data <- drop_columns(final_data, c("dst_origin", "tzone_origin", "year_flights", "tz_origin"))


## ----eda-plot-bar-with-template, eval=FALSE-----------------------------------
## plot_bar(final_data, with = "arr_delay")


## ----eda-plot-bar-with-run, echo=FALSE, fig.width=8, fig.height=10------------
plot_bar(final_data, with = "arr_delay", theme_config = list("text" = element_text(size = 6)))


## ----eda-plot-bar-by-template, eval=FALSE-------------------------------------
## plot_bar(final_data, by = "origin")


## ----eda-plot-bar-by-run, echo=FALSE, fig.width=8, fig.height=10--------------
plot_bar(final_data, by = "origin", theme_config = list("text" = element_text(size = 6)))


## ----eda-plot-histogram-template, eval=FALSE----------------------------------
## plot_histogram(final_data)


## ----eda-plot-histogram, echo=FALSE, fig.width=8------------------------------
suppressWarnings(plot_histogram(final_data, nrow = 3L, ncol = 3L))


## ----eda-update-flight--------------------------------------------------------
final_data <- update_columns(final_data, "flight", as.factor)


## ----eda-drop-histogram-features----------------------------------------------
final_data <- drop_columns(final_data, c("year_flights", "tz_origin"))


## ----eda-plot-qq-template, eval=FALSE-----------------------------------------
## qq_data <- final_data[, c("arr_delay", "air_time", "distance", "seats")]
## 
## plot_qq(qq_data, sampled_rows = 1000L)


## ----eda-plot-qq, echo=FALSE--------------------------------------------------
qq_data <- final_data[, c("arr_delay", "air_time", "distance", "seats")]

plot_qq(
  qq_data,
  sampled_rows = 1000L,
  geom_qq_args = list("na.rm" = TRUE),
  geom_qq_line_args = list("na.rm" = TRUE),
  nrow = 2L,
  ncol = 2L
)


## ----eda-plot-qq-log-features-template, eval=FALSE----------------------------
## log_qq_data <- update_columns(qq_data, 2:4, function(x) log(x + 1))
## 
## plot_qq(log_qq_data[, 2:4], sampled_rows = 1000L)


## ----eda-plot-qq-log-features, echo=FALSE-------------------------------------
log_qq_data <- update_columns(qq_data, 2:4, function(x) log(x + 1))
plot_qq(
  log_qq_data[, 2:4],
  sampled_rows = 1000L,
  geom_qq_args = list("na.rm" = TRUE),
  geom_qq_line_args = list("na.rm" = TRUE),
  nrow = 2L,
  ncol = 2L
)


## ----eda-plot-qq-by-template, eval=FALSE--------------------------------------
## qq_data <- final_data[, c("name_origin", "arr_delay", "air_time", "distance", "seats")]
## 
## plot_qq(qq_data, by = "name_origin", sampled_rows = 1000L)


## ----eda-plot-qq-by, echo=FALSE, fig.width=8, fig.height=8--------------------
qq_data <- final_data[, c("name_origin", "arr_delay", "air_time", "distance", "seats")]
plot_qq(
  qq_data,
  by = "name_origin",
  geom_qq_args = list("na.rm" = TRUE),
  geom_qq_line_args = list("na.rm" = TRUE),
  sampled_rows = 1000L,
  nrow = 2L,
  ncol = 2L
)


## ----eda-plot-correlation, fig.width=8, fig.height=8--------------------------
plot_correlation(na.omit(final_data), maxcat = 5L)


## ----eda-plot-correlation-type, eval=FALSE------------------------------------
## plot_correlation(na.omit(final_data), type = "c")
## plot_correlation(na.omit(final_data), type = "d")


## ----eda-plot-prcomp, fig.width=8, fig.height=8-------------------------------
pca_df <- na.omit(final_data[, c("origin", "dep_delay", "arr_delay", "air_time", "year_planes", "seats")])

plot_prcomp(pca_df, variance_cap = 0.9, nrow = 2L, ncol = 2L)


## ----eda-plot-boxplot-template, eval=FALSE------------------------------------
## ## Reduce data size for demo purpose
## arr_delay_df <- final_data[, c("arr_delay", "month", "day", "hour", "minute", "dep_delay", "distance", "year_planes", "seats")]
## 
## ## Call boxplot function
## plot_boxplot(arr_delay_df, by = "arr_delay")


## ----eda-plot-boxplot, echo=FALSE, fig.width=8, fig.height=8------------------
arr_delay_df <- final_data[, c("arr_delay", "month", "day", "hour", "minute", "dep_delay", "distance", "year_planes", "seats")]
plot_boxplot(arr_delay_df, by = "arr_delay", geom_boxplot_args = list("na.rm" = TRUE), nrow = 3L, ncol = 3L)


## ----eda-plot-scatterplot-template, eval=FALSE--------------------------------
## arr_delay_df2 <- final_data[, c("arr_delay", "dep_time", "dep_delay", "arr_time", "air_time", "distance", "year_planes", "seats")]
## 
## plot_scatterplot(arr_delay_df2, by = "arr_delay", sampled_rows = 1000L)


## ----eda-plot-scatterplot, echo=FALSE, fig.width=8, fig.height=8--------------
arr_delay_df2 <- final_data[, c("arr_delay", "dep_time", "dep_delay", "arr_time", "air_time", "distance", "year_planes", "seats")]
plot_scatterplot(arr_delay_df2, by = "arr_delay", sampled_rows = 1000L, geom_point_args = list("size" = 0.5, "na.rm" = TRUE))


## ----fe-set-missing, collapse=TRUE--------------------------------------------
## Return data.frame
final_df <- set_missing(final_data, list(0L, "unknown"))
plot_missing(final_df)

## Update data.table by reference
# library(data.table)
# final_dt <- data.table(final_data)
# set_missing(final_dt, list(0L, "unknown"))
# plot_missing(final_dt)


## ----fe-group-category-count-trial--------------------------------------------
group_category(data = final_data, feature = "manufacturer", threshold = 0.2)


## ----fe-group-category-count-update, results='hide'---------------------------
final_df <- group_category(data = final_data, feature = "manufacturer", threshold = 0.2, update = TRUE)
plot_bar(final_df$manufacturer)


## ----fe-group-category-metric-trial-------------------------------------------
group_category(data = final_data, feature = "name_carrier", threshold = 0.2, measure = "distance")


## ----fe-group-category-metric-update, results='hide'--------------------------
final_df <- group_category(data = final_data, feature = "name_carrier", threshold = 0.2, measure = "distance", update = TRUE)
plot_bar(final_df$name_carrier)


## ----fe-dummify-template, eval=FALSE------------------------------------------
## plot_str(
##   list(
##     "original" = final_data,
##     "dummified" = dummify(final_data, maxcat = 5L)
##   )
## )


## ----fe-dummify-run, echo=FALSE-----------------------------------------------
diagonalNetwork(
  plot_str(list("original" = final_data, "dummified" = dummify(final_data, maxcat = 5L)), print_network = FALSE),
  width = 800,
  height = 1500,
  fontSize = 20,
  margin = list(
    "left" = 50,
    "right" = 50
  )
)


## ----fe-drop-columns----------------------------------------------------------
identical(
  drop_columns(final_data, c("dst_dest", "tzone_dest")),
  drop_columns(final_data, c(36, 37))
)


## ----update-feature-type------------------------------------------------------
temporal_features <- c("month", "day", "hour", "minute", "tz_dest")
final_data <- update_columns(final_data, temporal_features, as.factor)
str(final_data[, c("month", "day", "hour", "minute", "tz_dest")])


## ----update-feature-transformation--------------------------------------------
bin_seat <- function(x) cut(x, breaks = c(0L, 50L, 100L, 150L, 200L, 500L))
transformed_data <- update_columns(final_data, "seats", bin_seat)

plot_bar(transformed_data$seats)


## ----dr-create-report, eval=FALSE---------------------------------------------
## create_report(final_data)


## ----dr-create-report-with-y, eval=FALSE--------------------------------------
## create_report(final_data, y = "arr_delay")


## ----dr-configure-report------------------------------------------------------
configure_report(
  add_plot_str = FALSE,
  add_plot_qq = FALSE,
  add_plot_prcomp = FALSE,
  add_plot_boxplot = FALSE,
  add_plot_scatterplot = FALSE,
  global_ggtheme = quote(theme_minimal(base_size = 14))
)


## ----dr-create-report-customize, eval=FALSE-----------------------------------
## config <- configure_report(
##   add_plot_str = FALSE,
##   add_plot_qq = FALSE,
##   add_plot_prcomp = FALSE,
##   add_plot_boxplot = FALSE,
##   add_plot_scatterplot = FALSE,
##   global_ggtheme = quote(theme_minimal(base_size = 14))
## )
## create_report(final_data, config = config)


## ----dr-configure-report-customize, eval=FALSE--------------------------------
## config <- list(
##   "introduce" = list(),
##   "plot_intro" = list(),
##   "plot_str" = list(
##     "type" = "diagonal",
##     "fontSize" = 35,
##     "width" = 1000,
##     "margin" = list("left" = 350, "right" = 250)
##   ),
##   "plot_missing" = list(),
##   "plot_histogram" = list(),
##   "plot_density" = list(),
##   "plot_qq" = list(sampled_rows = 1000L),
##   "plot_bar" = list(),
##   "plot_correlation" = list("cor_args" = list("use" = "pairwise.complete.obs")),
##   "plot_prcomp" = list(),
##   "plot_boxplot" = list(),
##   "plot_scatterplot" = list(sampled_rows = 1000L)
## )
## create_report(final_data, config = config)

