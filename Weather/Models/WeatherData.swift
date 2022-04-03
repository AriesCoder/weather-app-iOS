//
//  Weather.swift
//  Weather
//
//  Created by Aries Lam on 4/1/22.
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

