//
//  WalkView.swift
//  Woof-Companion
//
//  Created by François-Xavier on 23/04/2024.
//

import SwiftUI

struct WalkView: View {
    @EnvironmentObject private var coordinator: CoordinatorManager
    @Environment(\.presentationMode) var presentationMode
    
    #warning("bouger timer manager et pedometer")
    @ObservedObject var timer = TimerManager()
    @ObservedObject var pedometer = PedometerManager()
    
    @State var isStarted = false
    @State var ending =  false
        
    let vm = WalkViewModel()
    
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
                    
                    if isStarted {
                        timer.pause()
                        isStarted.toggle()
                        
                    } else {
                        pedometer.startCountingSteps()
                        timer.start()
                        isStarted.toggle()
                    }
                    
                } label: {
                    Image(systemName: isStarted ? "pause" : "play.fill")
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
                    currentWalk.distance = pedometer.currentDistance as! Double
                    currentWalk.duration = timer.elapsedTime
                    currentWalk.startDate = timer.startHour
                    currentWalk.speed = pedometer.speed
                    currentWalk.totalInSecond = timer.totalInSecond
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
