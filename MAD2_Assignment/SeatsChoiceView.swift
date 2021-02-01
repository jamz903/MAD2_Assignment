//
//  SeatsChoiceView.swift
//  MAD2_Assignment
//
//  Created by Jamie on 30/1/21.
//

import Foundation
import SwiftUI

struct SeatsChoiceView: View {
    
    @ObservedObject var modelData = ModelData()
    var location: BookingLocation
    @State var selectedSeats: [Seat]
    @State var showOk: Bool = false
    @State var date: BookingDate = BookingDate.default
    @State var hour: String = ""
    @State var showPopup = false
    
    var locationIndex: Int {
        modelData.locations.firstIndex(where: { $0.id == location.id })!
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    LocationView(selectedSeats: self.$selectedSeats).padding(.top, 20)
                        .padding(.bottom, 8)
                    DateTimeView(date: self.$date, hour: self.$hour)
                    BookingButton(text: "Continue", action: {
                        self.showOk = self.validateInputs()
                        withAnimation {
                            self.showPopup = !self.validateInputs()
                        }
                    }).sheet(isPresented: self.$showOk) {
                        //moves on to Booking successful view
                        OkView(location: self.location, selectedSeats: self.$selectedSeats, date: self.$date, hour: self.$hour)
                        
                    }.padding()
                    
                }.navigationBarTitle("Choose Seats", displayMode: .large)
                .frame(maxHeight: .infinity)
                .accentColor(Color.gray)
            }
            .navigationTitle("Book Seats: \(location.name)")
            
        }.blur(radius: self.showPopup ? 10 : 0).overlay(
            VStack{
                if self.showPopup {
                    self.createPopupContent()
                } else {
                    EmptyView()
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background( self.showPopup ? Color.white.opacity(0.3) : .clear)
        )
    }
    
    //validation pop-up to prompt user to select required elements
    fileprivate func createPopupContent() -> some View {
        VStack {
            Text("Not allowed").font(.system(size: 20, weight: Font.Weight.semibold))
            Text("You need to select at least one seat, a date and hour in order to continue.")
                .multilineTextAlignment(.center).frame(maxHeight: .infinity)
            BookingButton(text: "Ok") {
                withAnimation {
                    self.showPopup.toggle()
                }
            }
        }.frame(width: UIScreen.main.bounds.width * 0.8, height: 200, alignment: .bottom)
            .padding()
            .background(Color.white.opacity(0.7))
            .cornerRadius(20)
            .shadow(color: Color.gray.opacity(0.3), radius: 20, x: 0, y: 10)
            .transition(.move(edge: .bottom))
    }
    
    //checks if at least 1 seat, date & time is selected
    fileprivate func validateInputs() -> Bool {
        self.selectedSeats.count > 0
            && self.date != BookingDate.default
            && !self.hour.isEmpty
    }
}
