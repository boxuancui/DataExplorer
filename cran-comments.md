## Notes
Regarding the previous segfault error during vignette compilation, I believe the data.table team has pushed a fix into the latest master branch on GitHub. I have updated the dependency in DESCRIPTION and it should install the latest version of data.table and resolve the issue. I have also skipped checking on R-Hub, because according to the data.table team, the R-Hub team is not responsive when asked to upgrade the clang version to 11 (currently 10.0.1). Hopefully this resolves everything. Thank you!

## Test environments
* Mac OS X 10.15.7 (local install), R 4.0.3
* Ubuntu 16.04.6 LTS (on travis-ci): r-oldrel, r-release, r-devel
* win-builder: r-oldrel, r-release, r-devel
* AppVeyor

## R CMD check results

0 errors | 0 warnings | 0 note

* This is a new release.

## Reverse dependencies
0 packages with problems
