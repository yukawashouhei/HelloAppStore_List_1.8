//
//  HikeView.swift
//  HelloAppStore_List_1.9
//
//

import SwiftUI

extension Animation {
    static func ripple(index: Int) -> Animation {
        Animation.spring(dampingFraction: 0.5)
            .speed(2)
            .delay(0.03 * Double(index))
    }
}

struct HikeView {
    var hike: Hike
    @State private var showDetail = true

    var content: some View {
        VStack {
            HStack {
                HikeGraph(hike: hike, path: \.elevation)
                    .frame(height: 200)
                    .animation(.ripple(index: 0), value: showDetail)

                VStack(alignment: .leading) {
                    Text(hike.name)
                        .font(.headline)
                    Text(hike.distanceText)
                }

                Spacer()

                Button {
                    withAnimation {
                        showDetail.toggle()
                    }
                } label: {
                    Label("Graph", systemImage: "chevron.right.circle")
                        .labelStyle(.iconOnly)
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
                        .scaleEffect(showDetail ? 1.5 : 1)
                        .padding()
                }
            }

            if showDetail {
                HikeDetail(hike: hike, showDetail: $showDetail)
                    .transition(.moveAndFade)
            }
        }
    }
}

struct HikeDetail: View {
    var hike: Hike
    @Binding var showDetail: Bool
    
    @State private var dataToShow = \Hike.Observation.elevation

    var buttons = [
        ("Elevation", \Hike.Observation.elevation),
        ("Heart Rate", \Hike.Observation.heartRate),
        ("Pace", \Hike.Observation.pace)
    ]

    var body: some View {
        VStack {
            HikeGraph(hike: hike, path: dataToShow)
                .frame(height: 200)

            HStack(spacing: 25) {
                ForEach(buttons, id: \.0) { value in
                    Button {
                        dataToShow = value.1
                    } label: {
                        Text(value.0)
                            .font(.system(size: 15))
                            .foregroundColor(value.1 == dataToShow
                                ? .gray
                                : .accentColor)
                            .animation(nil)
                    }
                }
            }
            
            Divider()
            
            Toggle("詳細を表示", isOn: $showDetail)
        }
    }
}

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .scale.combined(with: .opacity)
        )
    }
}

#Preview {
    let hikes = loadHikes()
    return VStack(spacing: 40) {
        HikeView(hike: hikes[0])
            .content
            .padding()
    }
}
