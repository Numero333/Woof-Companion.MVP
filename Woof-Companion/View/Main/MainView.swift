//
//  MainView.swift
//  Woof-Companion
//
//  Created by François-Xavier on 23/04/2024.
//

import SwiftUI

struct MainView: View {
    
    //MARK: - Property
    @EnvironmentObject private var coordinator: CoordinatorManager
    @EnvironmentObject private var authManager: AuthManager
    
    //MARK: - Body
    var body: some View {
        
        NavigationView {
            VStack {
                AnnouncementView()
                Spacer()
                TotalActivityView()
                Spacer()
                LastWalkView()
                Spacer()
            }
            .frame(maxHeight: .infinity)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        coordinator.push(.parameters)
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(.black.opacity(0.4))
                            .font(.title3)
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        Image(systemName: "pawprint")
                        Text("Woof Companion")
                        
                    }
                    .font(.headline)
                }
            }
            .navigationTitle("Accueil")
            .background(Color(#colorLiteral(red: 0.9378123879, green: 0.7619144917, blue: 0.5526022911, alpha: 1)))
        }
    }
}

#Preview {
    MainView()
}
