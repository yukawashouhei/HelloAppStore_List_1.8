//
//  HikeGraph.swift
//  HelloAppStore_List_1.9
//
//

import SwiftUI

struct HikeGraph: View {
    var hike: Hike
    var path: KeyPath<Hike.Observation, Range<Double>>

    var color: Color {
        switch path {
        case \.elevation:
            return .gray
        case \.heartRate:
            return Color(hue: 0, saturation: 0.5, brightness: 0.7)
        case \.pace:
            return Color(hue: 0.7, saturation: 0.4, brightness: 0.7)
        default:
            return .black
        }
    }

    var body: some View {
        let data = hike.observations
        let overallRange = rangeOfRanges(data.lazy.map { $0[keyPath: path] })
        let maxMagnitude = data.map { magnitude(of: $0[keyPath: path]) }.max()!
        let heightRatio = 1 - CGFloat(maxMagnitude / magnitude(of: overallRange))

        GeometryReader { proxy in
            HStack(alignment: .bottom, spacing: proxy.size.width / 120) {
                ForEach(Array(data.enumerated()), id: \.offset) { index, observation in
                    GraphCapsule(
                        index: index,
                        height: proxy.size.height,
                        range: observation[keyPath: path],
                        overallRange: overallRange
                    )
                    .colorMultiply(color)
                }
                .offset(x: 0, y: proxy.size.height * heightRatio)
            }
        }
    }
}

func rangeOfRanges<C: Collection>(_ ranges: C) -> Range<Double>
where C.Element == Range<Double> {
    guard !ranges.isEmpty else { return 0..<0 }
    let low = ranges.lazy.map { $0.lowerBound }.min()!
    let high = ranges.lazy.map { $0.upperBound }.max()!
    return low..<high
}

func magnitude(of range: Range<Double>) -> Double {
    range.upperBound - range.lowerBound
}

#Preview {
    let hikes = loadHikes()
    return Group {
        HikeGraph(hike: hikes[0], path: \.elevation)
            .frame(height: 200)
        HikeGraph(hike: hikes[0], path: \.heartRate)
            .frame(height: 200)
        HikeGraph(hike: hikes[0], path: \.pace)
            .frame(height: 200)
    }
}
