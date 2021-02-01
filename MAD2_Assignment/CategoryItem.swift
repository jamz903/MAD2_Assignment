//
//  CategoryItem.swift
//  MAD2_Assignment
//
//  Created by Jamie on 29/1/21.
//

import Foundation
import SwiftUI

struct CategoryItem: View {
    var location: BookingLocation
    
    var body: some View {
        VStack(alignment: .leading) {
            location.image
                .renderingMode(.original)
                .resizable()
                .frame(width: 300, height: 200)
                .cornerRadius(5)
            Text(location.name)
                //.font(.caption)
                .font(.system(size: 15))
                .foregroundColor(.primary)
        }
        .padding(.leading, 15)
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(location: ModelData().locations[0])
    }
}

