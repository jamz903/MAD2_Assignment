//
//  TimeView.swift
//  MAD2_Assignment
//
//  Created by Jamie on 30/1/21.
//

import SwiftUI

struct TimeView: View {
    
    var index: Int
    var isSelected: Bool
    var onSelect: ((Int)->()) = {_ in }

    var body: some View {
        Text("\(index):00")
            .foregroundColor(isSelected ? .white : .black)
            .padding()
            .background( isSelected ? Color.blue : Color.gray.opacity(0.3))
            .cornerRadius(10).onTapGesture {
                self.onSelect(self.index)
                
            }
    }
}
