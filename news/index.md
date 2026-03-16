# Changelog

## congress 0.1.0

CRAN release: 2025-09-02

- Addresses changes in January 2024-May 2025 API changes
  ([\#22](https://github.com/christopherkenny/congress/issues/22),#23,#24,#25,#26,#27,#28,#29,#30,#31,#32,#33,#34,#35,#36,#37,#38,#39)
  - Checks that all upstream updates did not impact auto-unlisting
    functions.
  - Adds support for `item = 'summaries'` in
    [`cong_bill()`](http://christophertkenny.com/congress/reference/cong_bill.md)
  - Adds support for `item = 'text'` in
    [`cong_amendment()`](http://christophertkenny.com/congress/reference/cong_amendment.md)
  - Adds support for searching members by `congress` or `state` (and
    `district`) in
    [`cong_member()`](http://christophertkenny.com/congress/reference/cong_member.md)
  - Adds support for searching members by current status in
    [`cong_member()`](http://christophertkenny.com/congress/reference/cong_member.md)
  - Adds new
    [`cong_law()`](http://christophertkenny.com/congress/reference/cong_law.md)
    function to use the `law` endpoint.
  - Adds new
    [`cong_crs_report()`](http://christophertkenny.com/congress/reference/cong_crs_report.md)
    function to use the `crs-report` endpoint.
  - Adds new (experimental) House vote function
    [`cong_house_vote()`](http://christophertkenny.com/congress/reference/cong_house_vote.md).
- Improves support for date time formats across the board
- Fixes too aggressive processing in
  [`cong_bill()`](http://christophertkenny.com/congress/reference/cong_bill.md)
  ([\#21](https://github.com/christopherkenny/congress/issues/21))

## congress 0.0.4

- When `clean = TRUE`, the `json` version will be downloaded and used to
  clean the object
  ([\#17](https://github.com/christopherkenny/congress/issues/17)).
- `cong_reports()` did not fully rectangularize the data. This has been
  fixed
  ([\#18](https://github.com/christopherkenny/congress/issues/18)).

## congress 0.0.3

CRAN release: 2024-01-09

### New features

- When `clean = TRUE`, a new attribute is added (`response_info`) which
  provides pagination and request information.
- When `clean = TRUE`, date and datetime columns are now converted
  automatically to the correct types.
- Adds
  [`cong_request_next()`](http://christophertkenny.com/congress/reference/cong_request_next.md)
  function which requests the next set of results. This can be piped
  from the last response, such as `cong_bill() |> cong_request_next()`
  to row bind the results.

### Upstream API Updates

- Addresses changes in December 2023 API changes
  ([\#16](https://github.com/christopherkenny/congress/issues/16))
  - [`cong_amendment()`](http://christophertkenny.com/congress/reference/cong_amendment.md)
    can take `item = 'text'` for congress \<= 117 and warns otherwise.
- Addresses changes in October 2023 API changes
  ([\#15](https://github.com/christopherkenny/congress/issues/15))
  - No changes necessary within `congress` package. All changes upstream
    automatically handled.
- Addresses changes in October 2023 API changes
  ([\#14](https://github.com/christopherkenny/congress/issues/14))
  - No changes necessary within `congress` package. All changes upstream
    automatically handled.
- Addresses changes in September 2023 API changes
  ([\#13](https://github.com/christopherkenny/congress/issues/13))
  - All inputs are internally coerced to lowercase before being passed
    to the API. This excludes
    [`cong_treaty()`](http://christophertkenny.com/congress/reference/cong_treaty.md)
    which has case-sensitive suffixes.
- Addresses changes in August 2023 API changes
  ([\#12](https://github.com/christopherkenny/congress/issues/12))
  - Adds
    [`cong_bound_record()`](http://christophertkenny.com/congress/reference/cong_bound_record.md)
    to access new `bound-congressional-record` API endpoint.
- Addresses changes in July 2023 API changes
  ([\#11](https://github.com/christopherkenny/congress/issues/11))
  - Adds
    [`cong_daily_record()`](http://christophertkenny.com/congress/reference/cong_daily_record.md)
    to access new `daily-congressional-record` API endpoint.
- Addresses changes in June 2023 API changes
  ([\#10](https://github.com/christopherkenny/congress/issues/10))
  - No changes necessary within `congress` package. All changes upstream
    automatically handled.
- Addresses changes in May 2023 API changes
  ([\#9](https://github.com/christopherkenny/congress/issues/9))
  - Supports new `item` endpoint within
    [`cong_house_requirement()`](http://christophertkenny.com/congress/reference/cong_house_requirement.md)
  - Renames (internal)
    [`cong_house_communication()`](http://christophertkenny.com/congress/reference/cong_house_communication.md)
    endpoint when `number` is provided. This is due to an upstream
    change from `house-communication` to `houseCommunication`.
- Addresses changes in March 2023 API changes
  ([\#7](https://github.com/christopherkenny/congress/issues/7))
  - Adds
    [`cong_hearing()`](http://christophertkenny.com/congress/reference/cong_hearing.md)
    to access new `hearing` API endpoint.
  - Adds
    [`cong_committee_meeting()`](http://christophertkenny.com/congress/reference/cong_committee_meeting.md)
    to access new `committee-meeting` API endpoint.
  - Adds
    [`cong_committee_print()`](http://christophertkenny.com/congress/reference/cong_committee_print.md)
    to access new `committee-print` API endpoint.

### Bug fixes

- Resolves a bug in
  [`cong_senate_communication()`](http://christophertkenny.com/congress/reference/cong_senate_communication.md)
  where providing `number` would return an empty tibble.
- Resolves a bug in
  [`cong_member()`](http://christophertkenny.com/congress/reference/cong_member.md)
  where rows would be duplicated if `bioguide` was provided.
- Resolves a bug in
  [`cong_amendment()`](http://christophertkenny.com/congress/reference/cong_amendment.md)
  where rows would be duplicated if `item` was provided.
- Resolves a bug in
  [`cong_bill()`](http://christophertkenny.com/congress/reference/cong_bill.md)
  where some rows were (sometimes) duplicated if `item` was provided.

### Deprecated functions

- Removes `cong_communication()` (Deprecated in 0.0.2) in favor of
  [`cong_house_communication()`](http://christophertkenny.com/congress/reference/cong_house_communication.md).

## congress 0.0.2

- Resolves a bug in
  [`cong_bill()`](http://christophertkenny.com/congress/reference/cong_bill.md)
  where `item = 'text'` would return an empty tibble.

- Addresses changes in February 2023 API changes
  ([\#6](https://github.com/christopherkenny/congress/issues/6))

  - Allows for `house-communication` and `senate-communication` items in
    [`cong_committee()`](http://christophertkenny.com/congress/reference/cong_committee.md).
  - Passes on format to
    [`cong_senate_communication()`](http://christophertkenny.com/congress/reference/cong_senate_communication.md)
    for returned data in `committees` list-column.
  - Additional bug fixes in upstream API, which may slightly modify
    columns in
    [`cong_member()`](http://christophertkenny.com/congress/reference/cong_member.md),
    [`cong_committee()`](http://christophertkenny.com/congress/reference/cong_committee.md),
    and
    [`cong_amendment()`](http://christophertkenny.com/congress/reference/cong_amendment.md).
    These changes were automatically handled in version 0.0.1 since
    February 2023.

- Addresses changes in January 2023 API changes
  ([\#4](https://github.com/christopherkenny/congress/issues/4)) and
  ([\#5](https://github.com/christopherkenny/congress/issues/5))

  - Upstream API changes allow for full coverage of MCs for
    [`cong_member()`](http://christophertkenny.com/congress/reference/cong_member.md).
  - Upstream API changes let
    [`cong_bill()`](http://christophertkenny.com/congress/reference/cong_bill.md)
    include CBO estimates. These changes were automatically handled in
    version 0.0.1 since January 2023.

- Addresses changes in December 2022 API changes
  ([\#3](https://github.com/christopherkenny/congress/issues/3)).

  - Adds
    [`cong_house_requirement()`](http://christophertkenny.com/congress/reference/cong_house_requirement.md)
    to access new `house-requirement` API endpoint.

- Addresses changes in November 2022 API changes
  ([\#1](https://github.com/christopherkenny/congress/issues/1)) and
  ([\#2](https://github.com/christopherkenny/congress/issues/2)).

  - `cong_communication()` is deprecated in favor of
    [`cong_house_communication()`](http://christophertkenny.com/congress/reference/cong_house_communication.md),
    as a new senate endpoint was added. This can be accessed via
    [`cong_senate_communication()`](http://christophertkenny.com/congress/reference/cong_senate_communication.md).
  - Returned columns are slightly modified for
    [`cong_nomination()`](http://christophertkenny.com/congress/reference/cong_nomination.md),
    [`cong_committee_report()`](http://christophertkenny.com/congress/reference/cong_committee_report.md),
    and
    [`cong_nomination()`](http://christophertkenny.com/congress/reference/cong_nomination.md).
    These changes were automatically handled in version 0.0.1 since
    November 2022.

## congress 0.0.1

CRAN release: 2022-10-12

- Added a `NEWS.md` file to track changes to the package.
- Initial release, with functional API for beta version endpoints.
