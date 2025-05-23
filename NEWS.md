# congress 0.1.0

* Addresses changes in January 2024-May 2025 API changes (#22,#23,#24,#25,#26,#27,#28,#29,#30,#31,#32,#33,#34,#35,#36,#37,#38,#39)
  * Checks that all upstream updates did not impact auto-unlisting functions.
  * Adds support for `item = 'summaries'` in `cong_bill()`
  * Adds support for `item = 'text'` in `cong_amendment()`
  * Adds support for searching members by `congress` or `state` (and `district`) in `cong_member()`
  * Adds support for searching members by current status in `cong_member()`
  * Adds new `cong_law()` function to use the `law` endpoint.
  * Adds new `cong_crs_report()` function to use the `crs-report` endpoint.
* Improves support for date time formats across the board

# congress 0.0.4

* When `clean = TRUE`, the `json` version will be downloaded and used to clean the object (#17).
* `cong_reports()` did not fully rectangularize the data. This has been fixed (#18).

# congress 0.0.3

## New features

* When `clean = TRUE`, a new attribute is added (`response_info`) which provides pagination and request information.
* When `clean = TRUE`, date and datetime columns are now converted automatically to the correct types.
* Adds `cong_request_next()` function which requests the next set of results. This can be piped from the last response, such as `cong_bill() |> cong_request_next()` to row bind the results.

## Upstream API Updates

* Addresses changes in December 2023 API changes (#16)
  * `cong_amendment()` can take `item = 'text'` for congress <= 117 and warns otherwise.

* Addresses changes in October 2023 API changes (#15)
  * No changes necessary within `congress` package. All changes upstream automatically handled.

* Addresses changes in October 2023 API changes (#14)
  * No changes necessary within `congress` package. All changes upstream automatically handled.

* Addresses changes in September 2023 API changes (#13)
  * All inputs are internally coerced to lowercase before being passed to the API. This excludes `cong_treaty()` which has case-sensitive suffixes.

* Addresses changes in August 2023 API changes (#12)
  * Adds `cong_bound_record()` to access new `bound-congressional-record` API endpoint.

* Addresses changes in July 2023 API changes (#11)
  * Adds `cong_daily_record()` to access new `daily-congressional-record` API endpoint.

* Addresses changes in June 2023 API changes (#10)
  * No changes necessary within `congress` package. All changes upstream automatically handled.

* Addresses changes in May 2023 API changes (#9)
  * Supports new `item` endpoint within `cong_house_requirement()`
  * Renames (internal) `cong_house_communication()` endpoint when `number` is provided. This is due to an upstream change from `house-communication` to `houseCommunication`.
  
* Addresses changes in March 2023 API changes (#7)
  * Adds `cong_hearing()` to access new `hearing` API endpoint.
  * Adds `cong_committee_meeting()` to access new `committee-meeting` API endpoint.
  * Adds `cong_committee_print()` to access new `committee-print` API endpoint.
  
## Bug fixes
* Resolves a bug in `cong_senate_communication()` where providing `number` would return an empty tibble.
* Resolves a bug in `cong_member()` where rows would be duplicated if `bioguide` was provided.
* Resolves a bug in `cong_amendment()` where rows would be duplicated if `item` was provided.
* Resolves a bug in `cong_bill()` where some rows were (sometimes) duplicated if `item` was provided.

## Deprecated functions
* Removes `cong_communication()` (Deprecated in 0.0.2) in favor of `cong_house_communication()`.

# congress 0.0.2

* Resolves a bug in `cong_bill()` where `item = 'text'` would return an empty tibble.

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
