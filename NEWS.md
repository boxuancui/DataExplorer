# Changelog

### DataExplorer 0.6.0
#### New Features
* [#15](https://github.com/boxuancui/DataExplorer/issues/15): Added `plot_prcomp` to visualize principle component analysis.
* [#54](https://github.com/boxuancui/DataExplorer/issues/54): Extracted `dummify` from `plot_correlation` as a new function.
* [#59](https://github.com/boxuancui/DataExplorer/issues/59): Added `introduce` for basic metadata.

#### Enhancements
* [#41](https://github.com/boxuancui/DataExplorer/issues/41): `create_report` can now be customized.
* [#53](https://github.com/boxuancui/DataExplorer/issues/53): Added page number for plots that span multiple pages.
* [#56](https://github.com/boxuancui/DataExplorer/issues/56): Added support for theme and customization for individual components.
* [#62](https://github.com/boxuancui/DataExplorer/issues/62): `plot_bar` now supports optional measures (in addition to categorical frequency) using argument `with`.
* `plot_missing`:
	* Percentage text labels from output plot now has 2 decimals to prevent small percentages from being truncated to 0%.
	* Added example to quickly drop columns with too many missing values.
* [#66](https://github.com/boxuancui/DataExplorer/issues/66): Feature engineering functions works on other classes in addition to just **data.table**.
* Added `.ignoreCat` to helper.

#### Bug Fixes
* [#55](https://github.com/boxuancui/DataExplorer/issues/55): Fixed bugs and updated vignette with latest functions.
* [#57](https://github.com/boxuancui/DataExplorer/issues/57): Fixed `plot_str` bug for not supporting S4 objects.
* [#63](https://github.com/boxuancui/DataExplorer/issues/63): Fixed `plot_histogram` and `plot_density` not working with column names containing spaces.


---

### DataExplorer 0.5.0
#### New Features
* [#48](https://github.com/boxuancui/DataExplorer/issues/48): Added `plot_scatterplot` to visualize relationship of one feature against all other.
* [#50](https://github.com/boxuancui/DataExplorer/issues/50): Added `plot_boxplot` to visualize continuous distributions broken down by another feature.

#### Enhancements
* [#44](https://github.com/boxuancui/DataExplorer/issues/44): Added option to exclude categories in `group_category`.
* [#45](https://github.com/boxuancui/DataExplorer/issues/45): Added title option for all plots.
* [#46](https://github.com/boxuancui/DataExplorer/issues/46): Added option to exclude columns in `set_missing`.
* [#49](https://github.com/boxuancui/DataExplorer/issues/49) **[Breaking Change]**: Switched package to [tidyverse style](http://style.tidyverse.org/). All old functions are in `.Deprecated` mode. List of name changes in alphabetical order:
	* `BarDiscrete` -> `plot_bar`
	* `CollapseCategory` -> `group_category`
	* `CorrelationContinuous`-> `plot_correlation(..., type = "continuous")`
	* `CorrelationDiscrete`-> `plot_correlation(..., type = "discrete")`
	* `DensityContinuous` -> `plot_density`
	* `DropVar` -> `drop_columns`
	* `GenerateReport` -> `create_report`
	* `HistogramContinuous` -> `plot_histogram`
	* `PlotMissing` -> `plot_missing`
	* `PlotStr` -> `plot_str`
	* `SetNaTo` -> `set_missing`
	* `SplitColType` -> `split_columns`
* [#52](https://github.com/boxuancui/DataExplorer/issues/52): Combined `CorrelationContinuous` and `CorrelationDiscrete` into one function, and added option to view correlation of all features at once.
* Optimized layout for multiple plots.

#### Bug Fixes
* [#47](https://github.com/boxuancui/DataExplorer/issues/47): Fixed color scale for correlation heatmap.

---

### DataExplorer 0.4.0
#### New Features
* [#33](https://github.com/boxuancui/DataExplorer/issues/33): Added `PlotStr` to visualize data structure.
* [#40](https://github.com/boxuancui/DataExplorer/issues/40): Added network graph to `GenerateReport`.

#### Bug Fixes
* [#32](https://github.com/boxuancui/DataExplorer/issues/32): Fixed pandoc requirement error in unit test on cran.
* [#34](https://github.com/boxuancui/DataExplorer/issues/34): Fixed error message when `quiet` is not supplied. In addition, report directory are printed through `message()` instead of `cat()`.
* [#35](https://github.com/boxuancui/DataExplorer/issues/35): Fixed **rprojroot** not found error.

#### Enhancements
* [#12](https://github.com/boxuancui/DataExplorer/issues/12): Added vignette: **dataexplorer-intro**.
* [#36](https://github.com/boxuancui/DataExplorer/issues/36): Fixed warnings from data.table in `DropVar`.
* [#37](https://github.com/boxuancui/DataExplorer/issues/37): Changed all `cat()` to `message()`.
* [#38](https://github.com/boxuancui/DataExplorer/issues/38): Added option to order bars in `BarDiscrete`.
* [#39](https://github.com/boxuancui/DataExplorer/issues/39): Extended `SetNaTo` to discrete features.
* Added more examples to **README.md**.

---

### DataExplorer 0.3.0
#### New Features
* [#25](https://github.com/boxuancui/DataExplorer/issues/25): Added `SetNaTo` to quickly reset missing numerical values.
* [#29](https://github.com/boxuancui/DataExplorer/issues/29): Added `DropVar` to quickly drop variables by either name or column position.

#### Bug Fixes
* [#24](https://github.com/boxuancui/DataExplorer/issues/24): `CorrelationDiscrete` now displays all factor levels instead of full rank matrix from `model.matrix`.

#### Enhancements
* [#11](https://github.com/boxuancui/DataExplorer/issues/11): Functions with return values will now match the input class and set it back.
* [#22](https://github.com/boxuancui/DataExplorer/issues/22): Added documentation for `num_all_missing` in `SplitColType`.
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
* Added **NEWS.md**.
* Removed `BoxplotContinuous`.
