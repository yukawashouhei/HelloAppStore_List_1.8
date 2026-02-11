//
//  LandmarkDetail.swift
//  HelloAppStore_List_1.8
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
                        // 意図的なエラー: HikeViewはViewプロトコルに準拠していない
                        // Type 'HikeView' does not conform to protocol 'View'
                        HikeView(hike: hike)
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
