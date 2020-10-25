//
//  HomeViewTest.swift
//  WeatherAppTests
//
//  Created by Juan david Lopera lopez on 25/10/20.
//

import CoreLocation
import XCTest
@testable import WeatherApp

final class HomeViewTest: XCTestCase {
    
    var sut: HomeViewModel!
    
    override func setUpWithError() throws {
        sut = HomeViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testCityNameNotInfo() throws {
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        sut.getAnnotation(with: location)
        sut.cellIndex = 0
        XCTAssertEqual(sut.cityName, "Not Info")
    }
    
    func testEditButtonTextAsEdit() throws {
        XCTAssertEqual(sut.editButtonText, "Edit")
    }
    
    func testEditButtonTextAsOk() throws {
        sut.editButtonTouched()
        XCTAssertEqual(sut.editButtonText, "Ok")
    }
}
