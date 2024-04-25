//
//  HistoryView.swift
//  Woof-Companion
//
//  Created by François-Xavier on 23/04/2024.
//

import SwiftUI
import FirebaseFirestore

@MainActor
struct HistoryView: View {
    
    private var walkData = WalkDataStoreManager()
    private var auth = AuthManager()
    
    @ObservedObject private var vm = HistoryViewModel()
    
    @State private var dataReceived = ""
    
    var body: some View {
        
        VStack {
            NavigationView {
                if vm.isLoading {
                    ProgressView("Chargement...")
                } else {
                    List {
                        ForEach(vm.walkStored, id: \.self) { data in
                            NavigationLink(destination: {
                                HistoryContentView(data: data)
                            }, label: {
                                Text(data.date.formatted(date: .complete, time: .shortened))
                                    .padding()
                            })
                            .listRowBackground(Color.gray.opacity(0.1))
                        }
                        .onDelete(perform: { indexSet in
                            indexSet.forEach { index in
//                                vm.delete(id: vm.walkStored[index])
                            }
                        })
                    }
                    .background(Color.clear)
                    .scrollContentBackground(.hidden)
                    .listStyle(.insetGrouped)
                    .cornerRadius(15)
                }
            }
            .navigationTitle("Historique")
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.9970293641, green: 0.9413875937, blue: 0.7955917716, alpha: 1)))
        .onAppear {
            vm.fetchAll()
        }
        
    }
}

#Preview {
    HistoryView()
}
