//
//  ViewController.swift
//  Stormy
//
//  Created by Apurv Gupta on 06/12/15.
//  Copyright (c) 2015 Apurv Gupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var currentTemperatureLabel: UILabel?
    
    @IBOutlet var currentHumidityLabel: UILabel?
    
    @IBOutlet var currentPrecipitationLabel: UILabel?
    
    @IBOutlet var currentWeatherIcon: UIImageView?
    
    @IBOutlet var currentWeatherSummary: UILabel?
    
    
    private let forecastAPIKey = "8ffac3b18b802278b15c4423020a1ca6"
    let coordinate : (lat : Double, long: Double) = (37.8267, -122.423)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let forecastService = ForecastService(APIKey: forecastAPIKey)
        forecastService.getForecast(coordinate.lat, long: coordinate.long){
            (let currently) in
            if let currentWeather = currently {
                //Update UI
                dispatch_async(dispatch_get_main_queue()){
                    if let temperature = currentWeather.temperature{
                        self.currentTemperatureLabel?.text = "\(temperature)º"
                    }
                    
                    if let humidity = currentWeather.humidity{
                        self.currentHumidityLabel?.text = "\(humidity)%"
                    
                    }
                    
                    if let precipitation = currentWeather.precipProbabilty{
                        self.currentPrecipitationLabel?.text = "\(precipitation)%"
                    }
                    if let icon = currentWeather.icon {
                        self.currentWeatherIcon?.image = icon
                    
                    }
                    if let summary = currentWeather.summary {
                        self.currentWeatherSummary?.text = summary
                    }
                
                
                
                }
                
                
                
                
                
            }
        }
        
    
        
   
    
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

