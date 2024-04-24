//
//  TimerManager.swift
//  Woof-Companion
//
//  Created by François-Xavier on 24/04/2024.
//

import Foundation

// Timer manager that tracks elapsed time.
final class TimerManager: ObservableObject {
    
    // MARK: Properties
    
    // Display time as a string.
    @Published var displayElapsedTime = "00:00:00"
    
    // Start date of the timer.
    private var startDate = Date()
    
    // Timer instance.
    private var timer = Timer()
    
    // Formatted start time for display.
    var startHour = Date.now.formatted(date: .omitted, time: .shortened)
    
    // Elapsed time in seconds.
    var elapsedTime: Double = 0
    
    // Total accumulated time in seconds during pauses or stops.
    var totalInSecond: Double = 0
        
    // MARK: Methods
    
    // Starts or resumes the timer.
    func start() {
        startDate = Date() // Resets the start date to the current moment.
        // Schedules a timer that fires every second.
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            // Calculate elapsed time by taking the absolute difference from now and adding any accumulated time.
            self.elapsedTime = abs(self.startDate.timeIntervalSinceNow) + self.totalInSecond
            DispatchQueue.main.async { // Ensures the UI update happens on the main thread.
                // Formats and updates the display time.
                self.displayElapsedTime = self.formatTime(time: self.elapsedTime)
            }
        }
    }

    // Pauses the timer.
    func pause() {
        totalInSecond += abs(startDate.timeIntervalSinceNow) // Adds time since last resume.
        timer.invalidate() // Stops the timer.
    }
    
    // Completely stops the timer.
    func stop() {
        totalInSecond += abs(startDate.timeIntervalSinceNow) // Adds elapsed time to totalInSecond.
        timer.invalidate() // Stops the timer.
    }
    
    // MARK: Private Methods
    
    // Formats elapsed time into a hour:minute:second format.
    private func formatTime(time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let hours = minutes / 60
        return String(format: "%02d:%02d:%02d", hours, minutes % 60, seconds) // Added `% 60` to correct minute display.
    }
    
    // Releases resources related to the timer when the instance is destroyed.
    deinit {
        timer.invalidate() // Ensures the timer is properly stopped.
    }
}
