//
//  BookingView.swift
//  MAD2_Assignment
//
//  Created by Jamie on 28/1/21.
//

import Foundation
import SwiftUI

//Custom Text Label to Overlay on 'Featured' Image
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
    }
}

//Booking View
struct BookingView: View {
    @ObservedObject var modelData = ModelData()
    
    var body: some View {
        List {
            //shows the featured location
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
            
            //shows a compositional layout by various locations
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

//loading wheel
//not in use
struct Loader : View {
    @State var animate = false
    
    var body: some View {
        VStack {
            Circle()
                .trim(from: 0, to: 0.8)
                .stroke(AngularGradient(gradient: .init(colors: [.orange,.red]), center: .center), style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .frame(width: 45, height: 45)
                .rotationEffect(.init(degrees: self.animate ? 360 : 0))
                .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false))
        }
        .onAppear {
            self.animate.toggle()
        }
    }
}
