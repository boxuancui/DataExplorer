# Plot multiple objects

Plot multiple DataExplorer objects with the defined layout

## Usage

``` r
# S3 method for class 'multiple'
plotDataExplorer(
  plot_obj,
  title,
  ggtheme,
  theme_config,
  plotly = FALSE,
  page_layout,
  facet_wrap_args = list(),
  ...
)
```

## Arguments

- plot_obj:

  list of ggplot objects separated by page

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

- facet_wrap_args:

  a list of other arguments to
  [facet_wrap](https://ggplot2.tidyverse.org/reference/facet_wrap.html)

- ...:

  other arguments to be passed

## Value

invisibly return the named list of ggplot objects

## See also

[plotDataExplorer](http://boxuancui.github.io/DataExplorer/dev/reference/plotDataExplorer.md)
[plotDataExplorer.grid](http://boxuancui.github.io/DataExplorer/dev/reference/plotDataExplorer.grid.md)
[plotDataExplorer.single](http://boxuancui.github.io/DataExplorer/dev/reference/plotDataExplorer.single.md)
