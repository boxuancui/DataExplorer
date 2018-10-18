pkgname <- "DataExplorer"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
base::assign(".ExTimings", "DataExplorer-Ex.timings", pos = 'CheckExEnv')
base::cat("name\tuser\tsystem\telapsed\n", file=base::get(".ExTimings", pos = 'CheckExEnv'))
base::assign(".format_ptime",
function(x) {
  if(!is.na(x[4L])) x[1L] <- x[1L] + x[4L]
  if(!is.na(x[5L])) x[2L] <- x[2L] + x[5L]
  options(OutDec = '.')
  format(x[1L:3L], digits = 7L)
},
pos = 'CheckExEnv')

### * </HEADER>
library('DataExplorer')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("create_report")
### * create_report

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: create_report
### Title: create_report Function
### Aliases: create_report
### Keywords: create_report

### ** Examples

## Not run: 
##D #############################
##D ## Default config file     ##
##D ## Copy and edit if needed ##
##D #############################
##D config <- list(
##D   "introduce" = list(),
##D   "plot_str" = list(
##D     "type" = "diagonal",
##D     "fontSize" = 35,
##D     "width" = 1000,
##D     "margin" = list("left" = 350, "right" = 250)
##D   ),
##D   "plot_missing" = list(),
##D   "plot_histogram" = list(),
##D   "plot_qq" = list(sampled_rows = 1000L),
##D   "plot_bar" = list(),
##D   "plot_correlation" = list("cor_args" = list("use" = "pairwise.complete.obs")),
##D   "plot_prcomp" = list(),
##D   "plot_boxplot" = list(),
##D   "plot_scatterplot" = list()
##D )
##D 
##D # Create report
##D create_report(iris)
##D create_report(airquality, y = "Ozone")
##D 
##D # Load library
##D library(ggplot2)
##D library(data.table)
##D data("diamonds", package = "ggplot2")
##D 
##D # Set some missing values
##D diamonds2 <- data.table(diamonds)
##D for (j in 5:ncol(diamonds2)) {
##D   set(diamonds2,
##D       i = sample.int(nrow(diamonds2), sample.int(nrow(diamonds2), 1)),
##D       j,
##D       value = NA_integer_)
##D }
##D 
##D # Create customized report for diamonds2 dataset
##D create_report(
##D   data = diamonds2,
##D   output_file = "report.html",
##D   output_dir = getwd(),
##D   y = "price",
##D   config = list(
##D     "introduce" = list(),
##D     "plot_missing" = list(),
##D     "plot_histogram" = list(),
##D     "plot_qq" = list(sampled_rows = 1000L),
##D     "plot_bar" = list("with" = "carat"),
##D     "plot_correlation" = list("cor_args" = list("use" = "pairwise.complete.obs")),
##D     "plot_prcomp" = list(),
##D     "plot_boxplot" = list("by" = "carat"),
##D     "plot_scatterplot" = list("by" = "carat")
##D   ),
##D   html_document(toc = TRUE, toc_depth = 6, theme = "flatly")
##D )
## End(Not run)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("create_report", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("drop_columns")
### * drop_columns

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: drop_columns
### Title: Drop selected variables
### Aliases: drop_columns
### Keywords: drop_columns

### ** Examples

# Load packages
library(data.table)

# Generate data
dt <- data.table(sapply(setNames(letters, letters), function(x) {assign(x, rnorm(10))}))
dt2 <- copy(dt)

# Drop variables by name
names(dt)
drop_columns(dt, letters[2L:25L])
names(dt)

# Drop variables by column position
names(dt2)
drop_columns(dt2, seq(2, 25))
names(dt2)

