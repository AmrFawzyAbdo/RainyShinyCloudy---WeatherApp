//
//  Constants.swift
//  rainyshinycloudy
//
//  Created by Amr fawzy on 5/14/19.
//  Copyright © 2019 Amr fawzy. All rights reserved.
//

import Foundation
//let BASE_URL = "https://api.openweathermap.org/data/2.5/weather?"
//let LATITUIDE = "lat="
//let LONGITUDE = "&lon="
//let APP_ID = "&appid="
//let API_KEY = "b91976e6be46f1f16ae814309b4b1bcd"

typealias DownloadComplete = () -> ()

//


//let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUIDE)30.125210\(LONGITUDE)31.134859\(APP_ID)\(API_KEY)"

let CURRENT_WEATHER_URL = "https://api.openweathermap.org/data/2.5/weather?lat=\(Location.sherdInstance.latitude!)&lon=\(Location.sherdInstance.latitude!)&appid=b91976e6be46f1f16ae814309b4b1bcd"

let FORECAST_URL = "https://samples.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sherdInstance.latitude!)&lon=\(Location.sherdInstance.latitude!)&cnt=10&appid=b1b15e88fa797225412429c1c50c122a1"


