//
//  PedometerManager.swift
//  Woof-Companion
//
//  Created by François-Xavier on 24/04/2024.
//

import Foundation
import CoreMotion

// Manages pedometer data and encapsulates step counting and distance measurement functionalities.
final class PedometerManager: ObservableObject {
    
    // MARK: Properties
    
    // Instance of CMPedometer to access motion data.
    private let pedometer: CMPedometer
    
    // Tracks the number of steps taken.
    @Published private var stepCount: NSNumber
    
    // Tracks the current distance traveled in meters.
    @Published var currentDistance: NSNumber
    
    // Stores the formatted distance as a string.
    @Published var elapsedDistanceFormatted: String
    
    // Stores the walking or running speed.
    @Published var speed: String
    
    // MARK: - Initialization
    // Initializes the pedometer and published properties.
    init() {
        pedometer = CMPedometer()
        stepCount = 0
        currentDistance = 0
        elapsedDistanceFormatted = "00.00"
        speed = "0"
    }
    
    // MARK: Accessible Methods
    
    // Starts monitoring step counts and updates related data.
    func startCountingSteps() {
        // Checks if the device supports step counting.
        if CMPedometer.isStepCountingAvailable() {
            
            // Begins updating pedometer data from the current date and time.
            pedometer.startUpdates(from: Date()) { [weak self] (data, error) in
                guard let self = self, let data = data, error == nil else {
                    // Handles errors in starting the pedometer updates.
                    print("Error starting pedometer: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                // Updates step count with the latest data.
                self.stepCount = data.numberOfSteps
                
                // Guards to safely unwrap the distance data.
                guard let dataDistance = data.distance else { return }
                
                // Guards to safely unwrap the pace data.
                guard let dataPace = data.averageActivePace else { return }
                
                // Updates the current distance traveled.
                self.currentDistance = dataDistance
                
                // Formats and updates the distance for display.
                self.elapsedDistanceFormatted = self.formatDistance(distance: dataDistance)
                
                // Converts and updates the pace data for display.
                self.speed = String(describing: dataPace)
            }
        } else {
            // Informs if the device does not support the pedometer.
            print("Pedometer is not available on this device.")
        }
    }
    
    //MARK: - Private Methods
    
    // Formats the numeric distance into a kilometer and meter string.
    private func formatDistance(distance: NSNumber) -> String {
        let kilometers = Int(truncating: distance) / 1000
        let meters = Int(truncating: distance) % 1000
        let formatDistance = String(format: "%02d.%03d", kilometers, meters)
        return formatDistance
    }
}

