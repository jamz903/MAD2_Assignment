//
//  ModelData.swift
//  MAD2_Assignment
//
//  Created by Jamie on 29/1/21.
//

import Foundation
import Combine

final class ModelData: ObservableObject {
    @Published var locations: [BookingLocation] = load("bookingLocation.json")
    
    var features: [BookingLocation] {
        locations.filter { $0.isFeatured }
    }
    
    var categories: [String: [BookingLocation]] {
        Dictionary(
            grouping: locations,
            by: { $0.category.rawValue }
        )
    }
}

//loads data from json file
func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else{
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
