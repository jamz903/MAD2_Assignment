//
//  OkView.swift
//  MAD2_Assignment
//
//  Created by MAD2_P01 on 1/2/21.
//

import Foundation
import SwiftUI

struct OkView: View {
    var width: CGFloat = 30
    var lineWidth: CGFloat = 7
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var body: some View {
          OkShape()
            .stroke(style: StrokeStyle(lineWidth: self.lineWidth, lineCap: .round,lineJoin: .round))
            .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple]) , startPoint: .leading, endPoint: .trailing))
            .frame(width: self.width, height: self.width * 2).rotationEffect(Angle(degrees: 45) )
            .animation(.easeInOut(duration: 10))
        Text("Booking Succesful")
            .fontWeight(.semibold)
            .font(.system(size: 20))
            .padding(.top, 10)
        
        BookingButton(text: "Done", action: {self.mode.wrappedValue.dismiss()})
            .padding()
            .padding(.top, 10)
    }
}

struct OkView_Previews: PreviewProvider {
    static var previews: some View {
        OkView()
    }
}
