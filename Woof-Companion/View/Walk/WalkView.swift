//
//  WalkView.swift
//  Woof-Companion
//
//  Created by François-Xavier on 23/04/2024.
//

import SwiftUI

struct WalkView: View {
    @EnvironmentObject private var coordinator: CoordinatorManager
    @EnvironmentObject private var appModel: AppModel
    @ObservedObject var timer = TimerManager()
    @ObservedObject var pedometer = PedometerManager()
    
    
    
    @ObservedObject var vm = WalkViewModel()
    
    @State var currentWalk = WalkModel()
    
    var body: some View {
        
        VStack(spacing: 20) {
            HStack {
                
                TopCell(value: "\(timer.startHour)", label: "Heure de début")
                    .frame(maxWidth: .infinity)
                
                TopCell(value: "\(vm.formatSpeed(speed: pedometer.speed)) m/s", label: "Allure.Moy")
                    .frame(maxWidth: .infinity)
            }
            .padding(.top, 50)
            
            Spacer()
            
            MiddleCell(value: pedometer.elapsedDistanceFormatted, label: "Kilomètres")
            
            Divider()
                .padding(.horizontal)
            
            MiddleCell(value: timer.displayElapsedTime , label: "Temps")
            
            Spacer()
            
            HStack {
                Button {
                    
                    if vm.isStarted {
                        timer.pause()
                        vm.isStarted.toggle()
                        
                    } else {
                        pedometer.startCountingSteps()
                        timer.start()
                        vm.isStarted.toggle()
                    }
                    
                } label: {
                    Image(systemName: vm.isStarted ? "pause" : "play.fill")
                        .font(.system(size: 40, weight: .heavy))
                        .foregroundColor(.white)
                        .padding(25)
                        .background(
                            Circle()
                                .foregroundColor(.black))
                }
                .padding(.bottom, 40)
                .padding(.trailing, 70)
                
                Button {
                    timer.stop()
                    vm.isStarted.toggle()
                    appModel.walkModel.distance = pedometer.currentDistance as! Double
                    appModel.walkModel.duration = timer.elapsedTime
                    appModel.walkModel.startDate = timer.startHour
                    appModel.walkModel.speed = pedometer.speed
                    appModel.walkModel.totalInSecond = timer.totalInSecond
                    
                    coordinator.present(fullScreenCover: .finishedWalk)
                } label: {
                    Image(systemName: "stop")
                        .font(.system(size: 40, weight: .heavy))
                        .foregroundColor(.white)
                        .padding(25)
                        .background(
                            Circle()
                                .foregroundColor(.black))
                }
                .padding(.bottom, 40)
            }
        }
        .environmentObject(vm)
        .frame(maxHeight: .infinity)
        .background(Color(red: 0.969, green: 0.392, blue: 0.0).opacity(0.7))
    }
}

// MARK: SubViews
struct MiddleCell: View {
    var value: String
    var label: String
    var body: some View {
        VStack(spacing: -15) {
            Text(value)
                .font(.system(size: 80))
                .bold()
                .italic()
                .monospacedDigit()
                .foregroundColor(.black)
            HStack {
                Spacer()
                Text(label)
                    .font(.title2)
                    .italic()
                    .bold()
                    .foregroundColor(.secondary)
                    .padding(.trailing, 30)
                
            }
        }
    }
}

struct TopCell: View {
    var value: String
    var label: String
    var body: some View {
        VStack {
            Text(value)
                .font(.title2)
                .bold()
                .italic()
            Text(label)
                .foregroundColor(.secondary)
                .font(.subheadline)
                .bold()
        }
    }
}

struct Ballade_Previews: PreviewProvider {
    static var previews: some View {
        WalkView()
    }
}
