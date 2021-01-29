//
//  BookingLocation.swift
//  MAD2_Assignment
//
//  Created by MAD2_P01 on 28/1/21.
//

import Foundation
import SwiftUI
import CoreLocation

struct BookingLocation: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var block: String
    var description: String
    var isFavorite: Bool
    var isFeatured: Bool
    
    var category: Category
    enum Category: String, CaseIterable, Codable {
        case study = "Study"
        case chill = "Chill"
        case eat = "Eat"
    }
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
    
}
