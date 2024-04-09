//
//  WeatherData.swift
//  Clima
//
//  Created by Eclipse on 15/02/24.
//

import Foundation
struct WeatherData: Codable{
    let name: String
    let main: Main
    let weather: [Weather]
}
struct Main: Codable{
    let temp: Double
}
struct Weather: Codable{
    let id: Int
}
