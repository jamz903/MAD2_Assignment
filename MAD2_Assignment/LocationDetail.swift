//
//  LocationDetail.swift
//  MAD2_Assignment
//
//  Created by MAD2_P01 on 30/1/21.
//

import Foundation
import SwiftUI

struct LocationDetail: View {
    @ObservedObject var modelData = ModelData()
    var location: BookingLocation
    @State private var showSeats: Bool = false

    var locationIndex: Int {
        modelData.locations.firstIndex(where: { $0.id == location.id })!
    }

    var body: some View {
        ScrollView {
            CircleImage(image: location.image
                            .resizable())
                .offset(y: -130)
                .padding(.top, 150)
                .padding(.bottom, -130)
                .frame(height: 300)

            VStack(alignment: .leading) {
                HStack {
                    Text(location.name)
                        .font(.title)
                    FavoriteButton(isSet: $modelData.locations[locationIndex].isFavorite)
                }

                HStack {
                    Text(location.block)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

                Divider()
                Text("About \(location.name)")
                    .font(.title2)
                    .padding(.bottom, 10)
                Text(location.description)
            }
            .padding()
            
            HStack {
                BookingButton(){
                    self.showSeats.toggle()
                }.sheet(isPresented: self.$showSeats) {
                    SeatsChoiceView(location: self.location, selectedSeats: [])
                }
                .padding()
            }
        }
        .navigationTitle(location.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LocationDetail_Previews: PreviewProvider {
    static let modelData = ModelData()

    static var previews: some View {
        LocationDetail(location: modelData.locations[0])
            .environmentObject(modelData)
    }
}
