# Plot introduction

Plot basic information (from
[introduce](http://boxuancui.github.io/DataExplorer/reference/introduce.md))
for input data.

## Usage

``` r
plot_intro(
  data,
  geom_label_args = list(),
  title = NULL,
  ggtheme = theme_gray(),
  theme_config = list(),
  plotly = FALSE
)
```

## Arguments

- data:

  input data

- geom_label_args:

  a list of other arguments to
  [geom_label](https://ggplot2.tidyverse.org/reference/geom_text.html)

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

## See also

[introduce](http://boxuancui.github.io/DataExplorer/reference/introduce.md)

## Examples

``` r
plot_intro(airquality)

plot_intro(iris)
```
