//
//  LandmarkDetail.swift
//  HelloAppStore_List_1.9
//
//

import SwiftUI

struct LandmarkDetail: View {
    var landmark: Landmark

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                landmark.image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
                    .clipped()

                VStack(alignment: .leading) {
                    Text(landmark.name)
                        .font(.title)

                    HStack {
                        Text(landmark.park)
                        Spacer()
                        Text(landmark.state)
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                    Divider()

                    Text("About \(landmark.name)")
                        .font(.title2)
                    Text(landmark.description)
                    
                    Divider()
                    
                    if let hike = hikes.first {
                        HikeView(hike: hike).content
                    }
                }
                .padding()
            }
            .navigationTitle(landmark.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    let landmarks = loadLandmarks()
    NavigationStack {
        LandmarkDetail(landmark: landmarks[0])
    }
}
