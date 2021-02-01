//
//  OkView.swift
//  MAD2_Assignment
//
//  Created by Jamie on 1/2/21.
//

import Foundation
import SwiftUI

struct OkView: View {
    var width: CGFloat = 30
    var lineWidth: CGFloat = 7
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.showingSheet) var showingSheet
    
    @ObservedObject var bookingRepository = BookingRepository()
    @ObservedObject var modelData = ModelData()
    var location: BookingLocation
    @Binding var selectedSeats: [Seat]
    @Binding var date: BookingDate
    @Binding var hour: String
    @State var showPopup = false
    
    var body: some View {
          OkShape()
            .stroke(style: StrokeStyle(lineWidth: self.lineWidth, lineCap: .round,lineJoin: .round))
            .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple]) , startPoint: .leading, endPoint: .trailing))
            .frame(width: self.width, height: self.width * 2).rotationEffect(Angle(degrees: 45) )
            .animation(.easeIn)
        Text("Booking Succesful")
            .fontWeight(.semibold)
            .font(.system(size: 20))
            .padding(.top, 30)
        
        BookingButton(text: "Done", action: {
            bookingRepository.addEvent(date, hour, selectedSeats, location)
            self.mode.wrappedValue.dismiss()
            self.showingSheet?.wrappedValue = false
        })
            .padding()
            .padding(.top, 10)
    }
}

//struct OkView_Previews: PreviewProvider {
//    static var previews: some View {
//        OkView()
//    }
//}
