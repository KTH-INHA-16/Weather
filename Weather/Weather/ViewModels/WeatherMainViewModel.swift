//
//  WeatherMainViewModels.swift
//  Weather
//
//  Created by 김태훈 on 2022/07/04.
//

import Foundation
import Combine
import CoreLocation
import UIKit

final class WeatherMainViewModel: NSObject, ObservableObject {
    @Published var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    private var bag: Set<AnyCancellable> = []
    private let locationManager = CLLocationManager()
    private let locationSubject = PassthroughSubject<CLLocationCoordinate2D, Never>()
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationAuthization()
        bind()
    }
}

private extension WeatherMainViewModel {
    func locationAuthization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    @discardableResult
    func getCoordinate() -> CLLocationCoordinate2D {
        guard let coordinate = CLLocationManager().location?.coordinate else {
            let coordinate = CLLocationCoordinate2D(latitude: 37.532600, longitude: 127.024612)
            self.coordinate = coordinate
            locationSubject.send(coordinate)
            
            return coordinate
        }
        
        self.coordinate = coordinate
        locationSubject.send(coordinate)
        return coordinate
    }
    
    func bind() {
        locationSubject
            .sink { [weak self] coordinate in
                guard let self = self else { return }
                
                WeatherAPI.current(lat: coordinate.latitude, lon: coordinate.longitude)
                    .subscribe(on: RunLoop.main)
                    .sink { 
                        print($0)
                    }
                    .store(in: &self.bag)
                
                WeatherAPI.forecast(lat: coordinate.latitude, lon: coordinate.longitude)
                    .subscribe(on: RunLoop.main)
                    .sink {
                        print($0)
                    }
                    .store(in: &self.bag)
            }
            .store(in: &bag)
    }
}

extension WeatherMainViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            getCoordinate()
        case .denied, .restricted:
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        default:
            locationAuthization()
        }
    }
}
