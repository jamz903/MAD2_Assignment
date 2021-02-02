//
//  DateExt.swift
//  MAD2_Assignment
//
//  Created by Jamie on 30/1/21.
//

import Foundation

extension Date {
    //property that returns the current year converted to an integer
    static var thisYear: Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let component = formatter.string(from: Date())
        
        if let value = Int(component){
            return value
        }
        return 0
    }
    
    //gets date & format and returns formatted date
    private static func getComponent(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale.autoupdatingCurrent
        let component = formatter.string(from: date)
        return component
    }
    
    //generates the next 30,31 or 28 days depending on the month to show the booking dates
    static func getFollowingThirtyDays(for month: Int = 1) -> [BookingDate] {
        var dates = [BookingDate]()
        let dateComponents = DateComponents(year: thisYear, month: month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        
        for i in range {
            guard let fullDate = calendar.date(byAdding: DateComponents(day: i), to: Date()) else { continue }
            let d = getComponent(date: fullDate, format: "dd")
            let m = getComponent(date: fullDate, format: "MM")
            let y = getComponent(date: fullDate, format: "yy")
            let bookingDate = BookingDate(id: i, day: d, month: m, year: y)
            dates.append(bookingDate)
            print(bookingDate)
        }
        
        return dates
    }
}
