## DataExplorer 0.2.4

### Bug Fixes

* Fixed a major bug in `GenerateReport` function due to package renaming.

### Enhancement

* `GenerateReport` will now print the directory of the report to console.

## DataExplorer 0.2.3

### New Features

* added function `CollapseCategory` to collapse sparse categories for discrete features.
* added correlation heatmap for both continuous and discrete features.
* added density plot for continuous features.

### Bug Fixes

* minor changes for CRAN re-submission.
* generate `eda-package.Rd` from `roxygen2` instead of creating it manually.
* fixed a bug in `BarDiscrete` and `CorrelationDiscrete` for not plotting non-factor class.

### Enhancement

* changed grid layout for `BarDiscrete` and `HistogramContinuous`.
* features with all missing values will be ignored.
* switched position between continuous and discrete features in report template.
* renamed package name to **DataExplorer**.
* added `NEWS.md`.
* removed `BoxplotContinuous`.
