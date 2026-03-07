# Configure report template

This function configures the content of the to-be-generated data
profiling report.

## Usage

``` r
configure_report(
  add_introduce = TRUE,
  add_plot_intro = TRUE,
  add_plot_str = TRUE,
  add_plot_missing = TRUE,
  add_plot_histogram = TRUE,
  add_plot_density = FALSE,
  add_plot_qq = TRUE,
  add_plot_bar = TRUE,
  add_plot_correlation = TRUE,
  add_plot_prcomp = TRUE,
  add_plot_boxplot = TRUE,
  add_plot_scatterplot = TRUE,
  introduce_args = list(),
  plot_intro_args = list(),
  plot_str_args = list(type = "diagonal", fontSize = 35, width = 1000, margin = list(left
    = 350, right = 250)),
  plot_missing_args = list(),
  plot_histogram_args = list(),
  plot_density_args = list(),
  plot_qq_args = list(sampled_rows = 1000L),
  plot_bar_args = list(),
  plot_correlation_args = list(cor_args = list(use = "pairwise.complete.obs")),
  plot_prcomp_args = list(),
  plot_boxplot_args = list(),
  plot_scatterplot_args = list(sampled_rows = 1000L),
  global_ggtheme = quote(theme_gray()),
  global_theme_config = list()
)
```

## Arguments

