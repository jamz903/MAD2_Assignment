//
//  TicketDate.swift
//  MAD2_Assignment
//
//  Created by Jamie on 30/1/21.
//

import Foundation

struct BookingDate: Equatable {
    var day: String
    var month: String
    var year: String
    
    static var `default`: BookingDate { BookingDate(day: "", month: "", year: "") }
}
