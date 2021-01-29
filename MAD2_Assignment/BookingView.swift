//
//  BookingView.swift
//  MAD2_Assignment
//
//  Created by MAD2_P01 on 28/1/21.
//

import Foundation
import SwiftUI

struct ImageOverlay: View {
    @ObservedObject var modelData = ModelData()
    var body: some View {
        ZStack {
            Text("Featured: \(modelData.features[0].name)")
                .font(.callout)
                .font(.system(size: 30))
                .padding(6)
                .foregroundColor(.white)
        }.background(Color.black)
        .opacity(0.8)
        .cornerRadius(10)
        .padding(8)
        //.padding(.bottom, 8)
    }
}


struct BookingView: View {
    //@EnvironmentObject var modelData: ModelData
    @ObservedObject var modelData = ModelData()
    
    var body: some View {
        Text("Make A Booking").fontWeight(.bold).font(.largeTitle)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, CGFloat(15))
            .padding(.top)
            //.padding(.bottom, CGFloat(15))
        List {
            modelData.features[0].image
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
                .listRowInsets(EdgeInsets())
                //.padding(.bottom, CGFloat(20))
                .cornerRadius(5)
                .overlay(ImageOverlay(), alignment: .bottomLeading)
                .padding(.leading, 5)
                .padding(.trailing, 5)
                .padding(.bottom, 8)
            
            ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                CategoryRow(categoryName: key, items: modelData.categories[key]!)
            }
            .listRowInsets(EdgeInsets())
            
        }
    }
}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
            .environmentObject(ModelData())
    }
}
