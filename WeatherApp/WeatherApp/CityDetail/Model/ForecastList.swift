//
//  ForecastList.swift
//  WeatherApp
//
//  Created by Juan david Lopera lopez on 25/10/20.
//

import Foundation

struct ForecastList: Decodable {
    var cityForecastList: [TodayForecast]
    
    enum CodingKeys: String, CodingKey {
        case cityForecastList = "list"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cityForecastList = try container.decode([TodayForecast].self, forKey: .cityForecastList)
    }
}
