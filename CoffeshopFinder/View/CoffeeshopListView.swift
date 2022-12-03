//
//  CoffeeshopListView.swift
//  CoffeshopFinder
//
//  Created by Dion Aditya on 3/12/22.
//

import SwiftUI
import CachedAsyncImage
import ActivityView

struct CoffeeshopListView: View {
    // MARK: - Propertites
    @State var coffeeshopList: [Coffeeshop]
    @State private var isLoading: Bool = true
    
    // MARK: - Body
    var body: some View {
        List {
            ForEach(coffeeshopList) { result in
                ZStack(alignment: .leading) {
                    NavigationLink(destination: DetailsView(coffeeshopDetail: result)) {
                        EmptyView()
                    }
                    .opacity(0)
                    
                    ListRow(result: result)
                    
                } //: ZSTACK
            }
            .onDelete { indexSet in
                coffeeshopList.remove(atOffsets: indexSet)
            }
            .redacted(reason: isLoading ? .placeholder : [])
            .onAppear {
                fetchData()
            }
            .listRowSeparator(.hidden)
            
        }
        
    }
    
    // MARK: - FUNCTIONS
    
    func fetchData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
        }
    }
}

// MARK: - Preview
struct CoffeeshopListView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeshopListView(coffeeshopList: [Coffeeshop(imageUrl: "bojaeatery", name: "test", location: "bandung", review: "test", isFavorite: true)])
            .listStyle(.plain)
    }
}

// MARK: - ListRow
struct ListRow: View {
    @State var result: Coffeeshop
    @State private var item: ActivityItem?
    @State private var showAlert: Bool = false
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            let url = URL(string: result.imageUrl)
            
            CachedAsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFill()
                
            } placeholder: {
                Color.gray.opacity(0.1)
            }
            .frame(width: 120, height: 120)
            .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 0){
                HStack {
                    Text(result.name)
                        .font(.system(size: 20, design: .rounded))
                        .fontWeight(.bold)
                    
                }
                
                Text(result.location)
                    .lineLimit(2)
                    .font(.system(size: 14, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                    .truncationMode(.tail)
                    .padding(.vertical)
                
                
                Text("Rating 4/15")
                    .font(.system(size: 12, design: .rounded))
                    .foregroundColor(.gray)
                
                
                if result.isFavorite {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.yellow)
                        .padding(.vertical)
                }
                
            } // VStack
            .padding(5)
        } // HStack
        .swipeActions(edge: .leading, allowsFullSwipe: false) {
            Button {
                showAlert = true
            } label: {
                Image(systemName: "pin")
            }
            .tint(.yellow)
            
            
            Button {
                item = ActivityItem(items: "Article with title: \(result.name) will be shared!!!")
            } label: {
                Image(systemName: "square.and.arrow.up")
            }
            .tint(.indigo)
        }
        .alert("Not yet available", isPresented: $showAlert, actions: {
            // Any view other than Button would be ignored
            Button {
                
            } label: {
                Text("🆗 Buddy 👌")
            }
        }, message: {
            // Any view other than Text would be ignored
            Text("This feature is not available yet 🙏🏻")
        })
        .contextMenu {
            Button {
                item = ActivityItem(items: "Article with title: \(result.name) will be shared!!!")
            } label: {
                HStack {
                    Text("Share articles")
                    Image(systemName: "square.and.arrow.up")
                }
            }
            
            Button {
                result.isFavorite = !result.isFavorite
            } label: {
                Text(result.isFavorite ? "Remove from favorite" : "Mark as favorite")
                
                if result.isFavorite {
                    Image(systemName: "heart.slash") //
                } else {
                    Image(systemName: "heart") //
                }
                
            }
        }
        .activitySheet($item)
        
    }
}
