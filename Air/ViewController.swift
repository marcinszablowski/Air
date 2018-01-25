//
//  ViewController.swift
//  Air
//
//  Created by Marcin Szabłowski on 19.01.2018.
//  Copyright © 2018 Marcin Szabłowski. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
    let baseURL = "http://api.waqi.info/feed/shanghai/?token="
    let token = "3d65980782c9bd362aa28468e7a4f36d944bff5a"
    var finalURL = ""
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var airQualityLabel: UILabel!
    @IBOutlet weak var mainDescription: UILabel!
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
        
        updatePollutionData()
    }
    
    //Networking call
    func getAirQualityData(url : String, parameters : [String : String]) {
        finalURL = baseURL + token
        print(finalURL)
        
        
    }

    func updatePollutionData() {
        carbonMonoxide.text = "222"
        mainDescription.textColor = UIColor.green
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            
            let longitude = String(location.coordinate.longitude)
            let latitude = String(location.coordinate.latitude)
            
            print("Longitude is: \(longitude). Latitude is \(latitude).")
            print(location.horizontalAccuracy)
            
            let params : [String : String] = ["lat" : latitude, "lng" : longitude, "token" : token]
            
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Oops! No connection!"
    }
    
}

