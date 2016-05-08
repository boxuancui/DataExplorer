# Changelog

### DataExplorer 0.2.6.9000

---

### DataExplorer 0.2.6
#### Bug Fixes
* [#20](https://github.com/boxuancui/DataExplorer/issues/20): fixed permission denied bug due to intermediates_dir argument in `knitr::render`.

#### Enhancement
* [#16](https://github.com/boxuancui/DataExplorer/issues/16): improved handling of missing values.

---

### DataExplorer 0.2.5
#### Bug Fixes
* [#18](https://github.com/boxuancui/DataExplorer/issues/18): `GenerateReport` now handles data without discrete or continuous features.

#### Enhancement
* [#14](https://github.com/boxuancui/DataExplorer/issues/14): updated rmarkdown template for `GenerateReport`.
* [#1](https://github.com/boxuancui/DataExplorer/issues/1): features with all `NA` values will be ignored in `BarDiscrete`.

---

### DataExplorer 0.2.4
#### Bug Fixes
* fixed a major bug in `GenerateReport` function due to package renaming.

#### Enhancement
* `GenerateReport` will now print the directory of the report to console.

---

### DataExplorer 0.2.3
#### New Features
* added function `CollapseCategory` to collapse sparse categories for discrete features.
* added correlation heatmap for both continuous and discrete features.
* added density plot for continuous features.

#### Bug Fixes
* minor changes for CRAN re-submission.
* generate `eda-package.Rd` from `roxygen2` instead of creating it manually.
* fixed a bug in `BarDiscrete` and `CorrelationDiscrete` for not plotting non-factor class.

#### Enhancement
* changed grid layout for `BarDiscrete` and `HistogramContinuous`.
* features with all missing values will be ignored.
* switched position between continuous and discrete features in report template.
* renamed package name to **DataExplorer**.
* added `NEWS.md`.
* removed `BoxplotContinuous`.
