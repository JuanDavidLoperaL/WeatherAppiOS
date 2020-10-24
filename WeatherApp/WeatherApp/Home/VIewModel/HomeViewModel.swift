//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Juan david Lopera lopez on 24/10/20.
//

import MapKit
import CoreLocation
import Foundation

typealias LocationInfo = (cityName: String, coordinates: CLLocationCoordinate2D)

final class HomeViewModel {
    
    // MARK: - Private Properties
    private let api: HomeAPIProtocol
    private var coordinatesInMap: [LocationInfo] = [LocationInfo]()
    
    // MARK: - Delegates
    weak var delegate: HomeViewControllerDelegate?
    
    init(api: HomeAPIProtocol = HomeAPI()) {
        self.api = api
    }
}

// MARK: - Internal Functions
extension HomeViewModel {
    func getSetionsAmountInCollection() -> Int {
        return 1
    }
    
    func getItemsAmountInCollection() -> Int {
        return coordinatesInMap.count
    }
    
    func getAnnotation(with coordinates: CLLocationCoordinate2D) {
        storeLocation(with: coordinates) { [weak self] wasSuccess in
            if wasSuccess {
                let annotationInMap: MKPointAnnotation = MKPointAnnotation()
                annotationInMap.coordinate = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
                self?.delegate?.add(annotationInMap: annotationInMap)
            } else {
                //TODO: Put a Error view and say try again
            }
        }

    }
    
    func getWeatherFor(city: Int) {
        
    }
}

// MARK: - Private Functions
extension HomeViewModel {
    private func storeLocation(with coordinates: CLLocationCoordinate2D, completionHandler: @escaping(_ cityStored: Bool) -> Void) {
        getCityName(by: coordinates) { [weak self] result in
            switch result {
            case .success(let cityName):
                let locationInfo: LocationInfo = (cityName: cityName, coordinates: coordinates)
                self?.coordinatesInMap.append(locationInfo)
                completionHandler(true)
            case .failure(_):
                completionHandler(false)
            }
        }
    }
    
    private func getCityName(by coordinates: CLLocationCoordinate2D, completionHandler: @escaping(Result<String, ErrorInRequest>) -> Void) {
        let location: CLLocation = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        let geoCoder: CLGeocoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { [weak self] placeMarks, error in
            if error == nil {
                guard let cityName: String = placeMarks?[0].locality else {
                    completionHandler(.failure(.errorGettingCity))
                    return
                }
                completionHandler(.success(cityName))
            }
            else {
                completionHandler(.failure(.errorGettingCity))
            }
        }
    }
}
