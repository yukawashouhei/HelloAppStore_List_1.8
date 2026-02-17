//
//  ContentView.swift
//  HelloAppStore_List_1.9
//
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ParentView()
                } header: {
                    Text("Binding デモ")
                }

                Section {
                    ForEach(landmarks) { landmark in
                        NavigationLink {
                            LandmarkDetail(landmark: landmark)
                        } label: {
                            LandmarkRow(landmark: landmark)
                        }
                    }
                }
            }
            .navigationTitle("Landmarks")
        }
    }
}

#Preview {
    ContentView()
}