- add_introduce:

  add
  [introduce](http://boxuancui.github.io/DataExplorer/reference/introduce.md)?
  Default is `TRUE`.

- add_plot_intro:

  add
  [plot_intro](http://boxuancui.github.io/DataExplorer/reference/plot_intro.md)?
  Default is `TRUE`.

- add_plot_str:

  add
  [plot_str](http://boxuancui.github.io/DataExplorer/reference/plot_str.md)?
  Default is `TRUE`.

- add_plot_missing:

  add
  [plot_missing](http://boxuancui.github.io/DataExplorer/reference/plot_missing.md)?
  Default is `TRUE`.

- add_plot_histogram:

  add
  [plot_histogram](http://boxuancui.github.io/DataExplorer/reference/plot_histogram.md)?
  Default is `TRUE`.

- add_plot_density:

  add
  [plot_density](http://boxuancui.github.io/DataExplorer/reference/plot_density.md)?
  Default is `FALSE`.

- add_plot_qq:

  add
  [plot_qq](http://boxuancui.github.io/DataExplorer/reference/plot_qq.md)?
  Default is `TRUE`.

- add_plot_bar:

  add
  [plot_bar](http://boxuancui.github.io/DataExplorer/reference/plot_bar.md)?
  Default is `TRUE`.

- add_plot_correlation:

  add
  [plot_correlation](http://boxuancui.github.io/DataExplorer/reference/plot_correlation.md)?
  Default is `TRUE`.

- add_plot_prcomp:

  add
  [plot_prcomp](http://boxuancui.github.io/DataExplorer/reference/plot_prcomp.md)?
  Default is `TRUE`.

- add_plot_boxplot:

  add
  [plot_boxplot](http://boxuancui.github.io/DataExplorer/reference/plot_boxplot.md)?
  Default is `TRUE`.

- add_plot_scatterplot:

  add
  [plot_scatterplot](http://boxuancui.github.io/DataExplorer/reference/plot_scatterplot.md)?
  Default is `TRUE`.

- introduce_args:

  arguments to be passed to
  [introduce](http://boxuancui.github.io/DataExplorer/reference/introduce.md).
  Default is [`list()`](https://rdrr.io/r/base/list.html).

- plot_intro_args:

  arguments to be passed to
  [plot_intro](http://boxuancui.github.io/DataExplorer/reference/plot_intro.md).
  Default is [`list()`](https://rdrr.io/r/base/list.html).

- plot_str_args:

  arguments to be passed to
  [plot_str](http://boxuancui.github.io/DataExplorer/reference/plot_str.md).
  Default is
  `list(type = "diagonal", fontSize = 35, width = 1000, margin = list(left = 350, right = 250))`.

- plot_missing_args:

  arguments to be passed to
  [plot_missing](http://boxuancui.github.io/DataExplorer/reference/plot_missing.md).
  Default is [`list()`](https://rdrr.io/r/base/list.html).

- plot_histogram_args:

  arguments to be passed to
  [plot_histogram](http://boxuancui.github.io/DataExplorer/reference/plot_histogram.md).
  Default is [`list()`](https://rdrr.io/r/base/list.html).

- plot_density_args:

  arguments to be passed to
  [plot_density](http://boxuancui.github.io/DataExplorer/reference/plot_density.md).
  Default is [`list()`](https://rdrr.io/r/base/list.html).

- plot_qq_args:

  arguments to be passed to
  [plot_qq](http://boxuancui.github.io/DataExplorer/reference/plot_qq.md).
  Default is `list(sampled_rows = 1000L)`.

- plot_bar_args:

  arguments to be passed to
  [plot_bar](http://boxuancui.github.io/DataExplorer/reference/plot_bar.md).
  Default is [`list()`](https://rdrr.io/r/base/list.html).

- plot_correlation_args:

  arguments to be passed to
  [plot_correlation](http://boxuancui.github.io/DataExplorer/reference/plot_correlation.md).
  Default is `list("cor_args" = list("use" = "pairwise.complete.obs"))`.

- plot_prcomp_args:

  arguments to be passed to
  [plot_prcomp](http://boxuancui.github.io/DataExplorer/reference/plot_prcomp.md).
  Default is [`list()`](https://rdrr.io/r/base/list.html).

- plot_boxplot_args:

  arguments to be passed to
  [plot_boxplot](http://boxuancui.github.io/DataExplorer/reference/plot_boxplot.md).
  Default is [`list()`](https://rdrr.io/r/base/list.html).

- plot_scatterplot_args:

  arguments to be passed to
  [plot_scatterplot](http://boxuancui.github.io/DataExplorer/reference/plot_scatterplot.md).
  Default is `list(sampled_rows = 1000L)`.

- global_ggtheme:

  global setting for
  [theme](https://ggplot2.tidyverse.org/reference/theme.html). Default
  is `quote(theme_gray())`.

- global_theme_config:

  global setting for
  [theme](https://ggplot2.tidyverse.org/reference/theme.html). Default
  is [`list()`](https://rdrr.io/r/base/list.html).

## Note

Individual settings will overwrite global settings. For example: if
`plot_intro_args` has `ggtheme` set to
[`theme_light()`](https://ggplot2.tidyverse.org/reference/ggtheme.html)
while `global_ggtheme` is set to
[`theme_gray()`](https://ggplot2.tidyverse.org/reference/ggtheme.html),
[`theme_light()`](https://ggplot2.tidyverse.org/reference/ggtheme.html)
will be used.

When setting global themes using `global_ggtheme`, please pass an
unevaluated call to the theme function, e.g., `quote(theme_light())`.

## See also

[create_report](http://boxuancui.github.io/DataExplorer/reference/create_report.md)

## Examples

``` r
## Get default configuration
configure_report()
#> $introduce
#> list()
#> 
#> $plot_intro
#> $plot_intro$ggtheme
#> theme_gray()
#> 
#> $plot_intro$theme_config
#> list()
#> 
#> 
#> $plot_str
#> $plot_str$type
#> [1] "diagonal"
#> 
#> $plot_str$fontSize
#> [1] 35
#> 
#> $plot_str$width
#> [1] 1000
#> 
#> $plot_str$margin
#> $plot_str$margin$left
#> [1] 350
#> 
#> $plot_str$margin$right
#> [1] 250
#> 
#> 
#> 
#> $plot_missing
#> $plot_missing$ggtheme
#> theme_gray()
#> 
#> $plot_missing$theme_config
#> list()
#> 
#> 
#> $plot_histogram
#> $plot_histogram$ggtheme
#> theme_gray()
#> 
#> $plot_histogram$theme_config
#> list()
#> 
#> 
#> $plot_qq
#> $plot_qq$ggtheme
#> theme_gray()
#> 
#> $plot_qq$theme_config
#> list()
#> 
#> $plot_qq$sampled_rows
#> [1] 1000
#> 
#> 
#> $plot_bar
#> $plot_bar$ggtheme
#> theme_gray()
#> 
#> $plot_bar$theme_config
#> list()
#> 
#> 
#> $plot_correlation
#> $plot_correlation$ggtheme
#> theme_gray()
#> 
#> $plot_correlation$theme_config
#> list()
#> 
#> $plot_correlation$cor_args
#> $plot_correlation$cor_args$use
#> [1] "pairwise.complete.obs"
#> 
#> 
#> 
#> $plot_prcomp
#> $plot_prcomp$ggtheme
#> theme_gray()
#> 
#> $plot_prcomp$theme_config
#> list()
#> 
#> 
#> $plot_boxplot
#> $plot_boxplot$ggtheme
#> theme_gray()
#> 
#> $plot_boxplot$theme_config
#> list()
#> 
#> 
#> $plot_scatterplot
#> $plot_scatterplot$ggtheme
#> theme_gray()
#> 
#> $plot_scatterplot$theme_config
#> list()
#> 
#> $plot_scatterplot$sampled_rows
#> [1] 1000
#> 
#> 

## Set global theme
configure_report(global_ggtheme = quote(theme_light(base_size = 20L)))
#> $introduce
#> list()
#> 
#> $plot_intro
#> $plot_intro$ggtheme
#> theme_light(base_size = 20L)
#> 
#> $plot_intro$theme_config
#> list()
#> 
#> 
#> $plot_str
#> $plot_str$type
#> [1] "diagonal"
#> 
#> $plot_str$fontSize
#> [1] 35
#> 
#> $plot_str$width
#> [1] 1000
#> 
#> $plot_str$margin
#> $plot_str$margin$left
#> [1] 350
#> 
#> $plot_str$margin$right
#> [1] 250
#> 
#> 
#> 
#> $plot_missing
#> $plot_missing$ggtheme
#> theme_light(base_size = 20L)
#> 
#> $plot_missing$theme_config
#> list()
#> 
#> 
#> $plot_histogram
#> $plot_histogram$ggtheme
#> theme_light(base_size = 20L)
#> 
#> $plot_histogram$theme_config
#> list()
#> 
#> 
#> $plot_qq
#> $plot_qq$ggtheme
#> theme_light(base_size = 20L)
#> 
#> $plot_qq$theme_config
#> list()
#> 
#> $plot_qq$sampled_rows
#> [1] 1000
#> 
#> 
#> $plot_bar
#> $plot_bar$ggtheme
#> theme_light(base_size = 20L)
#> 
#> $plot_bar$theme_config
#> list()
#> 
#> 
#> $plot_correlation
#> $plot_correlation$ggtheme
#> theme_light(base_size = 20L)
#> 
#> $plot_correlation$theme_config
#> list()
#> 
#> $plot_correlation$cor_args
#> $plot_correlation$cor_args$use
#> [1] "pairwise.complete.obs"
#> 
#> 
#> 
#> $plot_prcomp
#> $plot_prcomp$ggtheme
#> theme_light(base_size = 20L)
#> 
#> $plot_prcomp$theme_config
#> list()
#> 
#> 
#> $plot_boxplot
#> $plot_boxplot$ggtheme
#> theme_light(base_size = 20L)
#> 
#> $plot_boxplot$theme_config
#> list()
#> 
#> 
#> $plot_scatterplot
#> $plot_scatterplot$ggtheme
#> theme_light(base_size = 20L)
#> 
#> $plot_scatterplot$theme_config
#> list()
#> 
#> $plot_scatterplot$sampled_rows
#> [1] 1000
#> 
#> 
```
