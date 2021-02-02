//
//  DateTimeView.swift
//  MAD2_Assignment
//
//  Created by Jamie on 30/1/21.
//

import SwiftUI

struct DateTimeView: View {
    @State private var selectedDate: BookingDate = BookingDate.default
    @State private var selectedHourIndex: Int = -1
    private let dates = Date.getFollowingThirtyDays()
    
    @Binding var date: BookingDate
    @Binding var hour: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30){
            createDateView()
            createTimeView()
        }
    }
    
    fileprivate func createTimeView() -> some View {
        VStack(alignment: .leading){
            Text("Time").font(.headline).padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(0..<24, id: \.self){i in
                        TimeView(index: i, isSelected: self.selectedHourIndex == i, onSelect: {selectedIndex in
                            self.selectedHourIndex = selectedIndex
                            self.hour = "\(selectedIndex):00"
                        })
                    }.padding(.horizontal)
                }
            }
        }
    }
    
    fileprivate func createDateView() -> some View {
        VStack(alignment: .leading){
            Text("Date")
                .font(.headline).padding(.leading)
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(dates, id: \.id){ date in
                        DateView(date: date, isSelected: self.selectedDate.day == date.day, onSelect: { selectedDate in
                            self.selectedDate = selectedDate
                            self.date = selectedDate
                        })
                    }
                }.padding(.horizontal)
            }
        }
    }
    
}

struct DateTimeView_Previews: PreviewProvider {
    static var previews: some View {
        DateTimeView(date: .constant(BookingDate.default), hour: .constant(""))
    }
}

