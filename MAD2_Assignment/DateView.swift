//
//  DateView.swift
//  MAD2_Assignment
//
//  Created by Jamie on 30/1/21.
//

import SwiftUI

struct DateView: View {
    var date: BookingDate = BookingDate(id: 0, day: "30", month: "1", year: "21")
    var isSelected: Bool
    var onSelect: ((BookingDate) -> ()) = {_ in }
    
    var body: some View {
        VStack {
            Text("\(date.day)")
                .font(.title)
                .bold()
                .foregroundColor(isSelected ? .white : .black)
            
            Text("\(date.month)/\(date.year)")
                .foregroundColor(isSelected ? .white : .black)
                .font(.callout)
                .padding(.top, 10)
            
        }.padding()
        .background(isSelected ? Color.blue: Color.gray.opacity(0.3))
        .clipShape(DateShape())
        .cornerRadius(10)
        .onTapGesture {
            self.onSelect(self.date)
        }
    }
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        DateView(isSelected: false)
    }
}
