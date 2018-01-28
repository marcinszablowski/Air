//
//  ViewController.swift
//  Air
//
//  Created by Marcin Szabłowski on 19.01.2018.
//  Copyright © 2018 Marcin Szabłowski. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    let airQualityDataModel = AirQualityDataModel()
    
    let baseURL = "https://api.waqi.info/feed/geo:"
    let tokenURL = "/?token="
    let token = "3d65980782c9bd362aa28468e7a4f36d944bff5a"
    var finalURL = ""
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var airQualityLabel: UILabel!
    @IBOutlet weak var airQualityIndex: UILabel!
    @IBOutlet weak var PM25: UILabel!
    @IBOutlet weak var nitrogenDioxide: UILabel!
    @IBOutlet weak var ozone: UILabel!
    @IBOutlet weak var PM10: UILabel!
    @IBOutlet weak var carbonMonoxide: UILabel!
    @IBOutlet weak var sulfurDioxide: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
        // Networking call.
    func getAirQualityData(url : String) {
        Alamofire.request(url, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                //Connect is succesful
                print("Success! Got air quality data!")
                
                //Get JSON formated data from server
                let airQualityJSON : JSON = JSON(response.result.value!)
                print(airQualityJSON)
                
                //Run method that will be a translation for the app
                self.updateAirQualityData(json: airQualityJSON)
                
            }
            else {
                print("Error: \(response.result.error!)")
                self.cityLabel.text = "Ouch! Can't connect!"
            }
        }
    }

    func updateAirQualityData(json: JSON) {
        if let AQIResult = json["data"]["aqi"].int {
            
        airQualityDataModel.city = json["data"]["city"]["name"].stringValue
            
        airQualityDataModel.AQI = Int(AQIResult)
        airQualityDataModel.pm25 = json["data"]["iaqi"]["pm25"]["v"].intValue
        airQualityDataModel.pm10 = json["data"]["iaqi"]["pm10"]["v"].intValue
        airQualityDataModel.no2 = json["data"]["iaqi"]["no2"]["v"].doubleValue
        airQualityDataModel.co = json["data"]["iaqi"]["co"]["v"].doubleValue
        airQualityDataModel.o3 = json["data"]["iaqi"]["o3"]["v"].doubleValue
        airQualityDataModel.so2 = json["data"]["iaqi"]["so2"]["v"].doubleValue
        
        airQualityDataModel.airQualityInterpretationName = airQualityDataModel.airQualityInterpretation(quality: AQIResult)
            
            updateUIWithAirQualityData()
            
        }
        else {
            cityLabel.text = "No Air Quality Data"
        }
    }
    
    
    func updateUIWithAirQualityData() {
        
        cityLabel.text = airQualityDataModel.city
        
        airQualityIndex.text = String(airQualityDataModel.AQI)
        PM25.text = String(airQualityDataModel.pm25)
        PM10.text = String(airQualityDataModel.pm10)
        nitrogenDioxide.text = String(format: "%.1f", airQualityDataModel.no2)
        carbonMonoxide.text = String(format: "%.1f", airQualityDataModel.co)
        ozone.text = String(format: "%.1f", airQualityDataModel.o3)
        sulfurDioxide.text = String(format: "%.1f", airQualityDataModel.so2)
        
        airQualityLabel.text = airQualityDataModel.airQualityInterpretationName
        
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

        // Get location data and create URL for obtaining JSON data.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            
            let longitude = String(location.coordinate.longitude)
            let latitude = String(location.coordinate.latitude)
            
            print("Longitude is: \(longitude). Latitude is \(latitude).")
            //print(location.horizontalAccuracy)
            
            finalURL = baseURL + latitude + ";" + longitude + tokenURL + token
            //print(finalURL)
            
            getAirQualityData(url: finalURL)
        }
    }
    
        // Inform about connection with location issues.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Oops! No connection!"
    }
    
}

