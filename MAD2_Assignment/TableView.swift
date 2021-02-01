//
//  TableView.swift
//  MAD2_Assignment
//
//  Created by Jamie on 30/1/21.
//

import Foundation
import SwiftUI

struct TableView: View {
    var width: CGFloat = 50
    
    var body: some View {
        Rectangle()
            .frame(width: self.width * 7, height: self.width * 3/2)
            .cornerRadius(width / 5)
            .foregroundColor(Color.black.opacity(0.5))
    }
}

struct TableView_Previews: PreviewProvider {
    static var previews: some View {
        TableView()
    }
}
