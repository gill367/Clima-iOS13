//
//  WeatherModel.swift
//  Clima
//
//  Created by Gill on 2023-12-26.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel{
    let city: String
    let temp: Double
    let description: String
    let conditionId: Int
    
    var tempString : String {
        return String(format: "%.1f", temp)
    }
    
    var conditionName: String {
        var result = ""
        switch conditionId {
        case 200...299:
            result = "cloud.bolt.rain"
        case 300...399:
            result = "cloud.drizzle"
        case 500...599:
            result = "cloud.rain"
        case 600...699:
            result = "cloud.snow"
        case 700...799:
            result = "sun.min"
        case 800:
            result = "sun.max"
        case 801...899:
            result = "cloud"
        default:
            result = "questionmark"
        }
        return result
    }
}
