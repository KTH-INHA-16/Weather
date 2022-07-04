//
//  WeatherMainViewModels.swift
//  Weather
//
//  Created by 김태훈 on 2022/07/04.
//

import Foundation
import Combine
import CoreLocation

final class WeatherMainViewModel: ObservableObject {
    @Published var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    private let locationManager = CLLocationManager()
    
    init() {
        locationAuthization()
        
        coordinate = getCoordinate()
    }
}

private extension WeatherMainViewModel {
    func locationAuthization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getCoordinate() -> CLLocationCoordinate2D {
        guard let coordinate = CLLocationManager().location?.coordinate else {
            return CLLocationCoordinate2D(latitude: 37.532600, longitude: 127.024612)
        }
        
        return coordinate
    }
}
