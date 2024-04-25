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
    @EnvironmentObject private var appModel: AppModel
    @ObservedObject private var vm = WalkViewModel()
    
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
                
                #warning("Call to save into database")
                
                appModel.walkModel.weather = weatherTag.description
                appModel.walkModel.energy = Int(energy)
                appModel.walkModel.date = Date()
                appModel.walkModel.encounter = encounter
                
                vm.addWalk(for: appModel.walkModel)
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
//        .presentationBackground(.thinMaterial)
    }
}

#Preview {
    FinishedWalkView()
}
