![](Screenshots/NaviBikeTitle.png)

The app is designed to help you navigate the [Veturilo](https://www.veturilo.waw.pl) public bike around the city of Warsaw.
It allows to find a starting and ending point on the map and with help of Backend application specifies the nearest bike station.
Navi Bike offers the user three types of route:

+ Fastest - the fastest route between stations
+ Optimal - optimal route between a fastest and free option
+ Free - route which requires changing the bike every 20 minutes to avoids costs

Application navigates the cyclist on the route with visual and voice information about the steps he should take.

## Build and Runtime Requirements
+ Xcode 9.0 or later
+ iOS 9.0 or later
+ macOS v10.10 or later

## Installation

### Setup Cocoapods repository

1. Run `pod install` to correctly setup the Cocoapods dependencies
2. Make sure that you open the project referring to  `*.xcworkspace` in Xcode or AppCode


## Built With

* [SwifterSwift](https://github.com/SwifterSwift/SwifterSwift)
* [GoogleMaps](https://developers.google.com/maps/documentation/ios-sdk/)
* [Moya-ObjectMapper](https://github.com/ivanbruel/Moya-ObjectMapper)
* [Moya](https://github.com/Moya/Moya)
* [SwiftSpinner](https://github.com/icanzilb/SwiftSpinner)
