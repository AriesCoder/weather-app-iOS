//
//  WeatherModel.swift
//  Weather
//
//  Created by Aries Lam on 4/1/22.
//

import Foundation
struct WeatherModel{
    let conditionId: Int
    let cityName: String
    let temperture: Double
    
    var tempertureString: String{
        return String(format: "%.1f", temperture)
    }
    
    var conditionName: String {
        switch conditionId{
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "cloud.fill"
    }
        
    }
}
