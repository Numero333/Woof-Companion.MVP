//
//  LastWalkViewModelTest.swift
//  Woof-CompanionTests
//
//  Created by François-Xavier on 26/04/2024.
//

import XCTest
@testable import Woof_Companion

final class LastWalkViewModelTest: XCTestCase {
    
    //MARK: - Properties
    var model: LastWalkViewModel!
    
    //MARK: - Override
        override func setUp() {
            super.setUp()
            model = LastWalkViewModel()
        }
    
    
    //MARK: - Methods
    func testEnergyProperty() {
        //Given
        model.lastWalk = WalkModel(startDate: "10 Avril 2024", distance: 10.0, duration: 10, energy: 30, speed: "1.2", weather: "Soleil", totalInSecond: 300, date: Date(), encounter: 2)
        
        //Then
        XCTAssertEqual(model.energy, "30 %", "Energy should correctly append '%' to the value.")
    }
    
    func testWeatherProperty() {
        //Given
        model.lastWalk = WalkModel(startDate: "10 Avril 2024", distance: 10.0, duration: 10, energy: 30, speed: "1.2", weather: "Soleil", totalInSecond: 300, date: Date(), encounter: 2)
        
        //Then
        XCTAssertEqual(model.weather, "Soleil", "Weather should correctly return the weather status.")
    }
    
    func testEncounterProperty() {
        //Given
        model.lastWalk = WalkModel(startDate: "10 Avril 2024", distance: 10.0, duration: 10, energy: 30, speed: "1.2", weather: "Soleil", totalInSecond: 300, date: Date(), encounter: 2)
        
        //Then
        XCTAssertEqual(model.encounter, "2", "Encounter should correctly return the encounter count.")
    }
    
    func testStartDateProperty() {
        //Given
        model.lastWalk = WalkModel(startDate: "10 Avril 2024", distance: 10.0, duration: 10, energy: 30, speed: "1.2", weather: "Soleil", totalInSecond: 300, date: Date(), encounter: 2)
        
        //Then
        XCTAssertEqual(model.startDate, "10 Avril 2024", "StartDate should return the correct date.")
    }
    
    func testDistanceProperty() {
        //Given
        model.lastWalk = WalkModel(startDate: "10 Avril 2024", distance: 10.0, duration: 10, energy: 30, speed: "1.2", weather: "Soleil", totalInSecond: 300, date: Date(), encounter: 2)
        
        //Then
        XCTAssertEqual(model.distance, "0.01 km", "Distance should convert meters to kilometers and format correctly.")
    }
}

