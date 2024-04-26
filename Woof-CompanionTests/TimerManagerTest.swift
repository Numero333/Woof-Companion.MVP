//
//  TimerManagerTest.swift
//  Woof-CompanionTests
//
//  Created by François-Xavier on 26/04/2024.
//

import XCTest
@testable import Woof_Companion

final class TimerManagerTest: XCTestCase {
    
    var timerManager: TimerManager!

    override func setUp() {
        super.setUp()
        timerManager = TimerManager()
    }

    // Testing start function: Checks if the display starts at "00:00:00" and then changes
    func testStartTimer() {
        timerManager.start()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotEqual(self.timerManager.displayElapsedTime, "00:00:00", "Timer should update from the initial value.")
        }
    }

    // Testing pause function: Ensures timer stops accumulating time
    func testPauseTimer() {
        timerManager.start()
        let expectedTime = timerManager.displayElapsedTime
        timerManager.pause()
        let pausedTime = timerManager.displayElapsedTime
        XCTAssertEqual(expectedTime, pausedTime, "Timer should pause and keep the same time.")
    }

    // Testing stop function: Ensures timer stops and resets the time display
    func testStopTimer() {
        timerManager.start()
        timerManager.stop()
        XCTAssertEqual(timerManager.displayElapsedTime, "00:00:00", "Timer should stop and reset the time.")
    }

    // Testing time formatting function directly
    func testTimeFormatting() {
        XCTAssertEqual(timerManager.formatTime(time: 3661), "01:01:01", "Time should be formatted to HH:MM:SS format.")
    }
}

