//
//  WeatherCell.swift
//  rainyshinycloudy
//
//  Created by Amr fawzy on 5/15/19.
//  Copyright © 2019 Amr fawzy. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var hightTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    
    func configureCell(forecast : Forecast){
        lowTemp.text = "\(forecast.lowTemp)"
        hightTemp.text = "\(forecast.highTemp)"
        weatherType.text = forecast.weatherType
        dayLabel.text = forecast.date
        weatherIcon.image = UIImage(named: forecast.weatherType)
    }
    
}
