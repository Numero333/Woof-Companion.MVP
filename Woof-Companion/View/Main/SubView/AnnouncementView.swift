//
//  AnnouncementView.swift
//  Woof-Companion
//
//  Created by François-Xavier on 26/04/2024.
//

import SwiftUI

struct AnnouncementView: View {
    
    //MARK: - Properties
    private var vm = AnnouncementViewModel()
    
    //MARK: - Body
    var body: some View {
        VStack {
            HStack {
                Text("Annonce")
                    .font(.title2)
                    .italic()
                Spacer()
            }
            .padding(.leading)
            .padding(.top, -30)
            
            Text(vm.title)
                .font(.title3)
                .fontWeight(.medium)
                .padding(.bottom)
                
            Text(vm.text)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ultraThinMaterial)
        .cornerRadius(25.0)
        .padding(.horizontal)
    }
}

#Preview {
    AnnouncementView()
}
