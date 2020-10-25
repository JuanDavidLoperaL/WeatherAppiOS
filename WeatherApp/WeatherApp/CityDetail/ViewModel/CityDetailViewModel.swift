//
//  CityDetailViewModel.swift
//  WeatherApp
//
//  Created by Juan david Lopera lopez on 24/10/20.
//

import Foundation

final class CityDetailViewModel {
    
    // MARK: - Private Properties
    private let cityInfo: LocationInfo
    private let api: CityDetailAPIProtocol
    private var todayForecast: TodayForecast?
    
    // MARK: - Delegates
    weak var delegate: CityDetailViewControllerDelegate?
    
    // MARK: - Internal Init
    init(cityInfo: LocationInfo, api: CityDetailAPIProtocol = CityDetailAPI()) {
        self.cityInfo = cityInfo
        self.api = api
    }
    
    // MARK: - Computed Properties
    var cityName: String {
        return cityInfo.cityName
    }
    
    var todayTemperature: String {
        return "\(todayForecast?.main.temp ?? 0)°"
    }
    
    var todayRainChances: String {
        return "\(todayForecast?.clouds.all ?? 0)%"
    }
    
    var todayWind: String {
        return "\(todayForecast?.wind.speed ?? 0) KM/H"
    }
    
    var todayHumidity: String {
        return "\(todayForecast?.main.humidity ?? 0)%"
    }
    
    var todayHeaderHumidityName: String {
        return StringsText.CityDetail.todayHumidityHeaderName
    }
    
    var todayHeaderWindName: String {
        return StringsText.CityDetail.todayWindHeaderName
    }
    
    var todayHeaderRainChancesName: String {
        return StringsText.CityDetail.todayRainChancesHeaderName
    }
    
    var todayPrincipalInformation: [((headerName: String, value: String))] {
        return [(headerName: todayHeaderHumidityName, value: todayHumidity),
                (headerName: todayHeaderWindName, value: todayWind),
                (headerName: todayHeaderRainChancesName, value: todayRainChances)]
    }
}

// MARK: - Internal Functions
extension CityDetailViewModel {
    func getWeather() {
        api.getWeather(for: cityInfo.cityName) { [weak self] result in
            switch result {
            case .success(let todayForecast):
                self?.todayForecast = todayForecast
                self?.delegate?.setupTodayForecast()
            case .failure(_):
                print("")
            }
        }
    }
}
