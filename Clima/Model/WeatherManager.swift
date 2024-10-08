//
//  WeatherManager.swift
//  Clima
//
//  Created by Eclipse on 15/02/24.
//
import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager:WeatherManager, _ weather:WeatherModel)
    func didFailWithError(error:Error)
}

extension String {
    func capitalizingFirstLetterOfEachWord() -> String {
        return self.lowercased().split(separator: " ").map { $0.capitalized }.joined(separator: " ")
    }
}


struct WeatherManager{
    var delegate: WeatherViewController?
    var weatherurl = "https://api.openweathermap.org/data/2.5/weather?appid=c57b987d6c866702cc2f19f0c32751d1&units=metric"
    var temprature: Double?
    func fetchWeather(_ cityName: String){
        let urlString = "\(weatherurl)&q=\(cityName)"
        performRequest(urlString)
    }
    func fetchWeather(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees){
        let urlString = "\(weatherurl)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString)
    }
    func performRequest(_ url: String){
        if let url = URL(string: url){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    self.delegate?.didFailWithError(error:error!)
                    return
                }
                if let safeData = data{
                    if let weather = parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self,weather)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temprature = decodedData.main.temp
            let description = decodedData.weather[0].description.capitalizingFirstLetterOfEachWord()
            let weather = WeatherModel(cityName: name, temprature: temprature, id: id, description: description)
            return weather
        } catch{
            delegate?.didFailWithError(error:error)
            return nil
        }
    }
}
