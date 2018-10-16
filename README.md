# DataExplorer <img src="man/figures/logo.png" align="right" style="width:120px;height:120px;/>

[![CRAN Version](http://www.r-pkg.org/badges/version/DataExplorer)](https://cran.r-project.org/package=DataExplorer)
[![Downloads](http://cranlogs.r-pkg.org/badges/DataExplorer)](https://cran.r-project.org/package=DataExplorer)
[![Total Downloads](http://cranlogs.r-pkg.org/badges/grand-total/DataExplorer)](https://cran.r-project.org/package=DataExplorer)

###### master v0.6.1

[![Travis Build Status](https://travis-ci.org/boxuancui/DataExplorer.svg?branch=master)](https://travis-ci.org/boxuancui/DataExplorer/branches)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/boxuancui/DataExplorer?branch=master&svg=true)](https://ci.appveyor.com/project/boxuancui/DataExplorer)
[![codecov](https://codecov.io/gh/boxuancui/DataExplorer/branch/master/graph/badge.svg)](https://codecov.io/gh/boxuancui/DataExplorer/branch/master)

###### develop v0.6.1.9000

[![Travis Build Status](https://travis-ci.org/boxuancui/DataExplorer.svg?branch=develop)](https://travis-ci.org/boxuancui/DataExplorer/branches)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/boxuancui/DataExplorer?branch=develop&svg=true)](https://ci.appveyor.com/project/boxuancui/DataExplorer)
[![codecov](https://codecov.io/gh/boxuancui/DataExplorer/branch/develop/graph/badge.svg)](https://codecov.io/gh/boxuancui/DataExplorer/branch/develop)

---

## Background
[Exploratory Data Analysis (EDA)](https://en.wikipedia.org/wiki/Exploratory_data_analysis) is the initial and an important phase of data analysis. Through this phase, analysts/modelers will have a first look of the data, and thus generate relevant hypothesis and decide next steps. However, the EDA process could be a hassle at times. This [R](https://cran.r-project.org/) package aims to automate most of data handling and visualization, so that users could focus on studying the data and extracting insights.

## Installation
The package can be installed directly from CRAN.

```R
install.packages("DataExplorer")
```

However, the latest stable version (if any) could be found on [GitHub](https://github.com/boxuancui/DataExplorer), and installed using `remotes` package.

```R
if (!require(remotes)) install.packages("remotes")
remotes::install_github("boxuancui/DataExplorer")
```

If you would like to install the latest [development version](https://github.com/boxuancui/DataExplorer/tree/develop), you may install the dev branch.

```R
if (!require(remotes)) install.packages("remotes")
remotes::install_github("boxuancui/DataExplorer", ref = "develop")
```

## Examples
The package is extremely easy to use. Almost everything could be done in one line of code. Please refer to the package manuals for more information. You may also find the package vignettes [here](https://CRAN.R-project.org/package=DataExplorer/vignettes/dataexplorer-intro.html).

#### Report
To get a report for the [airquality](https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/airquality.html) dataset:

```R
library(DataExplorer)
create_report(airquality)
```

To get a report for the [diamonds](http://docs.ggplot2.org/0.9.3.1/diamonds.html) dataset with response variable **price**:

```R
library(DataExplorer)
library(ggplot2)
create_report(diamonds, y = "price")
```

#### Visualization
You may also run all the plotting functions individually for your analysis, e.g.,

```R
library(DataExplorer)
library(ggplot2)

## View basic description for airquality data
introduce(airquality)
plot_intro(airquality)

## View missing value distribution for airquality data
plot_missing(airquality)

## View distribution of all discrete variables
plot_bar(diamonds)

## View `price` distribution of all discrete variables
plot_bar(diamonds, with = "price")

## View distribution of all continuous variables
plot_histogram(diamonds)

## View overall correlation heatmap
plot_correlation(diamonds)

## View bivariate continuous distribution based on `price`
plot_boxplot(diamonds, by = "price")
	
## Scatterplot `price` with all other features
plot_scatterplot(diamonds, by = "price")

## Visualize principle component analysis
plot_prcomp(iris)
```

#### Feature Engineering
To make quick updates to your data:

```R
library(DataExplorer)
library(ggplot2)

## Group bottom 20% `clarity` by frequency
group_category(diamonds, feature = "clarity", threshold = 0.2, update = TRUE)

## Group bottom 20% `clarity` by `price`
group_category(diamonds, feature = "clarity", threshold = 0.2, measure = "price", update = TRUE)

## Set values for missing observations
df <- data.frame("a" = rnorm(260), "b" = rep(letters, 10))
df[sample.int(260, 50), ] <- NA
set_missing(df, list(0L, "unknown"))

## Drop columns
drop_columns(diamonds, 8:10)
drop_columns(diamonds, "clarity")
```

## Articles

See [article wiki page](https://github.com/boxuancui/DataExplorer/wiki/Articles).
