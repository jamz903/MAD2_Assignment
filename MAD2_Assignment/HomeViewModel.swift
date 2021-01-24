//
//  HomeViewModel.swift
//  MAD2_Assignment
//
//  Created by MAD2_P01 on 24/1/21.
//

import Foundation
import SwiftUI

enum HomeSection: String, CaseIterable {
    case Booking
}

class BookingViewModel: ObservableObject {
    @Published var allItems : [HomeSection:[Codable]] = [:]
    
    init() {
        getAll()
    }
    
    private func getAll() {
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let url = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let result = try decoder.decode(HomeBundle.self, from: data)
                allItems = [HomeSection.Booking: result.booking]
            } catch let e {
                print(e)
            }
        }
    }
}
