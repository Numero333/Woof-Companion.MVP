//
//  TotalActivityViewModelTest.swift
//  Woof-CompanionTests
//
//  Created by François-Xavier on 26/04/2024.
//

import XCTest
@testable import Woof_Companion

final class TotalActivityViewModelTest: XCTestCase {

    //MARK: - Properties
    var model: TotalActivityViewModel!

    //MARK: - Override
        override func setUp() {
            super.setUp()
            model = TotalActivityViewModel()
        }

    //MARK: - Methods
        func testEnergyCalculationWithWalks() {
            model.recentWalks = [WalkModel(energy: 10), WalkModel(energy: 20)]
            XCTAssertEqual(model.energy, "15 %", "Energy should be averaged and suffixed with '%'")
        }

        func testEnergyCalculationWithoutWalks() {
            XCTAssertEqual(model.energy, "0 %", "Energy should be '0 %' when no walks are present")
        }

        func testDistanceCalculation() {
            model.recentWalks = [WalkModel(distance: 1000), WalkModel(distance: 2000)]
            XCTAssertEqual(model.distance, "3.00 km", "Distance should sum up and convert to kilometers")
        }

        func testDurationCalculation() {
            model.recentWalks = [WalkModel(duration: 3600), WalkModel(duration: 1800)]
            XCTAssertEqual(model.duration, "1h 30m", "Duration should sum up and format correctly")
        }

        func testEncounterCalculation() {
            model.recentWalks = [WalkModel(encounter: 1), WalkModel(encounter: 2)]
            XCTAssertEqual(model.encouter, "3", "Encounters should sum up correctly")
        }

}