# Return from non-data.table input
df <- data.frame(sapply(setNames(letters, letters), function(x) {assign(x, rnorm(10))}))
drop_columns(df, letters[2L:25L])



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("drop_columns", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("dummify")
### * dummify

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: dummify
### Title: Dummify discrete features to binary columns
### Aliases: dummify
### Keywords: dummify

### ** Examples

## Dummify iris dataset
str(dummify(iris))

## Dummify diamonds dataset ignoring features with more than 5 categories
data("diamonds", package = "ggplot2")
str(dummify(diamonds, maxcat = 5))
str(dummify(diamonds, select = c("cut", "color")))



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("dummify", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("group_category")
### * group_category

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: group_category
### Title: Group categories for discrete features
### Aliases: group_category
### Keywords: group_category

### ** Examples

# Load packages
library(data.table)

# Generate data
data <- data.table("a" = as.factor(round(rnorm(500, 10, 5))), "b" = rexp(500, 500))

# View cumulative frequency without collpasing categories
group_category(data, "a", 0.2)

# View cumulative frequency based on another measure
group_category(data, "a", 0.2, measure = "b")

# Group bottom 20% categories based on cumulative frequency
group_category(data, "a", 0.2, update = TRUE)
plot_bar(data)

# Exclude categories from being grouped
dt <- data.table("a" = c(rep("c1", 25), rep("c2", 10), "c3", "c4"))
group_category(dt, "a", 0.8, update = TRUE, exclude = c("c3", "c4"))
plot_bar(dt)

# Return from non-data.table input
df <- data.frame("a" = as.factor(round(rnorm(50, 10, 5))), "b" = rexp(50, 10))
group_category(df, "a", 0.2)
group_category(df, "a", 0.2, measure = "b", update = TRUE)
group_category(df, "a", 0.2, update = TRUE)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("group_category", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("introduce")
### * introduce

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: introduce
### Title: Describe basic information
### Aliases: introduce
### Keywords: introduce

### ** Examples

introduce(mtcars)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("introduce", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plotDataExplorer")
### * plotDataExplorer

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plotDataExplorer
### Title: Default DataExplorer plotting function
### Aliases: plotDataExplorer
### Keywords: internal

### ** Examples

library(ggplot2)
# Update theme of any plot objects
plot_missing(airquality, ggtheme = theme_light())
plot_missing(airquality, ggtheme = theme_minimal(base_size = 20))

# Customized theme components
plot_bar(
  data = diamonds,
  theme_config = list(
  "plot.background" = element_rect(fill = "yellow"),
  "aspect.ratio" = 1
  )
)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plotDataExplorer", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot_bar")
### * plot_bar

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot_bar
### Title: Plot bar chart
### Aliases: plot_bar
### Keywords: plot_bar

### ** Examples

# Load diamonds dataset from ggplot2
library(ggplot2)
data("diamonds", package = "ggplot2")

# Plot bar charts for diamonds dataset
plot_bar(diamonds)
plot_bar(diamonds, maxcat = 5)

# Plot bar charts with `price` feature
plot_bar(diamonds, with = "price")



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot_bar", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot_boxplot")
### * plot_boxplot

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot_boxplot
### Title: Create boxplot for continuous features
### Aliases: plot_boxplot
### Keywords: plot_boxplot

### ** Examples

plot_boxplot(iris, by = "Species", nrow = 2L, ncol = 2L)
plot_boxplot(iris, by = "Species", geom_boxplot_args = list("outlier.color" = "red"))



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot_boxplot", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot_correlation")
### * plot_correlation

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot_correlation
### Title: Create correlation heatmap for discrete features
### Aliases: plot_correlation
### Keywords: plot_correlation

### ** Examples

plot_correlation(iris)
plot_correlation(iris, type = "c")
plot_correlation(airquality, cor_args = list("use" = "pairwise.complete.obs"))



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot_correlation", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot_density")
### * plot_density

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot_density
### Title: Plot density estimates
### Aliases: plot_density
### Keywords: plot_density

### ** Examples

# Plot using iris data
plot_density(iris)

# Plot using random data
set.seed(1)
data <- cbind(sapply(seq.int(4L), function(x) {
          runif(500, min = sample(100, 1), max = sample(1000, 1))
        }))
plot_density(data)

# Add color to density area
plot_density(data, geom_density_args = list("fill" = "black", "alpha" = 0.6))



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot_density", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot_histogram")
### * plot_histogram

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot_histogram
### Title: Plot histogram
### Aliases: plot_histogram
### Keywords: plot_histogram

### ** Examples

# Plot iris data
plot_histogram(iris)

# Plot random data with customized geom_histogram settings
set.seed(1)
data <- cbind(sapply(seq.int(4L), function(x) {rnorm(1000, sd = 30 * x)}))
plot_histogram(data, geom_histogram_args = list("breaks" = seq(-400, 400, length = 50)))



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot_histogram", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot_intro")
### * plot_intro

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot_intro
### Title: Plot introduction
### Aliases: plot_intro
### Keywords: plot_intro

