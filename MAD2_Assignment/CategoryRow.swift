//
//  CategoryRow.swift
//  MAD2_Assignment
//
//  Created by MAD2_P01 on 29/1/21.
//

import Foundation
import SwiftUI

struct CategoryRow: View {
    var categoryName: String
    var items: [BookingLocation]
    
    var body: some View {
        VStack(alignment: .leading){
            Text(categoryName)
                //.font(.headline)
                .font(.system(size: 20, weight: .bold))
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 10) {
                    ForEach(items) { location in
                        CategoryItem(location: location)
                        
                    }
                }
            }
        }
        .frame(height: 285)
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var locations = ModelData().locations
    
    static var previews: some View {
        CategoryRow(categoryName: locations[0].category.rawValue, items: Array(locations.prefix(4)))
    }
}
