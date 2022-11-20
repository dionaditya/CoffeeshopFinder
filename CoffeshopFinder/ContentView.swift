//
//  ContentView.swift
//  CoffeshopFinder
//
//  Created by Dion Aditya on 18/11/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var searchText: String = ""
    
    private var coffeshopList: [Coffeeshop] {
        let results: [Coffeeshop] = CoffeshopProvider.all()
        if searchText.isEmpty {
            return results
        } else {
            return results.filter{
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    private var suggestedList: [Coffeeshop] {
        if searchText.isEmpty {
            return []
        } else {
            return coffeshopList
        }
    }
    
    var body: some View {
        NavigationStack {
            List(coffeshopList) { result in
                NavigationLink(
                    destination: CoffeShopDetailsView(coffeeshopDetail: result)
                ) {
                    HStack {
                        Image(result.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 130)
                            .cornerRadius(20)
                        
                        
                        VStack(alignment: .leading){
                            Text(result.name)
                                .font(.system(size: 20, design: .rounded))
                                .fontWeight(.bold)
                            
                            Spacer()
                    
                        
                            Text(result.location)
                                .lineLimit(2)
                                .font(.system(size: 14, design: .rounded))
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                                .truncationMode(.tail)
                            
                            Spacer()
                            
                            Text("Rating 4/15")
                                .font(.system(size: 12, design: .rounded))
                                .foregroundColor(.gray)
                            
                            Spacer()
                          
                        }.padding(5)
                    }
                }
         
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always)) {
                ForEach(suggestedList) { list in
                    Text("Looking for \(list.name)")
                        .searchCompletion(list.name)
                }
            }
            .navigationTitle("Coffeshop")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
