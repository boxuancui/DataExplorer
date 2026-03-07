# Visualize data structure

Visualize data structures in D3 network graph

## Usage

``` r
plot_str(
  data,
  type = c("diagonal", "radial"),
  max_level = NULL,
  print_network = TRUE,
  ...
)
```

## Arguments

- data:

  input data

- type:

  type of network diagram. Defaults to
  [diagonalNetwork](https://rdrr.io/pkg/networkD3/man/diagonalNetwork.html).

- max_level:

  integer threshold of nested level to be visualized. Minimum 1 nested
  level and defaults to all.

- print_network:

  logical indicating if network graph should be plotted. Defaults to
  `TRUE`.

- ...:

  other arguments to be passed to plotting functions. See
  [diagonalNetwork](https://rdrr.io/pkg/networkD3/man/diagonalNetwork.html)
  and
  [radialNetwork](https://rdrr.io/pkg/networkD3/man/radialNetwork.html).

## Value

input data structure in nested list. Could be transformed to json format
with most JSON packages.

## See also

[str](https://rdrr.io/r/utils/str.html)

## Examples

``` r
## Visualize structure of iris dataset
plot_str(iris)

## Visualize object with radial network
plot_str(rep(list(rep(list(mtcars), 6)), 4), type = "r")

## Generate complicated data object
obj <- list(
  "a" = list(iris, airquality, list(mtcars = mtcars, USArrests = USArrests)),
  "b" = list(list(ts(1:10, frequency = 4))),
  "c" = lm(rnorm(5) ~ seq(5)),
  "d" = lapply(1:5, function(x) return(as.function(function(y) y + 1)))
)
## Visualize data object with diagnal network
plot_str(obj, type = "d")
## Visualize only top 2 nested levels
plot_str(obj, type = "d", max_level = 2)
```
