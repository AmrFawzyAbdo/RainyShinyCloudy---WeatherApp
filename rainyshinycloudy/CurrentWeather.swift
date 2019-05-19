//
//  CurrentWeather.swift
//  rainyshinycloudy
//
//  Created by Amr fawzy on 5/14/19.
//  Copyright © 2019 Amr fawzy. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    var _cityName: String!
    var _date : String!
    var _weatherType : String!
    var _currentTemp : Int!
    
    var cityName : String {
        if _cityName == nil{
            _cityName = ""
        }
        return _cityName
    }
    
    var date : String {
        if _date == nil {
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .long
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today , \(currentDate)"
        return _date
    }
    
    var weatherType : String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    var currentTemp : Int {
        if _currentTemp == nil {
            _currentTemp = 0
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed : @escaping DownloadComplete) {
        
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
        Alamofire.request(currentWeatherURL).responseJSON {response in
            let result = response.result
            if let dict = result.value as? Dictionary<String , AnyObject> {
                if let name = dict["name"] as? String{
                    self._cityName = name.capitalized
                    print(self._cityName)
                }
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                        print(self._weatherType)

                    }
                }
                if let main = dict ["main"] as? Dictionary<String , AnyObject> {
                    if let currentTemp = main ["temp"] as? Double {
                        let temp = Int(currentTemp - 273.15)
                        self._currentTemp = temp
                        print(self._currentTemp)

                    }
                }
            }
            completed()
            
        }
    }
    
}
