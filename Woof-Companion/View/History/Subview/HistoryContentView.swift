//
//  HistoryContentView.swift
//  Woof-Companion
//
//  Created by François-Xavier on 25/04/2024.
//

import SwiftUI

struct HistoryContentView: View {
    
    //MARK: - Properties
    let data: WalkModel
    
    //MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HistoryLabel(image: "calendar", text: "\(data.date.formatted(date: .complete, time: .omitted))")
                HistoryLabel(image: "clock", text: "Heure : \(data.startDate)")
                HistoryLabel(image: "sun.max", text: "Météo : " + (data.weather))
                HistoryLabel(image: "figure.walk", text: "Distance : \(formatDistance(distance: data.distance)) km")
                HistoryLabel(image: "timer", text: "Durée : \(formatTime(seconds: data.duration))")
                HistoryLabel(image: "bolt.fill", text: "Energie : \(data.energy) %")
                HistoryLabel(image: "figure.run", text: "Vitesse moyenne : " +  (formatSpeed(speed: data.speed)) + " m/s")
                HistoryLabel(image: "dog.fill", text: "Rencontre : \(data.encounter)")
            }
            .font(.title2)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(#colorLiteral(red: 0.9970293641, green: 0.9413875937, blue: 0.7955917716, alpha: 1)))
        }
        .scrollContentBackground(.hidden)
        .background(Color(#colorLiteral(red: 0.9970293641, green: 0.9413875937, blue: 0.7955917716, alpha: 1)))
    }
    
    private func formatTime(seconds: Double) -> String {
        let convertedSecond = Int(seconds)
        let hours = convertedSecond / 3600
        let minutes = (convertedSecond % 3600) / 60
        let hourString = hours > 0 ? "\(hours)h " : ""
        let minuteString = "\(minutes)m"
        return hourString + minuteString
    }
    
    private func formatDistance(distance: Double) -> String {
        let kilometers = distance / 1000.0
        let formattedDistance = String(format: "%.2f", kilometers)
        return formattedDistance
    }

    
    private func formatSpeed(speed: String) -> String {
        if let value = Double(speed) {
            let formattedSpeed = String(format: "%.2f", value)
            return formattedSpeed
        } else {
            return "N/A"
        }
    }
}

struct HistoryLabel: View {
    
    let image: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .font(.title3)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(radius: 2)
            
            Text(text)
                .font(.title3)
                .italic()
                .padding(.leading)
            
            Spacer()
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.ultraThickMaterial.opacity(0.6))
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
        .padding(.horizontal)
    }
}


#Preview {
    HistoryContentView(data: WalkModel())
}
