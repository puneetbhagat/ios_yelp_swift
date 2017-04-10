
# Project 2 - Yelp

**Yelp Client** is a Yelp search app using the [Yelp API](http://www.yelp.com/developers/documentation/v2/search_api).

Time spent: **12** hours

## User Stories

**Search results page**
- [x] Table rows should be dynamic height according to the content height.
- [x] Custom cells should have the proper Auto Layout constraints.
- [x] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).
Hint: This is just a UISearchBar that is set as the navigationItem.titleView
- [] Optional: Infinite scroll for restaurant results
- [] Optional: Implement map view of restaurant results

**Filter page. Unfortunately, not all the filters in the real Yelp App, are supported in the Yelp API.**
- [x] The filters you should actually have are: category, sort (best match, distance, highest rated), distance, deals (on/off).
- [x] The filters table should be organized into sections as in the mock.
- [x] You can use the default UISwitch for on/off states. Optional: implement a custom switch
- [x] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.
- [] Optional: Distance filter should expand as in the real Yelp app.
- [] Optional: Categories should show a subset of the full list with a "See All" row to expand.
A formatted list of categories available in the Public API can be found [here](https://gist.github.com/timothy1ee/e23415fa468c76e84fb3).
- [] Optional: Implement the restaurant detail page.


## Video Walkthrough

Here's a walkthrough of implemented user stories:


## Notes



## License

    Copyright [yyyy] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
