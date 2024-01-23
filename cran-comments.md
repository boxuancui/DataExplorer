## Notes
I have addressed the 2 NOTES in the Check Results page, i.e.,

* Missing `obj` definition
* `LazyData` is specified without a `data` directory

In addition, I am getting the following warning regarding Codecov.io. I copied them directly from the official page and tested them. My original URL is working fine and the suggested badge URL is not working. I am not sure what the problem is, so please advise on how to address it.

```
! Warning: README.md:12:13 Moved
[![codecov](https://codecov.io/gh/boxuancui/DataExplorer/graph/badge.svg?token=w8eMGjF8Jw)](https://codecov.io/gh/boxuancui/DataExplorer)
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            https://app.codecov.io/gh/boxuancui/DataExplorer
```

## Test environments
GitHub Actions:

* macos-latest (release)
* windows-latest (release)
* ubuntu-latest (devel)
* ubuntu-latest (release)
* ubuntu-latest (oldrel-1)
* ubuntu-latest (4.0)
* ubuntu-latest (3.6)

## R CMD check results

The only outstanding note is what I described above.

	❯ checking CRAN incoming feasibility ... [6s/49s] NOTE  	Maintainer: ‘Boxuan Cui <boxuancui@gmail.com>’  	  	Found the following (possibly) invalid URLs:   	 URL: https://codecov.io/gh/boxuancui/DataExplorer (moved to https://app.codecov.io/gh/boxuancui/DataExplorer)   	   From: README.md   	   Status: 200   	   Message: OK		0 errors ✔ | 0 warnings ✔ | 1 note ✖

## revdepcheck resultsWe checked 1 reverse dependencies, comparing R CMD check results across CRAN and dev versions of this package. * We saw 0 new problems * We failed to check 0 packages