# Create correlation heatmap for discrete features

This function creates a correlation heatmap for all discrete categories.

## Usage

``` r
plot_correlation(
  data,
  type = c("all", "discrete", "continuous"),
  maxcat = 20L,
  cor_args = list(),
  geom_text_args = list(),
  title = NULL,
  ggtheme = theme_gray(),
  theme_config = list(legend.position = "bottom", axis.text.x = element_text(angle = 90)),
  plotly = FALSE
)
```

## Arguments

- data:

  input data

- type:

  column type to be included in correlation calculation. "all" for all
  columns, "discrete" for discrete features, "continuous" for continuous
  features.

- maxcat:

  maximum categories allowed for each discrete feature. The default is
  20.

- cor_args:

  a list of other arguments to [cor](https://rdrr.io/r/stats/cor.html)

- geom_text_args:

  a list of other arguments to
  [geom_text](https://ggplot2.tidyverse.org/reference/geom_text.html)

- title:

  plot title

- ggtheme:

  complete ggplot2 themes. The default is
  [theme_gray](https://ggplot2.tidyverse.org/reference/ggtheme.html).

- theme_config:

  a list of configurations to be passed to
  [theme](https://ggplot2.tidyverse.org/reference/theme.html).

- plotly:

  if `TRUE`, convert to interactive plotly object (requires the plotly
  package). Default is `FALSE`.

## Value

invisibly return the ggplot object

## Details

For discrete features, the function first dummifies all categories, then
calculates the correlation matrix (see
[cor](https://rdrr.io/r/stats/cor.html)) and plots it.

## Examples

``` r
plot_correlation(iris)

plot_correlation(iris, type = "c")

plot_correlation(airquality, cor_args = list("use" = "pairwise.complete.obs"))
```
