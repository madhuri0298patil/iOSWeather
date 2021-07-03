//
//  Weather.swift
//  WeatheriOSAssignment
//
//  Created by Madhuri Patil on 03/07/21.
//

import Foundation
struct WeatherData: Decodable {
    let cityName: String
    let tempData: TempData
    
    enum CodingKeys: String, CodingKey {
        case cityName = "name"
        case tempData = "main"
    }
    
}

struct TempData: Decodable {
    let temp: Double
}