### ** Examples

plot_intro(airquality)
plot_intro(iris)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot_intro", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot_missing")
### * plot_missing

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot_missing
### Title: Plot missing value profile
### Aliases: plot_missing
### Keywords: plot_missing

### ** Examples

plot_missing(airquality)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot_missing", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot_prcomp")
### * plot_prcomp

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot_prcomp
### Title: Visualize principle component analysis
### Aliases: plot_prcomp
### Keywords: plot_prcomp

### ** Examples

plot_prcomp(
  data = na.omit(airquality),
  prcomp_args = list(scale. = TRUE),
  nrow = 2L,
  ncol = 2L
)

data("diamonds", package = "ggplot2")
plot_prcomp(diamonds, maxcat = 7L, prcomp_args = list(scale. = TRUE))



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot_prcomp", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot_qq")
### * plot_qq

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot_qq
### Title: Plot QQ plot
### Aliases: plot_qq
### Keywords: plot_qq

### ** Examples

plot_qq(iris)
plot_qq(iris, by = "Sepal.Width")
plot_qq(iris, by = "Species", nrow = 2L, ncol = 2L)

plot_qq(
  data = airquality,
  geom_qq_args = list(na.rm = TRUE),
  geom_qq_line_args = list(na.rm = TRUE)
)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot_qq", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot_scatterplot")
### * plot_scatterplot

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot_scatterplot
### Title: Create scatterplot for all features
### Aliases: plot_scatterplot
### Keywords: plot_scatterplot

### ** Examples

plot_scatterplot(iris, by = "Species")

library(ggplot2)
plot_scatterplot(
  data = mpg,
  by = "hwy",
  geom_point_args = list(size = 1L),
  theme_config = list("axis.text.x" = element_text(angle = 90)),
  ncol = 4L
)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot_scatterplot", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot_str")
### * plot_str

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot_str
### Title: Visualize data structure
### Aliases: plot_str
### Keywords: plot_str

### ** Examples

## Visualize structure of iris dataset
plot_str(iris)

## Visualize object with radial network
plot_str(rep(list(rep(list(mtcars), 6)), 4), type = "r")

## Generate complicated data object
obj <- list(
  "a" = list(iris, airquality, list(mtcars = mtcars, USArrests = USArrests)),
  "b" = list(list(ts(1:10, frequency = 4))),
  "c" = lm(rnorm(5) ~ seq(5)),
  "d" = lapply(1:5, function(x) return(as.function(function(y) y + 1)))
)
## Visualize data object with diagnal network
plot_str(obj, type = "d")
## Visualize only top 2 nested levels
plot_str(obj, type = "d", max_level = 2)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot_str", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("profile_missing")
### * profile_missing

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: profile_missing
### Title: Profile missing values
### Aliases: profile_missing
### Keywords: profile_missing

### ** Examples

profile_missing(airquality)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("profile_missing", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("set_missing")
### * set_missing

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: set_missing
### Title: Set all missing values to indicated value
### Aliases: set_missing
### Keywords: set_missing

### ** Examples

# Load packages
library(data.table)

# Generate missing values in iris data
dt <- data.table(iris)
for (j in 1:4) set(dt, i = sample.int(150, j * 30), j, value = NA_integer_)
set(dt, i = sample.int(150, 25), 5L, value = NA_character_)

# Set all missing values to 0L and unknown
dt2 <- copy(dt)
set_missing(dt2, list(0L, "unknown"))

# Set missing numerical values to 0L
dt3 <- copy(dt)
set_missing(dt3, 0L)

# Set missing discrete values to unknown
dt4 <- copy(dt)
set_missing(dt4, "unknown")

# Set missing values excluding some columns
dt5 <- copy(dt)
set_missing(dt4, 0L, 1L:2L)
set_missing(dt4, 0L, names(dt5)[3L:4L])

# Return from non-data.table input
set_missing(airquality, 999999L)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("set_missing", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("split_columns")
### * split_columns

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: split_columns
### Title: Split data into discrete and continuous parts
### Aliases: split_columns
### Keywords: split_columns

### ** Examples

output <- split_columns(iris)
output$discrete
output$continuous
output$num_discrete
output$num_continuous
output$num_all_missing



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("split_columns", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
