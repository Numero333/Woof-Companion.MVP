//
//  TotalActivityView.swift
//  Woof-Companion
//
//  Created by François-Xavier on 23/04/2024.
//

import SwiftUI

struct TotalActivityView: View {
        
    //MARK: - Properties
    @ObservedObject private var vm = TotalActivityViewModel()
    
    //MARK: - Body
    var body: some View {
        VStack {
            Text("Total de la journée")
                .font(.title2)
                .italic()
                .foregroundColor(.black)
                .padding()
            HStack{
                Cell(systemName: "timer", label: "Durée", value: vm.duration)
                Cell(systemName: "location", label: "Distance", value: vm.distance)
                Cell(systemName: "bolt", label: "Energie", value: vm.energy)
                Cell(systemName: "pawprint", label: "Rencontre", value: vm.encouter)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(25)
        .padding(.horizontal)
        .onAppear {
            vm.fetch()
        }
    }
}

struct TotalActivityView_Previews: PreviewProvider {
    static var previews: some View {
        TotalActivityView()
    }
}

struct Cell: View {
    
    var systemName: String = "gear"
    var label: String = "Label"
    var value: String = ""
    
    var body: some View {
        VStack {
            Image(systemName: systemName)
                .padding(10)
                .frame(width: 40, height: 40)
                .background(.thickMaterial)
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .shadow(radius: 2)
            Text(label)
                .font(.caption2)
                .foregroundColor(.black)
            Text(value)
            
        }
        .frame(maxWidth: .infinity)
        
    }
}
