# DataExplorer [![CRAN Version](http://www.r-pkg.org/badges/version/DataExplorer)](https://cran.r-project.org/package=DataExplorer) [![CRAN Downloads](http://cranlogs.r-pkg.org/badges/DataExplorer)](https://cran.r-project.org/package=DataExplorer) [![CRAN Total Downloads](http://cranlogs.r-pkg.org/badges/grand-total/DataExplorer)](https://cran.r-project.org/package=DataExplorer)

[![Master Version](https://img.shields.io/badge/master-0.2.6-orange.svg)](https://github.com/boxuancui/DataExplorer/tree/master)
[![Build Status](https://travis-ci.org/boxuancui/DataExplorer.svg?branch=master)](https://travis-ci.org/boxuancui/DataExplorer)
[![codecov.io](https://codecov.io/github/boxuancui/DataExplorer/coverage.svg?branch=master)](https://codecov.io/github/boxuancui/DataExplorer?branch=master)

[![Develop Version](https://img.shields.io/badge/develop-0.2.6.9000-orange.svg)](https://github.com/boxuancui/DataExplorer/tree/develop)
[![Build Status](https://travis-ci.org/boxuancui/DataExplorer.svg?branch=develop)](https://travis-ci.org/boxuancui/DataExplorer)
[![codecov.io](https://codecov.io/github/boxuancui/DataExplorer/coverage.svg?branch=develop)](https://codecov.io/github/boxuancui/DataExplorer?branch=develo[)

---

## Background
[Exploratory Data Analysis (EDA)](https://en.wikipedia.org/wiki/Exploratory_data_analysis) is the initial and an important phase of data analysis. Through this phase, analysts/modelers will have a first look of the data, and thus generate relevant hypothesis and decide next steps. However, the EDA process could be a hassle at times. This `R` package aims to automate most of data handling and visualization, so that users could focus on studying the data and extracting insights.

## Installation
The package can be installed from `github` using `devtools` package.

    if (!require(devtools)) install.packages("devtools")
    library(devtools)
    install_github("boxuancui/DataExplorer")

If you would like to get the latest development version, you may run the following code in `R`.

    if (!require(devtools)) install.packages("devtools")
    library(devtools)
    install_github("boxuancui/DataExplorer", ref="develop")

## Examples
The package is extremely easy to use. Almost everything could be done in one line of `R` code. Please refer to the package manuals for more information.

To get a report for the `iris` dataset:

    library(DataExplorer)
    GenerateReport(iris)

To get a report for the `diamonds` dataset in `ggplot2` package:

    library(DataExplorer)
    library(ggplot2)
    GenerateReport(diamonds)
