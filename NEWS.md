# Changelog

---

### DataExplorer 0.3.0.9000
#### Bug Fixes
* [#32](https://github.com/boxuancui/DataExplorer/issues/32): Fixed pandoc requirement error in unit test on cran.
* [#34](https://github.com/boxuancui/DataExplorer/issues/34): Fixed error message when `quiet` is not supplied. In addition, report directory are printed through `message()` instead of `cat()`.
* [#35](https://github.com/boxuancui/DataExplorer/issues/35): Added **rprojroot** to Suggests.

#### Enhancements
* [#36](https://github.com/boxuancui/DataExplorer/issues/36): Fixed warnings from data.table in `DropVar`.
* [#37](https://github.com/boxuancui/DataExplorer/issues/37): Changed all `cat()` to `message()`.
* Added more examples in README file.

---

### DataExplorer 0.3.0
#### New Features
* [#25](https://github.com/boxuancui/DataExplorer/issues/25): Added `SetNaTo` to quickly reset missing numerical values.
* [#29](https://github.com/boxuancui/DataExplorer/issues/29): Added `DropVar` to quickly drop variables by either name or column position.

#### Bug Fixes
* [#24](https://github.com/boxuancui/DataExplorer/issues/24): `CorrelationDiscrete` now displays all factor levels instead of contrasts from `model.matrix`.

#### Enhancements
* [#11](https://github.com/boxuancui/DataExplorer/issues/11): Functions with return values will now match the input class and set it back.
* [#22](https://github.com/boxuancui/DataExplorer/issues/22): Added documentation for **num_all_missing** in `SplitColType`.
* [#23](https://github.com/boxuancui/DataExplorer/issues/23): Added additional measures (in addition to frequency) to `CollapseCategory`.
* [#26](https://github.com/boxuancui/DataExplorer/issues/26): Removed density estimation section from report template.
* [#31](https://github.com/boxuancui/DataExplorer/issues/31): Added flexibility to name the new category in `CollapseCategory`.

#### Other notes
* [#30](https://github.com/boxuancui/DataExplorer/issues/30): In `CollapseCategory`, `update = TRUE` will only work with input data as `data.table`. However, it is still possible to view the frequency distribution with any input data class, as long as `update = FALSE`.

---

### DataExplorer 0.2.6
#### Bug Fixes
* [#20](https://github.com/boxuancui/DataExplorer/issues/20): Fixed permission denied bug due to intermediates_dir argument in `knitr::render`.

#### Enhancements
* [#16](https://github.com/boxuancui/DataExplorer/issues/16): Improved handling of missing values.

---

### DataExplorer 0.2.5
#### Bug Fixes
* [#18](https://github.com/boxuancui/DataExplorer/issues/18): `GenerateReport` now handles data without discrete or continuous features.

#### Enhancements
* [#14](https://github.com/boxuancui/DataExplorer/issues/14): Updated rmarkdown template for `GenerateReport`.
* [#1](https://github.com/boxuancui/DataExplorer/issues/1): Features with all `NA` values will be ignored in `BarDiscrete`.

---

### DataExplorer 0.2.4
#### Bug Fixes
* Fixed a major bug in `GenerateReport` function due to package renaming.

#### Enhancements
* `GenerateReport` will now print the directory of the report to console.

---

### DataExplorer 0.2.3
#### New Features
* Added function `CollapseCategory` to collapse sparse categories for discrete features.
* Added correlation heatmap for both continuous and discrete features.
* Added density plot for continuous features.

#### Bug Fixes
* Fixed a bug in `BarDiscrete` and `CorrelationDiscrete` for not plotting non-factor class.
* Minor changes for CRAN re-submission.

#### Enhancements
* Changed grid layout for `BarDiscrete` and `HistogramContinuous`.
* Features with all missing values will be ignored.
* Switched position between continuous and discrete features in report template.
* Renamed package name to **DataExplorer**.
* Added `NEWS.md`.
* Removed `BoxplotContinuous`.
