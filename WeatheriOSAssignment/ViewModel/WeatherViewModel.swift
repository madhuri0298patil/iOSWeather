//
//  WeatherViewModel.swift
//  WeatheriOSAssignment
//
//  Created by Madhuri Patil on 03/07/21.
//

import Foundation

class WeatherViewModel: NSObject {
    private var apiService: APIService!
    
    override init() {
        super.init()
        apiService = APIService()
    }
    
    func callGetWeatherData(cityName:String, completion: @escaping(WeatherData?, String?) -> ()) {
        
        apiService.getWeatherData(cityName:cityName, completion: { (data, error) in
            if let data = data {
                completion(data, nil)
            } else if let error = error {
                completion(nil, error)
            }
        })
    }
}
