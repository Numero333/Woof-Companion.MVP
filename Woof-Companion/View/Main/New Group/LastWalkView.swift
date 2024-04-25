//
//  LastWalkView.swift
//  Woof-Companion
//
//  Created by François-Xavier on 23/04/2024.
//

import SwiftUI

struct LastWalkView: View {
    
    //MARK: - Properties
//    @StateObject var vm = LastWalkViewModel()
    
    let staticValue = "10"
    
    //MARK: - Body
    var body: some View {
        
        VStack {
    
            VStack(alignment: .center, spacing: 0) {
                HStack {
                    Text("Dernière sorti ")
                        .font(.title2)
                        .italic()
                    Spacer()
                }
                .padding(.bottom)
                
                HStack {
                    InfoTag(icon: "bolt.fill", text: staticValue, color: Color.yellow.gradient)
                    InfoTag(icon: "sun.max", text: staticValue, color: Color.pink.gradient)
                    InfoTag(icon: "pawprint", text: staticValue, color: Color.green.gradient
                    )
                }
                .padding(.bottom, 10)
                
                HStack(alignment: .center) {
                    BigTag(icon: "clock", text: "Heure", color: .blue, value: staticValue)
                    Spacer()
                    BigTag(icon: "timer", text: "Durée", color: .orange, value: staticValue)
                    Spacer()
                    BigTag(icon: "flag", text: "Distance", color: .cyan, value: staticValue)
                }
                
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(25)
            .padding(.horizontal)
        }
        .onAppear {
           
        }
    }
}

struct LastWalkView_Previews: PreviewProvider {
    static var previews: some View {
        LastWalkView()
    }
}

// MARK: SubView
struct InfoTag: View {
    var icon: String
    var text: String
    var color: AnyGradient
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title3)
            Text(text)
                .font(.title3)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(color)
        .cornerRadius(10)
    }
}
struct BigTag: View {
    var icon: String
    var text: String
    var color: Color
    var value: String
    var body: some View {
            VStack(alignment: .center){
                VStack {
                    Image(systemName: icon)
                        .font(.system(size: 30, weight: .regular))
                        .cornerRadius(100)
                        .padding(.top, -10)
                    Text(text)
                        .font(.caption)
                        .padding(.bottom, 40)
                        .padding(.horizontal, -15)
                }
                
                Text(value)
                    .font(.title3)
                    .padding(.top, -30)
            }
            .frame(maxWidth: .infinity)
            .padding(15)
            .padding(.bottom, -5)
            .background(
                VStack(spacing: 0) {
                    color
                    color
                        .opacity(0.4)
                }
                
            )
            .cornerRadius(25)
    }
}
