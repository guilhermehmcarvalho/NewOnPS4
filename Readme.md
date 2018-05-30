# New on PS4

[![Swift][swift-badge]][swift-url] 
[![Platform][platform-badge]][platform-url]
[![Build Status][build-badge]][build-url]
[![codecov][codecov-badge]][codecov-url]

New on PS4 is an iOS app to check the newest games released on PS4.
The app uses IGDB.com's API to provide the data.


# Requirements

  - Xcode 9 or later
  - Ruby
  
# Information
- Requires iOS 9.0 or later
- Compatible with iPhone, iPod Touch and iPad


# Tech

New on PS4 uses a number of open source projects to work properly:
* IGDB - https://github.com/igdb
* Alamofire - https://github.com/Alamofire/Alamofire
* VegaScroll - https://github.com/ApplikeySolutions/VegaScroll
* NVActivityIndicatorView - https://github.com/ninjaprox/NVActivityIndicatorView
* SwiftLint - https://github.com/realm/SwiftLint
* Fastlane - https://github.com/fastlane/fastlane
* Travis CI - https://github.com/travis-ci/travis-ci


### Installation

### Required Steps

Run the following commands on the root folder of project:

```
# install system dependencies
gem install bundler
bundle install

# install project dependencies
pod install

# open project
open BitPrice.xcworkspace

# add API Key
create a file under /Classes/Service/Api/ names Constants.swift with the following code
struct Constants {
	internal static let APIKey = "YOUR KEY HERE"
}
You can get a key at 
```

### Optional Steps

- Install [SwiftLint](https://github.com/realm/SwiftLint#using-homebrew) using [Homebrew](https://brew.sh/)


### Todos

 - Write MORE Tests

License
----

MIT


[dill]: <https://github.com/guilhermehmcarvalho/PS4WeekReleases.git>
[git-repo-url]: <https://github.com/joemccann/dillinger.git>
[swift-badge]: https://img.shields.io/badge/swift-4.0-orange.svg?style=flat
[swift-url]: https://swift.org
[platform-badge]: https://img.shields.io/badge/platform-iOS%209+-lightgrey.svg
[platform-url]: https://developer.apple.com/swift
[codecov-badge]: https://codecov.io/gh/guilhermehmcarvalho/NewOnPS4/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/guilhermehmcarvalho/NewOnPS4
[build-badge]: https://travis-ci.org/guilhermehmcarvalho/PS4WeekReleases.svg?branch=master
[build-url]: https://travis-ci.org/guilhermehmcarvalho/PS4WeekReleases
