//
//  APIService.swift
//  WeatheriOSAssignment
//
//  Created by Madhuri Patil on 03/07/21.
//

import Foundation

class APIService: NSObject {
    
    func getWeatherData(cityName: String, completion: @escaping (WeatherData?, String?) -> ()) {
        if let sourceUrl = URL(string: "\(baseURL)?q=\(cityName)&appid=\(apiKey)") {
            URLSession.shared.dataTask(with: sourceUrl) { (data, urlResponse, error) in
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    let weatherData = try? jsonDecoder.decode(WeatherData.self, from: data)
                    if let weatherData = weatherData {
                        completion(weatherData, nil)
                    } else {
                        completion(nil, "city not found, please enter valid city name")
                    }
                } else if let error = urlResponse {
                    completion(nil, "city not found, please enter valid city name")
                }
            }.resume()
        }
    }
    
}
