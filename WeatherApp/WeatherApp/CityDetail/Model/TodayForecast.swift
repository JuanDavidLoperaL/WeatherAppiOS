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
}
