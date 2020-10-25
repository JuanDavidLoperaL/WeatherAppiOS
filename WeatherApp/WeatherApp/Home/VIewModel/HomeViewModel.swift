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
    
    // MARK: - Enum
    enum EditButtonStates: String {
        case editing = "Ok"
        case notEditing = "Edit"
        
        mutating func switchState() {
            switch self {
            case .editing:
                self = .notEditing
            case .notEditing:
                self = .editing
            }
        }
    }
    
    // MARK: - Private Properties
    private var editButtonState: EditButtonStates = .notEditing
    private var annotations: [MKPointAnnotation] = [MKPointAnnotation]()
    private var coordinatesInMap: [LocationInfo] = [LocationInfo]() {
        didSet {
            delegate?.editButton(shouldShow: shouldShowEditButton)
        }
    }
    private var coordinatesInMapFilter:  [LocationInfo] = [LocationInfo]()
    
    // MARK: - Internal Properties
    var cellIndex: Int = 0
    var itemSelected: Int = 0 {
        didSet {
            guard coordinatesInMapFilter.isEmpty else {
                delegate?.navigateToCityDetail(with: coordinatesInMapFilter[itemSelected])
                return
            }
            if coordinatesInMap.indices.contains(itemSelected) {
                delegate?.navigateToCityDetail(with: coordinatesInMap[itemSelected])
            }
        }
    }
    
    // MARK: - Delegates
    weak var delegate: HomeViewControllerDelegate?
    
    init() {
    }
    
    // MARK: - Computed Properties
    var cityName: String {
        guard coordinatesInMapFilter.isEmpty else {
            return coordinatesInMapFilter[cellIndex].cityName
        }
        if coordinatesInMap.indices.contains(cellIndex) {
            return coordinatesInMap[cellIndex].cityName
        } else{
            return StringsText.Home.notInfo
        }
    }
    
    var cityLocation: String {
        guard coordinatesInMapFilter.isEmpty else {
            return "\(StringsText.Home.latitude): \(coordinatesInMapFilter[cellIndex].coordinates.latitude)\n\(StringsText.Home.longitude): \(coordinatesInMapFilter[cellIndex].coordinates.longitude)"
        }
        if coordinatesInMap.indices.contains(cellIndex) {
            return "\(StringsText.Home.latitude): \(coordinatesInMap[cellIndex].coordinates.latitude)\n\(StringsText.Home.longitude): \(coordinatesInMap[cellIndex].coordinates.longitude)"
        } else {
            return StringsText.Home.notInfo
        }
    }
    
    var isEditing: Bool {
        return editButtonState == .notEditing
    }
    
    var editButtonText: String {
        return editButtonState.rawValue
    }
    
    var shouldShowEditButton: Bool {
        return coordinatesInMap.isEmpty
    }
}

// MARK: - Internal Functions
extension HomeViewModel {
    
    func deleteItem(at index: Int) {
        coordinatesInMap.remove(at: index)
        delegate?.reloadCitiesList()
        let annotationToRemove: MKPointAnnotation = annotations.remove(at: index)
        delegate?.remove(annotation: annotationToRemove)
    }
    
    func editButtonTouched() {
        editButtonState.switchState()
        delegate?.changeEditButton(text: editButtonState.rawValue)
        delegate?.reloadCitiesList()
    }
    
    func getSetionsAmountInCollection() -> Int {
        return 1
    }
    
    func getItemsAmountInCollection() -> Int {
        if coordinatesInMapFilter.isEmpty {
            return coordinatesInMap.count
        } else {
            return coordinatesInMapFilter.count
        }
    }
    
    func getAnnotation(with coordinates: CLLocationCoordinate2D) {
        storeLocation(with: coordinates) { [weak self] wasSuccess in
            if wasSuccess {
                let annotationInMap: MKPointAnnotation = MKPointAnnotation()
                annotationInMap.coordinate = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
                self?.annotations.append(annotationInMap)
                self?.delegate?.add(annotationInMap: annotationInMap)
                self?.delegate?.reloadCitiesList()
            } else {
                //TODO: Put a Error view and say try again
            }
        }
    }
    
    func filter(by text: String) {
        if text.isEmpty {
            coordinatesInMapFilter = [LocationInfo]()
        } else {
            coordinatesInMapFilter = coordinatesInMap.filter({ cityInfo -> Bool in
                return cityInfo.cityName.contains(text)
            })
        }
        self.delegate?.reloadCitiesList()
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
