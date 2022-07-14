//
//  CurrentAPI.swift
//  Weather
//
//  Created by 김태훈 on 2022/07/04.
//

import Foundation
import Combine
import Moya
import CombineMoya

enum WeatherAPI {
    private static let provider = MoyaProvider<Self>()
    
    case current(lat: Double, lon: Double)
    case forecast(lat: Double, lon: Double)
}

extension WeatherAPI {
    static func current(lat: Double, lon: Double) -> AnyPublisher<CurrentResponse?, Never> {
        return provider.request(target: .current(lat: lat, lon: lon))
    }
    
    static func forecast(lat: Double, lon: Double) -> AnyPublisher<ForecastResponse?, Never> {
        return provider.request(target: .forecast(lat: lat, lon: lon))
    }
}

extension WeatherAPI: TargetType {
    var baseURL: URL { URL(string: "https://api.openweathermap.org/data/2.5")! }
    
    var path: String {
        switch self {
        case .current:
            return "weather"
        case .forecast:
            return "forecast"
        }
    }
    
    var method: Moya.Method { .get }
    
    var task: Task {
        var parameters: [String: Any] = ["appid":APIKey.key, "lang":"kr", "units": "metric"]
        switch self {
        case .current(let lat, let lon), .forecast(let lat, let lon):
            parameters["lat"] = lat
            parameters["lon"] = lon
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? { ["Content-Type": "application/json", "accept": "application/json"] }
}
