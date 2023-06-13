# congress 0.0.2

* Addresses changes in February 2023 API changes (#6)
  * Allows for `house-communication` and `senate-communication` items in `cong_committee()`.
  * Passes on format to `cong_senate_communication()` for returned data in `committees` list-column.
  * Additional bug fixes in upstream API, which may slightly modify columns in `cong_member()`, 
  `cong_committee()`, and `cong_amendment()`. These changes 
  were automatically handled in version 0.0.1 since February 2023.

* Addresses changes in January 2023 API changes (#4) and (#5)
  * Upstream API changes allow for full coverage of MCs for `cong_member()`.
  * Upstream API changes let `cong_bill()` include CBO estimates.  These changes 
  were automatically handled in version 0.0.1 since January 2023.

* Addresses changes in December 2022 API changes (#3).
  * Adds `cong_house_requirement()` to access new `house-requirement` API endpoint.

* Addresses changes in November 2022 API changes (#1) and (#2).
  * `cong_communication()` is deprecated in favor of `cong_house_communication()`, 
  as a new senate endpoint was added. This can be accessed via `cong_senate_communication()`.
  * Returned columns are slightly modified for `cong_nomination()`, `cong_committee_report()`, 
  and `cong_nomination()`. These changes were automatically handled in version 0.0.1 
  since November 2022.

# congress 0.0.1

* Added a `NEWS.md` file to track changes to the package.
* Initial release, with functional API for beta version endpoints.
