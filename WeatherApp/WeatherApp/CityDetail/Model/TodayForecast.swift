//
//  TodayForecast.swift
//  WeatherApp
//
//  Created by Juan david Lopera lopez on 24/10/20.
//

import Foundation

struct TodayForecast: Decodable {
    var main: MainForecast
    var wind: WindForecast
    var clouds: CloudsForecast
    var day: String
    
    enum CodingKeys: String, CodingKey {
        case main
        case wind
        case clouds
        case day = "dt_txt"
    }
}
