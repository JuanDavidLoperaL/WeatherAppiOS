//
//  SettingsViewModel.swift
//  WeatherApp
//
//  Created by Juan david Lopera lopez on 24/10/20.
//

import Foundation

final class SettingsViewModel {
    // MARK: - Enum
    enum BackgroundColorSelected: String {
        case blue = "Blue Color"
        case gray = "Gray Light Color"
        case white = "White Color"
    }
    
    enum Units: String {
        case metric = "metric"
        case standar = "standar"
        case imperial = "imperial"
    }
    
    // MARK: - Private Properties
    private var sections: [SectionsSettings] = [SectionsSettings]()
    
    // MARK: - Internal Properties
    var cellIndex: Int = 0
    var currentSection: Int = 0
    
    // MARK: - Delegate
    weak var delegate: SettingsViewControllerDelegate?
    
    // MARK: - Internal Init
    init() {
    }
    
    var numberOfSectionInTableView: Int {
        return sections.count
    }
    
    var numerOfRowInTableView: Int {
        return sections[currentSection].items.count
    }
    
    var sectionTitle: String {
        return sections[currentSection].sectionTitle
    }
    
    var itemTitle: String {
        guard sections.indices.contains(currentSection) && sections[currentSection].items.indices.contains(cellIndex) else {
            return ""
        }
        return sections[currentSection].items[cellIndex].name
    }
    
    var shouldHideCheckIcon: Bool {
        guard sections.indices.contains(currentSection) && sections[currentSection].items.indices.contains(cellIndex) else {
            return true
        }
        return !sections[currentSection].items[cellIndex].isSelected
    }
}

// MARK: Internal Functions
extension SettingsViewModel {
    func createSections() {
        sections = [unitSection(), backgroundSection()]
        delegate?.reloadTableView()
    }
    
    func changeSelection(for indexPath: IndexPath) {
        for index in 0...sections[indexPath.section].items.count - 1 {
            if index == indexPath.row {
                sections[indexPath.section].items[index].isSelected = true
                changeAppSettings(sectionSelected: indexPath.section, itemSelected: index)
            } else {
                sections[indexPath.section].items[index].isSelected = false
            }
        }
        delegate?.reloadTableView()
    }
}

// MARK: - Private Functions
extension SettingsViewModel {
    private func unitSection() -> SectionsSettings {
        switch AppSettingsManager.shared.currentUnits {
        case .imperial:
            let unitsSection: SectionsSettings = SectionsSettings(sectionTitle: StringsText.Settings.unitsSectionName, sectionType: .units, items: [ItemSectionSettings(name: StringsText.Settings.unitsMetric, isSelected: false), ItemSectionSettings(name: StringsText.Settings.unitsStandar, isSelected: false), ItemSectionSettings(name: StringsText.Settings.unitsImperial, isSelected: true)])
            return unitsSection
        case .metric:
            let unitsSection: SectionsSettings = SectionsSettings(sectionTitle: StringsText.Settings.unitsSectionName, sectionType: .units, items: [ItemSectionSettings(name: StringsText.Settings.unitsMetric, isSelected: true), ItemSectionSettings(name: StringsText.Settings.unitsStandar, isSelected: false), ItemSectionSettings(name: StringsText.Settings.unitsImperial, isSelected: false)])
            return unitsSection
        case .standar:
            let unitsSection: SectionsSettings = SectionsSettings(sectionTitle: StringsText.Settings.unitsSectionName, sectionType: .units, items: [ItemSectionSettings(name: StringsText.Settings.unitsMetric, isSelected: false), ItemSectionSettings(name: StringsText.Settings.unitsStandar, isSelected: true), ItemSectionSettings(name: StringsText.Settings.unitsImperial, isSelected: false)])
            return unitsSection
        }
    }
    
    private func backgroundSection() -> SectionsSettings {
        switch AppSettingsManager.shared.currentColor {
        case .blue:
            let backgroundSection: SectionsSettings = SectionsSettings(sectionTitle: StringsText.Settings.backgroundColorSectionName, sectionType: .background, items: [ItemSectionSettings(name: StringsText.Settings.whiteBackgroundColor, isSelected: false), ItemSectionSettings(name: StringsText.Settings.grayLightBackgroundColor, isSelected: false), ItemSectionSettings(name: StringsText.Settings.blueBackgroundColor, isSelected: true)])
            return backgroundSection
        case .gray:
            let backgroundSection: SectionsSettings = SectionsSettings(sectionTitle: StringsText.Settings.backgroundColorSectionName, sectionType: .background, items: [ItemSectionSettings(name: StringsText.Settings.whiteBackgroundColor, isSelected: false), ItemSectionSettings(name: StringsText.Settings.grayLightBackgroundColor, isSelected: true), ItemSectionSettings(name: StringsText.Settings.blueBackgroundColor, isSelected: false)])
            return backgroundSection
        case .white:
            let backgroundSection: SectionsSettings = SectionsSettings(sectionTitle: StringsText.Settings.backgroundColorSectionName, sectionType: .background, items: [ItemSectionSettings(name: StringsText.Settings.whiteBackgroundColor, isSelected: true), ItemSectionSettings(name: StringsText.Settings.grayLightBackgroundColor, isSelected: false), ItemSectionSettings(name: StringsText.Settings.blueBackgroundColor, isSelected: false)])
            return backgroundSection
        }

    }
    
    private func changeAppSettings(sectionSelected: Int, itemSelected: Int) {
        if sections[sectionSelected].sectionType == .background {
            let colorSelected: BackgroundColorSelected = BackgroundColorSelected(rawValue: sections[sectionSelected].items[itemSelected].name) ?? .white
            changeAppColor(colorSelected: colorSelected)
        } else {
            let unitSelected: Units = Units(rawValue: sections[sectionSelected].items[itemSelected].name) ?? .metric
            changeUnits(unitSelected: unitSelected)
        }
    }
    
    private func changeUnits(unitSelected: Units) {
        switch unitSelected {
        case .imperial:
            AppSettingsManager.shared.currentUnits = .imperial
        case .metric:
            AppSettingsManager.shared.currentUnits = .metric
        case .standar:
            AppSettingsManager.shared.currentUnits = .standar
        }
        
    }
    
    private func changeAppColor(colorSelected: BackgroundColorSelected) {
        switch colorSelected {
        case .blue:
            AppSettingsManager.shared.currentColor = .blue
        case .gray:
            AppSettingsManager.shared.currentColor = .gray
        case .white:
            AppSettingsManager.shared.currentColor = .white
        }
    }
}
