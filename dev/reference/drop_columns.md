# Drop selected variables

Quickly drop variables by either column names or positions.

## Usage

``` r
drop_columns(data, ind)
```

## Arguments

- data:

  input data

- ind:

  a vector of either names or column positions of the variables to be
  dropped.

## Details

**This function updates
[data.table](https://rdrr.io/pkg/data.table/man/data.table.html) object
directly.** Otherwise, output data will be returned matching input
object class.

## Examples

``` r
# Load packages
library(data.table)

# Generate data
dt <- data.table(sapply(setNames(letters, letters), function(x) {assign(x, rnorm(10))}))
dt2 <- copy(dt)

# Drop variables by name
names(dt)
#>  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s"
#> [20] "t" "u" "v" "w" "x" "y" "z"
drop_columns(dt, letters[2L:25L])
names(dt)
#> [1] "a" "z"

# Drop variables by column position
names(dt2)
#>  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s"
#> [20] "t" "u" "v" "w" "x" "y" "z"
drop_columns(dt2, seq(2, 25))
names(dt2)
#> [1] "a" "z"

# Return from non-data.table input
df <- data.frame(sapply(setNames(letters, letters), function(x) {assign(x, rnorm(10))}))
drop_columns(df, letters[2L:25L])
#>              a           z
#> 1   0.14967935 -1.23891024
#> 2  -1.43332110  2.65489833
#> 3  -0.01030332 -0.15691719
#> 4  -0.21223603 -0.42349012
#> 5  -0.90634018 -0.19838706
#> 6  -2.10215248 -0.89480241
#> 7   1.89336046  0.90426912
#> 8  -0.96812584  0.07964921
#> 9  -0.10260304 -1.25882722
#> 10  0.23995957  1.02568511
```
