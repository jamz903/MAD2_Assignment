//
//  SeatsChoiceView.swift
//  MAD2_Assignment
//
//  Created by MAD2_P01 on 30/1/21.
//

import Foundation
import SwiftUI

struct SeatsChoiceView: View {
    
    @ObservedObject var modelData = ModelData()
    var location: BookingLocation
    @State var selectedSeats: [Seat]
    @State var showBasket: Bool = false
    @State var date: BookingDate = BookingDate.default
    @State var hour: String = ""
    @State var showPopup = false
    
    var locationIndex: Int {
        modelData.locations.firstIndex(where: { $0.id == location.id })!
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                LocationView(selectedSeats: self.$selectedSeats).padding(.top, 20)
                    .padding(.bottom, 8)
                DateTimeView(date: self.$date, hour: self.$hour)
                BookingButton(text: "Continue", action: {}).padding()
            }.navigationBarTitle("Choose Seats", displayMode: .large)
            .frame(maxHeight: .infinity)
            .accentColor(Color.gray)
        }
        .navigationTitle("Book Seats: \(location.name)")
    }
}
