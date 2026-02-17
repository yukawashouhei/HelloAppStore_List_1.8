//
//  Landmark.swift
//  HelloAppStore_List_1.9
//
//

import Foundation
import SwiftUI
import UIKit

struct Coordinates: Hashable, Codable {
    var latitude: Double
    var longitude: Double
}

struct Landmark: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String
    var imageName: String
    var coordinates: Coordinates
    
    var image: Image {
        if let _ = UIImage(named: imageName) {
            return Image(imageName)
        } else {
            return Image(systemName: "photo")
        }
    }
}

func loadLandmarks() -> [Landmark] {
    guard let url = Bundle.main.url(forResource: "landmarkData", withExtension: "json"),
          let data = try? Data(contentsOf: url) else {
        return []
    }
    
    let decoder = JSONDecoder()
    return (try? decoder.decode([Landmark].self, from: data)) ?? []
}

let landmarks: [Landmark] = loadLandmarks()
