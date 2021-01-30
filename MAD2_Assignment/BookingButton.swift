//
//  File.swift
//  MAD2_Assignment
//
//  Created by MAD2_P01 on 30/1/21.
//

import Foundation
import SwiftUI

struct BookingButton: View {
    var text = "Book Seats"
    var action = {}
    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            HStack {
                Text(text)
                    .font(.system(size: 20, weight: Font.Weight.semibold))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.vertical)
                    .accentColor(Color.white)
                    .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]) , startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
            }
        }.padding(.vertical)
    }
}

struct BookingButton_Previews: PreviewProvider {
    static var previews: some View {
        BookingButton()
    }
}
