//
//  HomeBundle.swift
//  MAD2_Assignment
//
//  Created by MAD2_P01 on 24/1/21.
//

import Foundation
import SwiftUI

struct HomeBundle: Codable, Hashable {
    let booking: [Booking]
}

protocol Location: Codable, Hashable {
    var id: Int { get }
    var title: String { get }
    var timeDesc: String { get }
    var description: String { get }
    var image: String { get }
    var rating: Double { get }
    var genres: [String] { get }
    var runtime: String { get }
}

struct Booking: Location {
    let id: Int
    let title, timeDesc, description, image: String
    let rating: Double
    let genres: [String]
    let runtime: String
    var studio: String? = ""
    
    static var `default`: Booking{
        .init(id: 0, title: "", timeDesc: "", description: "", image: "", rating: 0, genres: [], runtime: "")
    }
}
