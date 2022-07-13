//
//  CurrentResponse.swift
//  Weather
//
//  Created by 김태훈 on 2022/07/12.
//

import Foundation

struct CurrentResponse: Codable {
    let weather: [WeatherInfo]
    let main: WeatherMain
    let base: String
    let visibility: Int
    let wind: WeatherWind
    let clouds: WeatherCloud
    let sys: CurrentSys
    let timezone: Int
    let name: String
    let id: Int
    let code: Int
}

struct CurrentSys: Codable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}

struct WeatherInfo: Codable {
    let id: String
    let main: String
    let description: String
    let icon: String
}

struct WeatherWind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double?
}

struct WeatherCloud: Codable {
    let all: Int
}

struct WeatherMain: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
    let seaLevel: Int?
    let grndLevel: Int?
    let tempKf: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case tempKf = "temp_kf"
    }
}
