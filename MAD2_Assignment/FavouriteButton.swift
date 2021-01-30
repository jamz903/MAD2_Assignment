//
//  FavouriteButton.swift
//  MAD2_Assignment
//
//  Created by MAD2_P01 on 30/1/21.
//

import Foundation
import SwiftUI

struct FavoriteButton: View {
    @Binding var isSet: Bool

    var body: some View {
        Button(action: {
            isSet.toggle()
        }) {
            Image(systemName: isSet ? "star.fill" : "star")
                .foregroundColor(isSet ? Color.yellow : Color.gray)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: .constant(true))
    }
}
