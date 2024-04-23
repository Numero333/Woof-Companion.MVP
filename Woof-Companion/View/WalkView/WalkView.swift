//
//  WalkView.swift
//  Woof-Companion
//
//  Created by François-Xavier on 23/04/2024.
//

import SwiftUI

struct WalkView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        VStack {
            Text("Walking on a dream !")
            
            Button {
                coordinator.present(fullScreenCover: .finishedWalk)
                print("toggle fullscreen")
            } label: {
                Text("FullScren Test Mode")
            }
        }
    }
}

#Preview {
    WalkView()
}
