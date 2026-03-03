# Plot objects with gridExtra

Plot multiple DataExplorer objects using grid.arrange

## Usage

``` r
# S3 method for class 'grid'
plotDataExplorer(
  plot_obj,
  title,
  ggtheme,
  theme_config,
  plotly = FALSE,
  page_layout,
  nrow,
  ncol,
  ...
)
```

## Arguments

- plot_obj:

  list of ggplot objects

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

- page_layout:

  a list of page indices with associated plot indices

- nrow:

  number of rows per page

- ncol:

  number of columns per page

- ...:

  other arguments to be passed

## Value

invisibly return the named list of ggplot objects

## See also

[plotDataExplorer](http://boxuancui.github.io/DataExplorer/dev/reference/plotDataExplorer.md)
[plotDataExplorer.single](http://boxuancui.github.io/DataExplorer/dev/reference/plotDataExplorer.single.md)
[plotDataExplorer.multiple](http://boxuancui.github.io/DataExplorer/dev/reference/plotDataExplorer.multiple.md)
