# DataExplorer 0.8.2
## Enhancements
* [#139](https://github.com/boxuancui/DataExplorer/issues/139): Added `by` argument to `plot_bar`.

## Bug Fixes
* [#148](https://github.com/boxuancui/DataExplorer/issues/148): Address CRAN removal due to vignette build failure.

# DataExplorer 0.8.1
## Enhancements
* [#111](https://github.com/boxuancui/DataExplorer/issues/111): Continuous distributions can now be plotted with different scales, i.e., histogram, density, boxplot, scatterplot.
* [#126](https://github.com/boxuancui/DataExplorer/issues/126): Cleaned up labels in legend guide.
* [#127 (PR)](https://github.com/boxuancui/DataExplorer/pull/127): Added option to plot columns with missing values only in `plot_missing`.
* Cleaned up code for `create_report`.

## Bug Fixes
* [#109](https://github.com/boxuancui/DataExplorer/issues/109): Fixed a bug causing unordered bar charts.
* [#114](https://github.com/boxuancui/DataExplorer/issues/114): Removed redundant message in `dummify`.
* [#116](https://github.com/boxuancui/DataExplorer/issues/116): Fixed pandoc document conversion error 99.
* [#120](https://github.com/boxuancui/DataExplorer/issues/120): Fixed type `logical` being parsed as `symbol` in `configure_report`.
* [#121](https://github.com/boxuancui/DataExplorer/issues/121): Fixed missing value bug when `split_columns(..., binary_as_factor = TRUE)`.
* [#130 (PR)](https://github.com/boxuancui/DataExplorer/pull/130): `plot_prcomp` now drops columns with zero variance.

# DataExplorer 0.8.0
## New Features
* [#92](https://github.com/boxuancui/DataExplorer/issues/92): Added `update_columns` to transform any selected columns.

## Enhancements
* [#87](https://github.com/boxuancui/DataExplorer/issues/87): Added `configure_report` function to customize report content.
* [#89](https://github.com/boxuancui/DataExplorer/issues/89): Added option to customize `geom_text` and `geom_label` arguments.
* [#91](https://github.com/boxuancui/DataExplorer/issues/91): `create_report` now displays full report directory after completion.
* [#95](https://github.com/boxuancui/DataExplorer/issues/95): Added better exception handling for `plot_bar`.
* [#98](https://github.com/boxuancui/DataExplorer/issues/98): Added band customization to `plot_missing`.
* [#100](https://github.com/boxuancui/DataExplorer/issues/100): Switched `geom_text` to `geom_label`.
* [#103](https://github.com/boxuancui/DataExplorer/issues/103): Report title can now be customized in `create_report`.
* [#108](https://github.com/boxuancui/DataExplorer/issues/108): Added option to treat binary features as discrete in `plot_bar`, `plot_histogram`, `plot_density` and `plot_boxplot`.
* Updated d3.min.js to v5.9.2.

## Bug Fixes
* [#88](https://github.com/boxuancui/DataExplorer/issues/88): Added `plot_intro` to report config.
* [#90](https://github.com/boxuancui/DataExplorer/issues/90): Added first plot in `plot_prcomp` to output and `page_0`.
* [#94](https://github.com/boxuancui/DataExplorer/issues/94): Fixed typo for PCA.

# DataExplorer 0.7.1
## Enhancements
* [#86](https://github.com/boxuancui/DataExplorer/issues/86): Replaced `gridExtra::grid.arrange` with facets.
* Added seeds to vignette and README for re-producible examples.
* Hid all internal functions.

# DataExplorer 0.7.0
## New Features
* [#72](https://github.com/boxuancui/DataExplorer/issues/72): Added `plot_qq` for QQ plot.
* [#76](https://github.com/boxuancui/DataExplorer/issues/76): Added `plot_intro` to visualize results of `introduce`.

## Enhancements
* [#42](https://github.com/boxuancui/DataExplorer/issues/42): Applied S3 methods for plotting functions.
* [#77](https://github.com/boxuancui/DataExplorer/issues/77): `dummify` now works on selected columns.
* [#78](https://github.com/boxuancui/DataExplorer/issues/78): All ggplot objects from `plot_*` are now invisibly returned. As a result, extracted `profile_missing` from `plot_missing` for missing value profiles.
* [#83](https://github.com/boxuancui/DataExplorer/issues/83): Removed all deprecated functions.
* [#85](https://github.com/boxuancui/DataExplorer/issues/85): Users can now specify number of rows/columns for plot page layout.
* `plot_prcomp` now passed `scale. = TRUE` to `prcomp` by default.
* Added `sampled_rows` argument to `plot_scatterplot`.
* Added option to parallelize plot object construction.
* Updated default config for `create_report`.

## Bug Fixes
* [#74](https://github.com/boxuancui/DataExplorer/issues/74): Fixed a bug causing `create_report` failure due to zero complete rows.
* [#75](https://github.com/boxuancui/DataExplorer/issues/75): Fixed a bug in `plot_str` when plotting data.frame with more than 100 columns.
* [#82](https://github.com/boxuancui/DataExplorer/issues/82): Removed hard-coded scales from all plot functions.
* Fixed a bug causing wrong column indices in `split_columns`.
* Fixed a bug using standard deviation instead of variance in `plot_prcomp`.

# DataExplorer 0.6.1
## Enhancements
* Updated vignette for better clarity.
* [#71](https://github.com/boxuancui/DataExplorer/issues/71): Added better error handler for `plot_prcomp`.

## Bug Fixes
* [#69](https://github.com/boxuancui/DataExplorer/issues/69): Fixed bug causing `create_report` failure (specifically from `plot_prcomp`) when `y` is specified.
* Added more unit tests for `create_report` and `plot_prcomp`.

# DataExplorer 0.6.0
## New Features
* [#15](https://github.com/boxuancui/DataExplorer/issues/15): Added `plot_prcomp` to visualize principal component analysis.
* [#54](https://github.com/boxuancui/DataExplorer/issues/54): Extracted `dummify` from `plot_correlation` as a new function.
* [#59](https://github.com/boxuancui/DataExplorer/issues/59): Added `introduce` for basic metadata.

## Enhancements
* [#41](https://github.com/boxuancui/DataExplorer/issues/41): `create_report` can now be customized.
* [#53](https://github.com/boxuancui/DataExplorer/issues/53): Added page number for plots that span multiple pages.
* [#56](https://github.com/boxuancui/DataExplorer/issues/56): Added support for theme and customization for individual components.
* [#62](https://github.com/boxuancui/DataExplorer/issues/62): `plot_bar` now supports optional measures (in addition to categorical frequency) using argument `with`.
* [#66](https://github.com/boxuancui/DataExplorer/issues/66): Feature engineering functions works on other classes in addition to just **data.table**.
* `plot_missing`:
	* Percentage text labels from output plot now has 2 decimals to prevent small percentages from being truncated to 0%.
	* Added example to quickly drop columns with too many missing values.
* Added `.ignoreCat` and `.getAllMissing` to helper.

## Bug Fixes
* [#55](https://github.com/boxuancui/DataExplorer/issues/55): Fixed bugs and updated vignette with latest functions.
* [#57](https://github.com/boxuancui/DataExplorer/issues/57): Fixed `plot_str` bug for not supporting S4 objects.
* [#63](https://github.com/boxuancui/DataExplorer/issues/63): Fixed `plot_histogram` and `plot_density` not working with column names containing spaces.

# DataExplorer 0.5.0
## New Features
* [#48](https://github.com/boxuancui/DataExplorer/issues/48): Added `plot_scatterplot` to visualize relationship of one feature against all other.
* [#50](https://github.com/boxuancui/DataExplorer/issues/50): Added `plot_boxplot` to visualize continuous distributions broken down by another feature.

## Enhancements
* [#44](https://github.com/boxuancui/DataExplorer/issues/44): Added option to exclude categories in `group_category`.
* [#45](https://github.com/boxuancui/DataExplorer/issues/45): Added title option for all plots.
* [#46](https://github.com/boxuancui/DataExplorer/issues/46): Added option to exclude columns in `set_missing`.
* [#49](https://github.com/boxuancui/DataExplorer/issues/49) **[Breaking Change]**: Switched package to [tidyverse style](https://style.tidyverse.org/). All old functions are in `.Deprecated` mode. List of name changes in alphabetical order:
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

## Bug Fixes
* [#47](https://github.com/boxuancui/DataExplorer/issues/47): Fixed color scale for correlation heatmap.

# DataExplorer 0.4.0
## New Features
* [#33](https://github.com/boxuancui/DataExplorer/issues/33): Added `PlotStr` to visualize data structure.
* [#40](https://github.com/boxuancui/DataExplorer/issues/40): Added network graph to `GenerateReport`.

## Bug Fixes
* [#32](https://github.com/boxuancui/DataExplorer/issues/32): Fixed pandoc requirement error in unit test on cran.
* [#34](https://github.com/boxuancui/DataExplorer/issues/34): Fixed error message when `quiet` is not supplied. In addition, report directory are printed through `message()` instead of `cat()`.
* [#35](https://github.com/boxuancui/DataExplorer/issues/35): Fixed **rprojroot** not found error.

## Enhancements
* [#12](https://github.com/boxuancui/DataExplorer/issues/12): Added vignette: **dataexplorer-intro**.
* [#36](https://github.com/boxuancui/DataExplorer/issues/36): Fixed warnings from data.table in `DropVar`.
* [#37](https://github.com/boxuancui/DataExplorer/issues/37): Changed all `cat()` to `message()`.
* [#38](https://github.com/boxuancui/DataExplorer/issues/38): Added option to order bars in `BarDiscrete`.
* [#39](https://github.com/boxuancui/DataExplorer/issues/39): Extended `SetNaTo` to discrete features.
* Added more examples to **README.md**.

# DataExplorer 0.3.0
## New Features
* [#25](https://github.com/boxuancui/DataExplorer/issues/25): Added `SetNaTo` to quickly reset missing numerical values.
* [#29](https://github.com/boxuancui/DataExplorer/issues/29): Added `DropVar` to quickly drop variables by either name or column position.

## Bug Fixes
* [#24](https://github.com/boxuancui/DataExplorer/issues/24): `CorrelationDiscrete` now displays all factor levels instead of full rank matrix from `model.matrix`.

## Enhancements
* [#11](https://github.com/boxuancui/DataExplorer/issues/11): Functions with return values will now match the input class and set it back.
* [#22](https://github.com/boxuancui/DataExplorer/issues/22): Added documentation for `num_all_missing` in `SplitColType`.
* [#23](https://github.com/boxuancui/DataExplorer/issues/23): Added additional measures (in addition to frequency) to `CollapseCategory`.
* [#26](https://github.com/boxuancui/DataExplorer/issues/26): Removed density estimation section from report template.
* [#31](https://github.com/boxuancui/DataExplorer/issues/31): Added flexibility to name the new category in `CollapseCategory`.

## Other notes
* [#30](https://github.com/boxuancui/DataExplorer/issues/30): In `CollapseCategory`, `update = TRUE` will only work with input data as `data.table`. However, it is still possible to view the frequency distribution with any input data class, as long as `update = FALSE`.

# DataExplorer 0.2.6
## Bug Fixes
* [#20](https://github.com/boxuancui/DataExplorer/issues/20): Fixed permission denied bug due to intermediates_dir argument in `knitr::render`.

## Enhancements
* [#16](https://github.com/boxuancui/DataExplorer/issues/16): Improved handling of missing values.

# DataExplorer 0.2.5
## Bug Fixes
* [#18](https://github.com/boxuancui/DataExplorer/issues/18): `GenerateReport` now handles data without discrete or continuous features.

## Enhancements
* [#14](https://github.com/boxuancui/DataExplorer/issues/14): Updated rmarkdown template for `GenerateReport`.
* [#1](https://github.com/boxuancui/DataExplorer/issues/1): Features with all `NA` values will be ignored in `BarDiscrete`.

# DataExplorer 0.2.4
## Bug Fixes
* Fixed a major bug in `GenerateReport` function due to package renaming.

## Enhancements
* `GenerateReport` will now print the directory of the report to console.

# DataExplorer 0.2.3
## New Features
* Added function `CollapseCategory` to collapse sparse categories for discrete features.
* Added correlation heatmap for both continuous and discrete features.
* Added density plot for continuous features.

## Bug Fixes
* Fixed a bug in `BarDiscrete` and `CorrelationDiscrete` for not plotting non-factor class.
* Minor changes for CRAN re-submission.

## Enhancements
* Changed grid layout for `BarDiscrete` and `HistogramContinuous`.
* Features with all missing values will be ignored.
* Switched position between continuous and discrete features in report template.
* Renamed package name to **DataExplorer**.
* Added **NEWS.md**.
* Removed `BoxplotContinuous`.
