//
//  FinishedWalkView.swift
//  Woof-Companion
//
//  Created by François-Xavier on 23/04/2024.
//

import SwiftUI

struct FinishedWalkView: View {
    
    //MARK: - Property
    @EnvironmentObject private var coordinator: CoordinatorManager
    @State var weatherTag: WeatherChoice = .sun
    @State var energy: Double = 50
    @State var encounter = 0
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("Météo :")
                    .padding(.horizontal, 30)
                Spacer()
            }
            Picker("Weather", selection: $weatherTag) {
                ForEach(WeatherChoice.allCases, id: \.self) { choice in
                    Text(choice.description)
                }
            }
            .padding(.horizontal, 30)
            .pickerStyle(.segmented)
            
            Spacer()
            
            HStack {
                Text("Dépense énergétique :")
                    .padding(.horizontal, 30)
                Spacer()
            }
            
            VStack {
                Slider(value: $energy, in: 0...100)
                    .padding()
                Text(String(format: "%.0f", energy) + " %")
            }
            
            Spacer()
            
            HStack {
                Text("Nombre de rencontre :")
                    .padding(.horizontal, 30)
                Spacer()
            }
            Picker("Rencontre", selection: $encounter) {
                ForEach(0...10, id: \.self) { encounter in
                    Text(String(encounter))
                }
            }
            .padding(.horizontal, 30)
            .pickerStyle(.segmented)
            
            Spacer()
            
            Button {
                coordinator.dismissFullScreenCover()
                coordinator.selectedTab = .main
//                walkData.weather = weatherTag.description
//                walkData.energy = Int(energy2)
//                walkData.date = Date()
//                walkData.encounter = encounter
//                walkvm.newWalk(walk: walkData)
//                ending.toggle()
//                $presentationMode.wrappedValue.dismiss()
//                appModel.selection = 1
            } label: {
                Image(systemName: "checkmark")
                    .font(.title)
            }
            .padding()
            .background {
                Circle()
            }
        }
        .presentationBackground(.thinMaterial)
    }
}

#Preview {
    FinishedWalkView()
}
