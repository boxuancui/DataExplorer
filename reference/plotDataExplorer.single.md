# Plot single object

Plot single DataExplorer object

## Usage

``` r
# S3 method for class 'single'
plotDataExplorer(plot_obj, title, ggtheme, theme_config, plotly = FALSE, ...)
```

## Arguments

- plot_obj:

  single ggplot object

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

invisibly return the ggplot object

## See also

[plotDataExplorer](http://boxuancui.github.io/DataExplorer/reference/plotDataExplorer.md)
[plotDataExplorer.grid](http://boxuancui.github.io/DataExplorer/reference/plotDataExplorer.grid.md)
[plotDataExplorer.multiple](http://boxuancui.github.io/DataExplorer/reference/plotDataExplorer.multiple.md)
