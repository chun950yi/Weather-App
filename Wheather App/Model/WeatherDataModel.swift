//
//  WeatherDataModel.swift
//  Wheather App
//
//  Created by 竣亦 on 2022/1/19.
//

import Foundation

class WeatherDataModel{
    var temperature: Int = 0
    var condition: Int = 0
    var city: String = ""
    var weatherIconName: String = ""
    
    func updateWeatherIcon (conditionId: Int) -> String{
        
        
        switch conditionId {
        
        case 0...232 :
            return "Thunderstorm"
            
        case 300...321 :
            return "Drizzle"
        
        case 500...531 :
            return "Rain"
        
        case 600...622 :
            return "Snow"
        
        case 701...781 :
            return "Atmosphere"
        
        case 800 :
            return "Clear"
        
        case 801...804 :
            return "Clouds"
        
        default:
            return "Thunderstorm"
            
        }
    }
}
