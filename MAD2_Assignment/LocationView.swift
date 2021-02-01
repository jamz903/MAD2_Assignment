//
//  LocationView.swift
//  MAD2_Assignment
//
//  Created by Jamie on 30/1/21.
//

import Foundation
import SwiftUI

struct LocationView: View {
    @Binding var selectedSeats:[Seat]
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(height: 420)
                    .cornerRadius(20)
                
                VStack {
                    createRow()
                }
                
            }
            createSeatsLegend()
                .frame(maxWidth: .infinity)
        }
        
    }
    
    fileprivate func createRow() -> some View {
        let numberOfRows: Int = 3
        let numbersPerRow: Int = 5
        
        return
            VStack {
                ForEach(0..<numberOfRows, id: \.self) { rowNum in
                    HStack {
                        TableView()
                    }
                    HStack {
                        ForEach(0..<numbersPerRow, id: \.self) { number in
                            ChairView(width: 30, accentColor: .blue, seat: Seat(id: UUID(), row: rowNum+1, number: number+1), onSelect: { seat in
                                self.selectedSeats.append(seat)
                            }, onDeselect: {seat in
                                self.selectedSeats.removeAll(where: {$0.id == seat.id})
                            })
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
    }
    
    fileprivate func createSeatsLegend() -> some View {
        HStack {
            ChairLegend(text: "Selected", color: .blue)
            ChairLegend(text: "Reserved", color: .purple)
            ChairLegend(text: "Available", color: .gray)
        }.padding(.horizontal, 3).padding(.top)
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(selectedSeats: .constant([]))
    }
}
