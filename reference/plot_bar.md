# Plot bar chart

Plot bar chart for each discrete feature, based on either frequency or
another continuous feature.

## Usage

``` r
plot_bar(
  data,
  with = NULL,
  by = NULL,
  by_position = "fill",
  maxcat = 50,
  order_bar = TRUE,
  binary_as_factor = TRUE,
  title = NULL,
  ggtheme = theme_gray(),
  theme_config = list(),
  nrow = 3L,
  ncol = 3L,
  parallel = FALSE,
  plotly = FALSE
)
```

## Arguments

- data:

  input data

- with:

  name of continuous feature to be summed. Default is `NULL`, i.e.,
  frequency.

- by:

  discrete feature name to be broken down by.

- by_position:

  position argument in
  [geom_bar](https://ggplot2.tidyverse.org/reference/geom_bar.html) if
  `by` is supplied. Default is `"fill"`.

- maxcat:

  maximum categories allowed for each feature. Default is 50.

- order_bar:

  logical, indicating if bars should be ordered. Default is `TRUE`.

- binary_as_factor:

  treat binary as categorical? Default is `TRUE`.

- title:

  plot title

- ggtheme:

  complete ggplot2 themes. Default is
  [theme_gray](https://ggplot2.tidyverse.org/reference/ggtheme.html).

- theme_config:

  a list of configurations to be passed to
  [theme](https://ggplot2.tidyverse.org/reference/theme.html)

- nrow:

  number of rows per page. Default is 3.

- ncol:

  number of columns per page. Default is 3.

- parallel:

  enable parallel? Default is `FALSE`.

- plotly:

  if `TRUE`, convert to interactive plotly object (requires the plotly
  package). Default is `FALSE`.

## Value

invisibly return the named list of ggplot objects

## Details

If a discrete feature contains more categories than `maxcat` specifies,
it will not be passed to the plotting function.

## Examples

``` r
# Plot bar charts for diamonds dataset
library(ggplot2)
plot_bar(diamonds)

plot_bar(diamonds, maxcat = 5)
#> 2 columns ignored with more than 5 categories.
#> color: 7 categories
#> clarity: 8 categories


# Plot bar charts with `price`
plot_bar(diamonds, with = "price")


# Plot bar charts by `cut`
plot_bar(diamonds, by = "cut")

plot_bar(diamonds, by = "cut", by_position = "dodge")


if (FALSE) { # \dontrun{
# Interactive plotly version (requires the plotly package)
# plot_bar(diamonds, plotly = TRUE)
} # }
```
