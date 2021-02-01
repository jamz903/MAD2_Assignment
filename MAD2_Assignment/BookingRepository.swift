//
//  AddCalendarEventController.swift
//  MAD2_Assignment
//
//  Created by Jamie on 1/2/21.
//

import Foundation
import UIKit
import EventKit
import EventKitUI


class BookingRepository: ObservableObject {
    
    let eventStore = EKEventStore()
    
    //Add calendar event
    func addEvent(_ date : BookingDate, _ hour : String, _ seat : [Seat], _ location : BookingLocation) {
        eventStore.requestAccess(to: EKEntityType.event, completion: {(granted, error) in
            DispatchQueue.main.async {
                //if permission is granted to access calendar
                if (granted) && (error == nil) {
                    //check if details are passed through from previous view
                    print("Location: \(location)")
                    print("Selected Seats: \(seat)")
                    print("Date: \(date)")
                    print("Hour: \(hour)")
                    
                    let event = EKEvent(eventStore: self.eventStore)
                    //title of event
                    event.title = "Booking of Seat @\(location.name), \(location.block)"
                    
                    //format the date
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd-MM-yyyy HH:mm"
                    let datetime = formatter.date(from: "\(date.day)/\(date.month)/20\(date.year) \(hour)")
                    
                    //set event starting/ending date & time
                    event.startDate = datetime
                    event.endDate = datetime!.addingTimeInterval(1 * 60 * 60)
                    
                    //adding seats booked in notes of calendar event
                    var notes = ""
                    for i in seat {
                        notes += "Row: \(i.row), Number: \(i.number)\n"
                    }
                    event.notes = "Seats Booked: \n\(notes)"
                    
                    //set event to be stored in default calendar
                    event.calendar = self.eventStore.defaultCalendarForNewEvents
                    
                    //set alarm to remind user of booking 15 mins before timeslot
                    let alarm = EKAlarm(relativeOffset: -900)
                    event.alarms = [alarm]
                    
                    do {
                        //save event in calendar
                        try self.eventStore.save(event, span: .thisEvent)
                    }
                    catch {
                        print("Error saving event in calendar")
                    }
                    
                }
            }
        })
    }
    
}
