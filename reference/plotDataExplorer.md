# Default DataExplorer plotting function

S3 method for plotting various DataExplorer objects

## Usage

``` r
plotDataExplorer(plot_obj, title, ggtheme, theme_config, plotly = FALSE, ...)
```

## Arguments

- plot_obj:

  plot object

- title:

  plot title

- ggtheme:

  complete ggplot2 themes

- theme_config:

  a list of configurations to be passed to
  [theme](https://ggplot2.tidyverse.org/reference/theme.html)

- plotly:

  if `TRUE`, convert ggplot to interactive plotly object (requires the
  plotly package). Default is `FALSE`.

- ...:

  other arguments to be passed

## Value

invisibly return the named list of ggplot objects

## Details

To change default font family and size, you may pass `base_size` and
`base_family` to `ggtheme` options, e.g.,
`ggtheme = theme_gray(base_size = 15, base_family = "serif")`

`theme_config` argument expects all inputs to be wrapped in a list
object, e.g., to change the text color:
`theme_config = list("text" = element_text(color = "blue"))`

## See also

[plotDataExplorer.grid](http://boxuancui.github.io/DataExplorer/reference/plotDataExplorer.grid.md)
[plotDataExplorer.single](http://boxuancui.github.io/DataExplorer/reference/plotDataExplorer.single.md)
[plotDataExplorer.multiple](http://boxuancui.github.io/DataExplorer/reference/plotDataExplorer.multiple.md)

## Examples

``` r
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
```
