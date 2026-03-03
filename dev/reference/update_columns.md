# Update variable types or values

Quickly update selected variables using column names or positions.

## Usage

``` r
update_columns(data, ind, what)
```

## Arguments

- data:

  input data

- ind:

  a vector of either names or column positions of the variables to be
  dropped.

- what:

  either a function or a non-empty character string naming the function
  to be called. See [do.call](https://rdrr.io/r/base/do.call.html).

## Details

**This function updates
[data.table](https://rdrr.io/pkg/data.table/man/data.table.html) object
directly.** Otherwise, output data will be returned matching input
object class.

## Examples

``` r
str(update_columns(iris, 1L, as.factor))
#> 'data.frame':    150 obs. of  5 variables:
#>  $ Sepal.Length: Factor w/ 35 levels "4.3","4.4","4.5",..: 9 7 5 4 8 12 4 8 2 7 ...
#>  $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
#>  $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
#>  $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
#>  $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
#>  - attr(*, ".internal.selfref")=<externalptr> 
str(update_columns(iris, c("Sepal.Width", "Petal.Length"), "as.integer"))
#> 'data.frame':    150 obs. of  5 variables:
#>  $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
#>  $ Sepal.Width : int  3 3 3 3 3 3 3 3 2 3 ...
#>  $ Petal.Length: int  1 1 1 1 1 1 1 1 1 1 ...
#>  $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
#>  $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
#>  - attr(*, ".internal.selfref")=<externalptr> 

## Apply log transformation to all columns
summary(airquality)
#>      Ozone           Solar.R           Wind             Temp      
#>  Min.   :  1.00   Min.   :  7.0   Min.   : 1.700   Min.   :56.00  
#>  1st Qu.: 18.00   1st Qu.:115.8   1st Qu.: 7.400   1st Qu.:72.00  
#>  Median : 31.50   Median :205.0   Median : 9.700   Median :79.00  
#>  Mean   : 42.13   Mean   :185.9   Mean   : 9.958   Mean   :77.88  
#>  3rd Qu.: 63.25   3rd Qu.:258.8   3rd Qu.:11.500   3rd Qu.:85.00  
#>  Max.   :168.00   Max.   :334.0   Max.   :20.700   Max.   :97.00  
#>  NA's   :37       NA's   :7                                       
#>      Month            Day      
#>  Min.   :5.000   Min.   : 1.0  
#>  1st Qu.:6.000   1st Qu.: 8.0  
#>  Median :7.000   Median :16.0  
#>  Mean   :6.993   Mean   :15.8  
#>  3rd Qu.:8.000   3rd Qu.:23.0  
#>  Max.   :9.000   Max.   :31.0  
#>                                
summary(update_columns(airquality, names(airquality), log))
#>      Ozone          Solar.R           Wind             Temp      
#>  Min.   :0.000   Min.   :1.946   Min.   :0.5306   Min.   :4.025  
#>  1st Qu.:2.890   1st Qu.:4.751   1st Qu.:2.0015   1st Qu.:4.277  
#>  Median :3.450   Median :5.323   Median :2.2721   Median :4.369  
#>  Mean   :3.419   Mean   :5.008   Mean   :2.2272   Mean   :4.347  
#>  3rd Qu.:4.147   3rd Qu.:5.556   3rd Qu.:2.4423   3rd Qu.:4.443  
#>  Max.   :5.124   Max.   :5.811   Max.   :3.0301   Max.   :4.575  
#>  NA's   :37      NA's   :7                                       
#>      Month            Day       
#>  Min.   :1.609   Min.   :0.000  
#>  1st Qu.:1.792   1st Qu.:2.079  
#>  Median :1.946   Median :2.773  
#>  Mean   :1.924   Mean   :2.507  
#>  3rd Qu.:2.079   3rd Qu.:3.135  
#>  Max.   :2.197   Max.   :3.434  
#>                                 

## Force set factor to numeric
df <- data.frame("a" = as.factor(sample.int(10L)))
str(df)
#> 'data.frame':    10 obs. of  1 variable:
#>  $ a: Factor w/ 10 levels "1","2","3","4",..: 4 6 8 1 9 5 2 7 3 10
str(update_columns(df, "a", function(x) as.numeric(levels(x))[x]))
#> 'data.frame':    10 obs. of  1 variable:
#>  $ a: num  4 6 8 1 9 5 2 7 3 10
#>  - attr(*, ".internal.selfref")=<externalptr> 
```
