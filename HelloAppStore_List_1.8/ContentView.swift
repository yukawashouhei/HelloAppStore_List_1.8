//
//  ContentView.swift
//  HelloAppStore_List_1.8
//
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List(landmarks) { landmark in
                NavigationLink {
                    LandmarkDetail(landmark: landmark)
                } label: {
                    LandmarkRow(landmark: landmark)
                }
            }
            .navigationTitle("Landmarks")
        }
    }
}

#Preview {
    ContentView()
}
