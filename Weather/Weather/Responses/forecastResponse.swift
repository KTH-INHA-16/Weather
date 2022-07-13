//
//  forecastResponse.swift
//  Weather
//
//  Created by 김태훈 on 2022/07/13.
//

import Foundation

struct ForecastResponse: Codable {
    let cnt: Int
    let list: [ForecastWeather]
}

struct ForecastWeather: Codable {
    let dt: Int
    let main: WeatherMain
    let weather: [WeatherInfo]
    let clouds: WeatherCloud
    let wind: WeatherWind
    let visibility: Int
    let pop: Double
    let rain: WeatherRain
    let sys: ForecastSys
    let dtText: String
    
    enum CodingKeys: String, CodingKey {
        case dt
        case main
        case weather
        case clouds
        case wind
        case visibility
        case pop
        case rain
        case sys
        case dtText = "dt_txt"
    }
}

struct ForecastSys: Codable {
    let pod: String
}

struct WeatherRain: Codable {
    let threeHour: Double
    
    enum CodingKeys: String, CodingKey {
        case threeHour = "3h"
    }
}
