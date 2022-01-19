//
//  ViewController.swift
//  Wheather App
//
//  Created by 竣亦 on 2022/1/17.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import CoreLocation

class ViewController: UIViewController, delegateProtocol, CLLocationManagerDelegate {
    func newCityName(city: String) {
        
        SVProgressHUD.show()
        
        let keys :[String:String] = ["q": city, "appid": apiKey]
        getWeatherData(url: openWeatherMapLinkage, keys: keys)
        
    }
    

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBAction func gotoSecondView(_ sender: UIButton) {
        
    }
    
    let openWeatherMapLinkage = "http://api.openweathermap.org/data/2.5/weather"
    let apiKey = "d58755c397fd54cbe9d1b5b215b52105"

    let weatherDataModel = WeatherDataModel()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        locationManager.delegate = self
        //精確度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //請求權限
        if locationManager.authorizationStatus == CLAuthorizationStatus.notDetermined {
            
            locationManager.requestWhenInUseAuthorization()
            
        }
        
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location : CLLocation = locations[0]
        
        let latitude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        
        let inputs : [String : String] = ["lat": latitude, "lon": longitude, "appid": apiKey]
        
        getWeatherData(url: openWeatherMapLinkage, keys: inputs)
        
        SVProgressHUD.show()
        
    }

    func getWeatherData(url: String, keys: [String : String]){
        
        AF.request(url, method: HTTPMethod.get, parameters: keys, encoder: URLEncodedFormParameterEncoder.default, headers: nil, interceptor: nil, requestModifier: nil).responseData { response in
            
            switch response.result{
                
            case .success:
                
                let weatherJsonData : JSON = JSON(response.value!)
                
                self.updateWeatherData(json: weatherJsonData)
                
            case .failure:
                
                print("failure")
                
            }
            
        }
        
    }

    func updateWeatherData(json: JSON){
        
        if let temperature = json["main"]["temp"].double {
            
            weatherDataModel.temperature = Int(temperature - 273.15)
            weatherDataModel.city = json["name"].stringValue
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(conditionId: weatherDataModel.condition)
            
            updateUI()
            
        } else {
            
            cityNameLabel.text = "Weather Data Unavailable"
            
        }
        
        
    }
    
    func updateUI(){
        
        temperatureLabel.text = String(weatherDataModel.temperature) + "˚"
        weatherImage.image = UIImage(named: weatherDataModel.weatherIconName)
        cityNameLabel.text = weatherDataModel.city
        
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
        
        
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "gotoSecondView" {
            
            let destination = segue.destination as! SecondViewController
            destination.delegate = self
            
        }
    }
    
}

