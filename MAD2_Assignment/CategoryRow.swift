//
//  CategoryRow.swift
//  MAD2_Assignment
//
//  Created by Jamie on 29/1/21.
//

import Foundation
import SwiftUI

//custom view of how a row of locations will look like
struct CategoryRow: View {
    var categoryName: String
    var items: [BookingLocation]
    
    var body: some View {
        VStack(alignment: .leading){
            //header
            Text(categoryName)
                .font(.system(size: 20, weight: .bold))
                .padding(.leading, 15)
                .padding(.top, 5)
            
            //scrollable
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 10) {
                    ForEach(items) { location in
                        //links it to location detail where they can view more details of the location & also make bookings
                        NavigationLink(destination: LocationDetail(location: location)) {
                            CategoryItem(location: location)
                        }
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
