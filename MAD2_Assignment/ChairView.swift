//
//  ChairView.swift
//  MAD2_Assignment
//
//  Created by MAD2_P01 on 30/1/21.
//

import Foundation
import SwiftUI

struct ChairView: View {
    var width: CGFloat = 60
    var accentColor: Color = .blue
    var seat = Seat.default
    
    @State var isSelected = false
    var isSelectable = true
    var onSelect: ((Seat)->()) = {_ in }
    var onDeselect: ((Seat)->()) = {_ in }
    
    var body: some View {
        VStack(spacing: 2){
            Rectangle()
                .frame(width: self.width, height: self.width * 2/3)
                .foregroundColor(isSelectable ? isSelected ? accentColor : Color.gray.opacity(0.5) : accentColor)
                .cornerRadius(width / 5)
            
            Rectangle()
                .frame(width: width - 10, height: width / 5)
                .foregroundColor(isSelectable ? isSelected ? accentColor : Color.gray.opacity(0.5) : accentColor)
                .cornerRadius(width / 5)
        }
        .padding(.leading, 15)
        .padding(.trailing, 15)
        .onTapGesture {
            if self.isSelectable {
                self.isSelected.toggle()
                if self.isSelected {
                    self.onSelect(self.seat)
                }
                else{
                    self.onDeselect(self.seat)
                }
            }
        }
    }
}

struct ChairView_Previews: PreviewProvider {
    static var previews: some View {
        ChairView()
    }
}
