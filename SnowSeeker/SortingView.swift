//
//  SortingView.swift
//  SnowSeeker
//
//  Created by Waveline Media on 1/25/21.
//

import SwiftUI

struct SortingView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var allResorts: Resorts
    
    @State private var sorting = ""
    @State private var filterCountry = ""
    @State private var filterPrice = ""
    @State private var filterSize = ""
    
    let sortingChoices = ["Default", "Alphabetically", "Countrywise"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Sort By", selection: $sorting) {
                        ForEach(sortingChoices, id: \.self) {sort in
                            Text(sort)
                        }
                    }
                }
                
                Section(header: Text("Filter By")) {
                    Picker("Country", selection: $filterCountry) {
                        ForEach(allResorts.resortCountries, id: \.self) {country in
                            Text(country)
                        }
                    }
                    
                    Picker("Size", selection: $filterSize) {
                        ForEach(allResorts.resortSizes, id: \.self) {size in
                            Text(size)
                        }
                    }
                    
                    Picker("Price", selection: $filterPrice) {
                        ForEach(allResorts.resortPrices, id: \.self) {price in
                            Text(price)
                        }
                    }
                }
            }
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Cancel")
            }), trailing: Button(action: {
                self.sortingDone()
                self.filterPicked()
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Save")
                    .fontWeight(.bold)
            }))
        }
    }
    
    func filterPicked() {
        if filterCountry.isEmpty == false {
            allResorts.filterResorts(by: .country, value: filterCountry)
        }
        if filterPrice.isEmpty == false {
            allResorts.filterResorts(by: .price, value: filterPrice)
        }
        if filterSize.isEmpty == false {
            allResorts.filterResorts(by: .size, value: filterSize)
        }
    }
    
    func sortingDone() {
        if sorting.isEmpty == false {
            switch sorting.lowercased() {
            case "alphabetically":
                allResorts.sortResorts(by: .alphabetical)
            case "countrywise":
                allResorts.sortResorts(by: .country)
            default:
                allResorts.sortResorts(by: .general)
            }
        }
    }
}

struct SortingView_Previews: PreviewProvider {
    static var previews: some View {
        SortingView()
    }
}
