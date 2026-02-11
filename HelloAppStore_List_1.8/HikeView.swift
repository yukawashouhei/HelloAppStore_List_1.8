//
//  HikeView.swift
//  HelloAppStore_List_1.8
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

// 意図的なエラー: Viewプロトコルに準拠していない
// Type 'HikeView' does not conform to protocol 'View'
struct HikeView {
    var hike: Hike
    // 意図的なエラー: @Stateではなく通常のBoolを使用
    var showDetail = true

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
                        // showDetail.toggle() // @Stateでないため変更できない
                    }
                } label: {
                    Label("Graph", systemImage: "chevron.right.circle")
                        .labelStyle(.iconOnly)
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
                        .scaleEffect(showDetail ? 1.5 : 1)
                        .padding()
                }
                // 意図的なエラー: BoolをBinding<Bool>に変換できない
                // Cannot convert value of type 'Bool' to expected argument type 'Binding<Bool>'
                .sheet(isPresented: showDetail) {
                    Text("Detail Sheet")
                }
            }

            if showDetail {
                HikeDetail(hike: hike)
                    .transition(.moveAndFade)
            }
        }
    }
}

struct HikeDetail: View {
    var hike: Hike
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
        // 意図的なエラー: HikeViewはViewプロトコルに準拠していない
        HikeView(hike: hikes[0])
            .content
            .padding()
    }
}
