//
//  DetailsView.swift
//  CoffeshopFinder
//
//  Created by Dion Aditya on 19/11/22.
//

import SwiftUI

struct DetailsView: View {
    let coffeeshopDetail: Coffeeshop
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.pink, .orange, .yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack(alignment: .center) {
                Image(coffeeshopDetail.imageUrl)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 240)
                    .overlay(
                        Color.black
                            .opacity(0.5)
                            .overlay(
                                VStack{
                                    Image(systemName: "person.fill.badge.plus")
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                        .foregroundColor(.white)
                                        .scaledToFill()
                                    
                                    Text(coffeeshopDetail.name)
                                        .font(.title)
                                        .fontWeight(.heavy)
                                        .foregroundColor(.white)
                                }
                                
                            )
                    )
                    .cornerRadius(150)
                
                Spacer()
                Text(coffeeshopDetail.review)
                    .multilineTextAlignment(.center)
                    .padding(40)
                Spacer()
                HStack {
                    Image(systemName: "pin.circle.fill")
                    Text(coffeeshopDetail.location)
                }
                
                Spacer()
                
            } // VStack
        }
        
        
    }
}

struct CoffeShopDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(coffeeshopDetail: Coffeeshop(imageUrl: "imahkai", name: "test1", location: "string", review: "string", isFavorite: false))
    }
}
