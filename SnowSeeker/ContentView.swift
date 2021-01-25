//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Waveline Media on 1/22/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var favourites = Favourites()
    @ObservedObject var allResorts = Resorts()
    
    @State private var showingFilterPage = false
    
    var body: some View {
        NavigationView {
            List(allResorts.resorts) {resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    
                    if self.favourites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                        .accessibility(label: Text("This is a favorite resort"))
                        .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationBarItems(trailing: Button(action: {
                self.showingFilterPage = true
                allResorts.resetFilters()
            }, label: {
                Text("Sort & Filter")
            }))
            .sheet(isPresented: $showingFilterPage, content: {
                SortingView()
            })
            
            WelcomeView()
        }
        .environmentObject(favourites)
        .environmentObject(allResorts)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
