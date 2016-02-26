## eda 0.2.0

### New Features
* added function `CollapseCategory` to collapse sparse categories for discrete features.
* added correlation heatmap for both continuous and discrete features.
* added density plot for continuous features.

### Bug Fixes

* fixed a bug in `BarDiscrete` and `CorrelationDiscrete` for not plotting non-factor class.

### Enhancement

* changed grid layout for `BarDiscrete` and `HistogramContinuous`.
* features with all missing values will be ignored.
* switched position between continuous and discrete features in report template.
* renamed package name to **eda**.
* added `NEWS.md`.
* removed `BoxplotContinuous`.
