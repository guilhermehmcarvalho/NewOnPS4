# New on PS4

[![Swift][swift-badge]][swift-url] 
[![Platform][platform-badge]][platform-url]
[![Build Status][build-badge]][build-url]
[![codecov][codecov-badge]][codecov-url]
[![Codebeat][codebeat-badge]][codebeat-url]

![2014-10-22 11_35_09](https://thumbs.gfycat.com/SomeDetailedErmine-size_restricted.gif)

New on PS4 shows on your iOS device the newest games released on Playstation 4.
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
* Travis CI - https://travis-ci.org/guilhermehmcarvalho/NewOnPS4
* Codecov - https://codecov.io/gh/guilhermehmcarvalho/NewOnPS4
* Codebeat - https://codebeat.co/projects/github-com-guilhermehmcarvalho-newonps4-master


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
replace the key at /Classes/Service/Api/ with a key of your own
If you don't have one, you can get it at https://api.igdb.com/
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
[build-badge]: https://travis-ci.org/guilhermehmcarvalho/NewOnPS4.svg?branch=master
[build-url]: https://travis-ci.org/guilhermehmcarvalho/NewOnPS4
[codebeat-badge]: https://codebeat.co/badges/47b185ce-c2a6-4101-9abe-ed0e3bdc2293
[codebeat-url]: https://codebeat.co/projects/github-com-guilhermehmcarvalho-newonps4-master
