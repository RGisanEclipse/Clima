//
//  WeatherModel.swift
//  Clima
//
//  Created by Eclipse on 15/02/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
struct WeatherModel{
    let cityName: String
    let temprature: Double
    let id: Int
    let description: String
    var tempratureString: String{
        return String(format: "%.1f", temprature)
    }
    var conditionName: String {
        switch id{
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...532:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }

}
