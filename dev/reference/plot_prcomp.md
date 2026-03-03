# Visualize principal component analysis

Visualize output of [prcomp](https://rdrr.io/r/stats/prcomp.html).

## Usage

``` r
plot_prcomp(
  data,
  variance_cap = 0.8,
  maxcat = 50L,
  prcomp_args = list(scale. = TRUE),
  geom_label_args = list(),
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

- variance_cap:

  maximum cumulative explained variance allowed for all principal
  components. Default is 80%.

- maxcat:

  maximum categories allowed for each discrete feature. The default is
  50.

- prcomp_args:

  a list of other arguments to
  [prcomp](https://rdrr.io/r/stats/prcomp.html)

- geom_label_args:

  a list of other arguments to
  [geom_label](https://ggplot2.tidyverse.org/reference/geom_text.html)

- title:

  plot title starting from page 2.

- ggtheme:

  complete ggplot2 themes. The default is
  [theme_gray](https://ggplot2.tidyverse.org/reference/ggtheme.html).

- theme_config:

  a list of configurations to be passed to
  [theme](https://ggplot2.tidyverse.org/reference/theme.html).

- nrow:

  number of rows per page

- ncol:

  number of columns per page

- parallel:

  enable parallel? Default is `FALSE`.

- plotly:

  if `TRUE`, convert to interactive plotly object (requires the plotly
  package). Default is `FALSE`.

## Value

invisibly return the named list of ggplot objects

## Details

When cumulative explained variance exceeds `variance_cap`, remaining
principal components will be ignored. Set `variance_cap` to 1 for all
principal components.

Discrete features containing more categories than `maxcat` specifies
will be ignored.

## Note

Discrete features will be
[dummify](http://boxuancui.github.io/DataExplorer/dev/reference/dummify.md)-ed
first before passing to [prcomp](https://rdrr.io/r/stats/prcomp.html).

Missing values may create issues in
[prcomp](https://rdrr.io/r/stats/prcomp.html). Consider
[na.omit](https://rdrr.io/r/stats/na.fail.html) your input data first.

Features with zero variance are dropped.

## Examples

``` r
plot_prcomp(na.omit(airquality), nrow = 2L, ncol = 2L)

```
