//
//  SettingsViewModelTest.swift
//  WeatherAppTests
//
//  Created by Juan david Lopera lopez on 25/10/20.
//

import XCTest
@testable import WeatherApp

final class SettingsViewModelTest: XCTestCase {
    
    var sut: SettingsViewModel!
    override func setUpWithError() throws {
        sut = SettingsViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testNumberOfSectionsAsTwo() throws {
        sut.createSections()
        XCTAssertEqual(sut.numberOfSectionInTableView, 2)
    }
    
    func testNumberOfRowsInSectionOneAsThree() throws {
        sut.createSections()
        sut.currentSection = 0
        XCTAssertEqual(sut.numerOfRowInTableView, 3)
    }
    
    func testNumberOfRowsInSectionTwoAsThree() throws {
        sut.createSections()
        sut.currentSection = 1
        XCTAssertEqual(sut.numerOfRowInTableView, 3)
    }
    
    func testSectionOneTitleAsChangeUnits() throws {
        sut.createSections()
        sut.currentSection = 0
        XCTAssertEqual(sut.sectionTitle, "Change Units")
    }
    
    func testSectionTwoTitleAsChangeBackgroundColor() throws {
        sut.createSections()
        sut.currentSection = 1
        XCTAssertEqual(sut.sectionTitle, "Change Background Color")
    }
    
    func testSectionOneFirstItemTitleAsMetric() throws {
        sut.createSections()
        sut.currentSection = 0
        sut.cellIndex = 0
        XCTAssertEqual(sut.itemTitle, "metric")
    }
    
    func testSectionTwoFirstItemTitleAsWhiteColor() throws {
        sut.createSections()
        sut.currentSection = 1
        sut.cellIndex = 0
        XCTAssertEqual(sut.itemTitle, "White Color")
    }
}
