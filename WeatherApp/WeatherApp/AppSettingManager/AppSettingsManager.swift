//
//  AppSettingsManager.swift
//  WeatherApp
//
//  Created by Juan david Lopera lopez on 25/10/20.
//

import UIKit

class AppSettingsManager {
    
    static let shared: AppSettingsManager = AppSettingsManager()
    
    // MARK: - Enum
    enum CurrentBackgroundColor {
        case blue
        case white
        case gray
        
        mutating func getColor() -> UIColor {
            switch self {
            case .blue:
                return .systemBlue
            case .gray:
                return .lightGray
            case .white:
                return .white
            }
        }
    }
    
    enum CurrentUnits {
        case metric
        case standar
        case imperial
        
        mutating func getUnits() -> String {
            switch self {
            case .imperial:
                return StringsText.Settings.unitsImperial
            case .metric:
                return StringsText.Settings.unitsMetric
            case .standar:
                return StringsText.Settings.unitsStandar
            }
        }
    }
    
    // MARK: - Properties
    var currentUnits: CurrentUnits = .metric
    var currentColor: CurrentBackgroundColor = .white
    
    // MARK: - Private Init
    private init() {
    }
}

