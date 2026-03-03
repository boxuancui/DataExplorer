# Plot histogram

Plot histogram for each continuous feature

## Usage

``` r
plot_histogram(
  data,
  by = NULL,
  binary_as_factor = TRUE,
  geom_histogram_args = list(bins = 30L),
  scale_x = "continuous",
  title = NULL,
  ggtheme = theme_gray(),
  theme_config = list(),
  nrow = 4L,
  ncol = 4L,
  parallel = FALSE,
  plotly = FALSE
)
```

## Arguments

- data:

  input data

- by:

  feature name to be broken down by. If `NULL`, no grouping. If a
  continuous feature, values are grouped into 5 equal ranges; otherwise
  all categories of a discrete feature are used.

- binary_as_factor:

  treat binary as categorical? Default is `TRUE`.

- geom_histogram_args:

  a list of other arguments to
  [geom_histogram](https://ggplot2.tidyverse.org/reference/geom_histogram.html)

- scale_x:

  scale of x axis. See
  [scale_x_continuous](https://ggplot2.tidyverse.org/reference/scale_continuous.html)
  for all options. Default is `continuous`.

- title:

  plot title

- ggtheme:

  complete ggplot2 themes. The default is
  [theme_gray](https://ggplot2.tidyverse.org/reference/ggtheme.html).

- theme_config:

  a list of configurations to be passed to
  [theme](https://ggplot2.tidyverse.org/reference/theme.html).

- nrow:

  number of rows per page. Default is 4.

- ncol:

  number of columns per page. Default is 4.

- parallel:

  enable parallel? Default is `FALSE`.

- plotly:

  if `TRUE`, convert to interactive plotly object (requires the plotly
  package). Default is `FALSE`.

## Value

invisibly return the named list of ggplot objects

## See also

[geom_histogram](https://ggplot2.tidyverse.org/reference/geom_histogram.html)
[plot_density](http://boxuancui.github.io/DataExplorer/dev/reference/plot_density.md)

## Examples

``` r
# Plot iris data
plot_histogram(iris, ncol = 2L)


# Plot histogram by a discrete feature
plot_histogram(iris, by = "Species", ncol = 2L)


# Plot skewed data on log scale
set.seed(1)
skew <- data.frame(replicate(4L, rbeta(1000, 1, 5000)))
plot_histogram(skew, ncol = 2L)

plot_histogram(skew, scale_x = "log10", ncol = 2L)
```
