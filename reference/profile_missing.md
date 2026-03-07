# Profile missing values

Analyze missing value profile

## Usage

``` r
profile_missing(data)
```

## Arguments

- data:

  input data

## Value

missing value profile, such as frequency, percentage and suggested
action.

## See also

[plot_missing](http://boxuancui.github.io/DataExplorer/reference/plot_missing.md)

## Examples

``` r
profile_missing(airquality)
#>   feature num_missing pct_missing
#> 1   Ozone          37  0.24183007
#> 2 Solar.R           7  0.04575163
#> 3    Wind           0  0.00000000
#> 4    Temp           0  0.00000000
#> 5   Month           0  0.00000000
#> 6     Day           0  0.00000000
```
