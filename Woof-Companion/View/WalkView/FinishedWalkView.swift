//
//  FinishedWalkView.swift
//  Woof-Companion
//
//  Created by François-Xavier on 23/04/2024.
//

import SwiftUI

struct FinishedWalkView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        Text("La ballade était agréable ?")
        
        Button {
            coordinator.dismissFullScreenCover()
        } label: {
            Text("FullScren Close")
        }
    }
}

#Preview {
    FinishedWalkView()
}
