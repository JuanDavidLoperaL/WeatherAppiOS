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
    private var forecastList: ForecastList? {
        didSet{
            var listForecast: [TodayForecast] = [TodayForecast]()
            forecastList?.cityForecastList.forEach { forecast in
                if listForecast.isEmpty {
                    listForecast.append(forecast)
                } else {
                    let forecastData: [String] = forecast.day.components(separatedBy: " ")
                    if forecastData[0] > (listForecast.last?.day ?? "").components(separatedBy: " ")[0] {
                        listForecast.append(forecast)
                    }
                }
            }
            forecastList?.cityForecastList = listForecast
        }
    }
    private let todayPosition: Int = 0
    
    // MARK: - Internal Properties
    var currentCell: Int = 0
    
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
        return "\(forecastList?.cityForecastList[todayPosition].main.temp ?? 0)°"
    }
    
    var todayRainChances: String {
        return "\(forecastList?.cityForecastList[todayPosition].clouds.all ?? 0)%"
    }
    
    var todayWind: String {
        return "\(forecastList?.cityForecastList[todayPosition].wind.speed ?? 0) KM/H"
    }
    
    var todayHumidity: String {
        return "\(forecastList?.cityForecastList[todayPosition].main.humidity ?? 0)%"
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
    
    var nextDaysRainChances: String {
        return "\(StringsText.CityDetail.todayRainChancesHeaderName): \(forecastList?.cityForecastList[currentCell].clouds.all ?? 0)%"
    }
    
    var nextDaysWind: String {
        return "\(StringsText.CityDetail.todayWindHeaderName): \(forecastList?.cityForecastList[currentCell].wind.speed ?? 0) KM/H"
    }
    
    var nextDaysHumidity: String {
        return "\(StringsText.CityDetail.todayHumidityHeaderName): \(forecastList?.cityForecastList[currentCell].main.humidity ?? 0)%"
    }
    
    var nextDaysTemperature: String {
        return "\(forecastList?.cityForecastList[currentCell].main.temp ?? 0)°"
    }
    
    var nextDays: String {
        guard let forecastList = forecastList,
              !forecastList.cityForecastList.isEmpty else {
            return ""
        }
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterToShow = DateFormatter()
        dateFormatterToShow.dateFormat = "d MMM"
        
        let forecastDate: String = forecastList.cityForecastList[currentCell].day
        guard let date = dateFormatterGet.date(from: forecastDate) else { return "" }
        return "\(dateFormatterToShow.string(from: date))"
    }
    
    var todayPrincipalInformation: [((headerName: String, value: String))] {
        return [(headerName: todayHeaderHumidityName, value: todayHumidity),
                (headerName: todayHeaderWindName, value: todayWind),
                (headerName: todayHeaderRainChancesName, value: todayRainChances)]
    }
    
    var numberOfRowInTableView: Int {
        return 4
    }
    
    var numberOfSectionInTableView: Int {
        return 1
    }
}

// MARK: - Internal Functions
extension CityDetailViewModel {
    func getWeather() {
        api.getLastFiveDaysForecast(for: cityName) { [weak self] result in
            switch result {
            case .success(let forecastList):
                self?.forecastList = forecastList
                self?.delegate?.setupTodayForecast()
                self?.delegate?.reloadTableView()
            case .failure(_):
                print("")
            }
        }
    }
}
