//
//  SectionsSettings.swift
//  WeatherApp
//
//  Created by Juan david Lopera lopez on 24/10/20.
//

import Foundation

struct SectionsSettings {
    enum SectionType {
        case units
        case background
    }
    
    var sectionTitle: String
    var sectionType: SectionType
    var items: [ItemSectionSettings]
}
