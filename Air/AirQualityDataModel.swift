//
//  AirQualityDataModel.swift
//  Air
//
//  Created by Marcin Szabłowski on 25.01.2018.
//  Copyright © 2018 Marcin Szabłowski. All rights reserved.
//

import UIKit

class AirQualityDataModel {
    
    //Labels for displaing city and pollutants
    var city : String = ""
    var AQI : Int = 0
    var pm25 : Int = 0
    var pm10 : Int = 0
    var no2 : Double = 0
    var co : Double = 0
    var o3 : Double = 0
    var so2 : Double = 0
    var airQualityInterpretationName : String = ""
    
    //Conditions for displaing air quality interpretation
    func airQualityInterpretation(quality: Int) -> String {
        switch (quality) {
        case 0...50 :
            return "Excellent"
        case 51...100:
            return "Good"
        case 101...150 :
            return "Lightly Polluted"
        case 151...200 :
            return "Moderately Polluted"
        case 201...300 :
            return "Heavily Polluted"
        case 301...999 :
            return "Severely Polluted"
            
        default:
            return "Outside of range"
        }
    }
    
}
