//
//  CityDetailAPI.swift
//  WeatherApp
//
//  Created by Juan david Lopera lopez on 24/10/20.
//

import Foundation

protocol CityDetailAPIProtocol: AnyObject {
    func getWeather(for city: String, completionHandler: @escaping(Result<TodayForecast, ErrorInRequest>) -> Void)
}

final class CityDetailAPI: CityDetailAPIProtocol {
    
    // MARK: - Private Properties
    private let scheme: String = "http"
    private let host: String = "api.openweathermap.org"
    private let apiKey: String = "c6e381d8c7ff98f0fee43775817cf6ad"
    private let urlSession: URLSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    
    // MARK: Enum
    enum Endpoint: String {
        case cityForecast = "/data/2.5/weather"
    }
    // MARK: - Internal Init
    init() {
    }
    
    func getWeather(for city: String, completionHandler: @escaping(Result<TodayForecast, ErrorInRequest>) -> Void) {
        guard let url: URL = getUrlForCityForecast(cityName: city) else {
            return
        }
        dataTask = urlSession.dataTask(with: url, completionHandler: { [weak self] data, urlResponse, error in
            defer {
                self?.dataTask = nil
            }
            guard error == nil,
                  let data = data,
                  let response = urlResponse as? HTTPURLResponse else {
                debugPrint("❌ JSON Error: ❌")
                completionHandler(.failure(.errorInResponse))
                return
            }

            guard response.statusCode == 200 else {
                debugPrint("❌ Status Error: \(response.statusCode) ❌")
                return completionHandler(.failure(.errorInResponse))
            }

            do {
                let todayForecast: TodayForecast = try JSONDecoder().decode(TodayForecast.self, from: data)
                completionHandler(.success(todayForecast))
            } catch {
                debugPrint("❌ Error Decoding JSON ❌")
                completionHandler(.failure(.errorInResponse))
            }
        })
        dataTask?.resume()
    }
}

// MARK: - Private Functions
extension CityDetailAPI {
    func getUrlForCityForecast(cityName: String) -> URL? {
        let city: String = cityName.replacingOccurrences(of: " ", with: "+")
        let queryItems = [URLQueryItem(name: "q", value: city),
                          URLQueryItem(name: "appid", value: apiKey),
                          URLQueryItem(name: "units", value: AppSettingsManager.shared.currentUnits.getUnits())]
        var urlComponent = URLComponents()
        urlComponent.scheme = scheme
        urlComponent.host = host
        urlComponent.path = Endpoint.cityForecast.rawValue
        urlComponent.queryItems = queryItems
        return urlComponent.url
    }
}
