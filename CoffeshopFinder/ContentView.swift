//
//  ContentView.swift
//  CoffeshopFinder
//
//  Created by Dion Aditya on 18/11/22.
//

import SwiftUI

enum Tabs: String {
  case browse, watch, loans, profile
}

struct ContentView: View {
    // MARK: - PROPERTIES
    // @State private var selection: Int = 0
    @State var searchText: String = ""
    @State private var selectedTab: Tabs = .browse
    
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
            TabView(selection: $selectedTab) {
               CoffeeshopListView(coffeeshopList: coffeshopList)
                .listStyle(.plain)
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                        Text("Browse")
                            }
                .tag(Tabs.browse)
                
                
                Text("Play")
                    .tabItem {
                        Image(systemName: "play.rectangle.fill")
                            Text("Browse")
                                }
                    .tag(Tabs.watch)
                
                Text("Loans")
                    .tabItem {
                        Image(systemName: "rectangle.and.text.magnifyingglass")
                            Text("Browse")
                                }
                    .tag(Tabs.watch)
                
                Text("Profile")
                    .tabItem {
                        Image(systemName: "person.fill")
                            Text("Profile")
                                }
                    .tag(Tabs.watch)
                
                
            } // TabView
                .navigationTitle("\(selectedTab.rawValue.capitalized)")
                .tint(.purple)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
