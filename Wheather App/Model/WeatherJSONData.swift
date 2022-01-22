//
//  WeatherJSONData.swift
//  Wheather App
//
//  Created by 竣亦 on 2022/1/20.
//

import Foundation
import UIKit
import SwiftyJSON

struct WeatherJSONData {
    let temp: Double
    let name: String
    let weatherId: Int
    
    init(json:JSON){
        self.temp = json["main"]["temp"].doubleValue
        self.name = json["name"].stringValue
        self.weatherId = json["weather"][0]["id"].intValue
    }
    
}
