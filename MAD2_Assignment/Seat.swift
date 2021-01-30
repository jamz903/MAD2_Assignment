//
//  Seat.swift
//  MAD2_Assignment
//
//  Created by MAD2_P01 on 30/1/21.
//

import Foundation
import SwiftUI

struct Seat: Identifiable {
    var id: UUID
    var row: Int
    var number: Int
    
    static var `default`: Seat { Seat(id: UUID(), row: 0, number: 0)}
}
