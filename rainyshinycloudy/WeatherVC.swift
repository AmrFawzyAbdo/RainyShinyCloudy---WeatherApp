//
//  WeatherVC.swift
//  rainyshinycloudy
//
//  Created by Amr fawzy on 5/14/19.
//  Copyright © 2019 Amr fawzy. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController , UITableViewDelegate ,UITableViewDataSource , CLLocationManagerDelegate{
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLable: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation : CLLocation!
    
    var currentWeather : CurrentWeather!
    var forecast : Forecast!
    var forecasts = [Forecast]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
        
        
        //        print (CURRENT_WEATHER_URL)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        locationAuthStatus()
    }
    
    
    
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            
            currentLocation = locationManager.location
              Location.sherdInstance.latitude = currentLocation.coordinate.latitude
            Location.sherdInstance.longitude = currentLocation.coordinate.longitude
            
            currentWeather.downloadWeatherDetails{
                self.downloadForecastData{
                    self.updateMainUI()
                    
                }
                
                
                //        currentWeather.downloadWeatherDetails{
                //
                //                self.updateMainUI()
                
                
            }
            
            
            print(currentLocation.coordinate.latitude , currentLocation.coordinate.longitude)
            
        }else{
            locationManager.requestWhenInUseAuthorization()
//             locationAuthStatus()
        }
    }
    
    
    
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(true)
    //        let backgroundImage = UIImage(named: "tumblr_pdn4kwfdAx1v6epdl_540.png")
    //        let imageView = UIImageView(image: backgroundImage)
    //        self.tableView.backgroundView = imageView
    //
    //    }
    
    
    func downloadForecastData(completed : @escaping DownloadComplete){
        // downloading forecast weather data for tableview
        
        let forecastURL = URL(string: FORECAST_URL)!
        Alamofire.request(forecastURL).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary <String , AnyObject> {
                if let list = dict["list"] as? [Dictionary<String,AnyObject>]{
                    for obj in list {
                        let forecast = Forecast(weatherDict : obj)
                        self.forecasts.append(forecast)
                        print(obj)
                    }
                    self.tableView.reloadData()
                }
            }
            completed()
            
        }
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
            
        }else{
            return WeatherCell()
        }
    }
    
    func updateMainUI(){
        dateLabel.text = currentWeather.date
        currentTempLable.text = "\(currentWeather.currentTemp)°"
        currentWeatherTypeLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }
    
    
    
}

