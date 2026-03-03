# Describe basic information

Describe basic information for input data.

## Usage

``` r
introduce(data)
```

## Arguments

- data:

  input data

## Value

Describe basic information in input data class:

- rows: number of rows

- columns: number of columns

- discrete_columns: number of discrete columns

- continuous_columns: number of continuous columns

- all_missing_columns: number of columns with everything missing

- total_missing_values: number of missing observations

- complete_rows: number of rows without missing values. See
  [complete.cases](https://rdrr.io/r/stats/complete.cases.html).

- total_observations: total number of observations

- memory_usage: estimated memory allocation in bytes. See
  [object.size](https://rdrr.io/r/utils/object.size.html).

## Examples

``` r
introduce(mtcars)
#>   rows columns discrete_columns continuous_columns all_missing_columns
#> 1   32      11                0                 11                   0
#>   total_missing_values complete_rows total_observations memory_usage
#> 1                    0            32                352         5928
```
