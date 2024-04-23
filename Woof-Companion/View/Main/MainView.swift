//
//  MainView.swift
//  Woof-Companion
//
//  Created by François-Xavier on 23/04/2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        
        VStack {
            TotalActivityView()
            LastWalkView()
        }
        .background(.red)
        
    }
}

#Preview {
    MainView()
}
