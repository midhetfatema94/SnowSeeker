//
//  Resort.swift
//  SnowSeeker
//
//  Created by Waveline Media on 1/24/21.
//

import Foundation

struct Resort: Codable, Identifiable, Comparable {
    
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
    
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
    
    static func < (lhs: Resort, rhs: Resort) -> Bool {
        return lhs.id < rhs.id
    }
}

class Resorts: ObservableObject {
    @Published private(set) var resorts: [Resort]
    
    enum filterBy { case all, country, size, price }
    
    enum sortBy { case general, alphabetical, country }
    
    var resortSizes: [String] = ["Small", "Average", "Large"]
    var resortPrices = [String]()
    var resortCountries = [String]()
    
    init() {
        self.resorts = []
        self.resorts = Bundle.main.decode("resorts.json")
        
        let prices = resorts.map { String(repeating: "$", count: $0.price) }
        let pricesSet = Set(prices)
        resortPrices = Array(pricesSet)
        
        let countries = resorts.map { $0.country }
        let countriesSet = Set(countries)
        resortCountries = Array(countriesSet)
    }
    
    func sortResorts(by: sortBy) {
        switch by {
        case .general:
            self.resorts = self.resorts.sorted()
        case .country:
            self.resorts = self.resorts.sorted { (lhs, rhs) -> Bool in
                lhs.country < rhs.country
            }
        case .alphabetical:
            self.resorts = self.resorts.sorted { (lhs, rhs) -> Bool in
                lhs.name < rhs.name
            }
        }
    }
    
    func filterResorts(by: filterBy, value: String) {
        objectWillChange.send()
        switch by {
        case .all:
            break
        case .country:
            self.resorts = self.resorts.filter { $0.country == value }
        case .price:
            self.resorts = self.resorts.filter { $0.price == value.count }
        case .size:
            var sizeInt = 0
            switch value.lowercased() {
            case "small":
                sizeInt = 1
            case "average":
                sizeInt = 2
            default:
                sizeInt = 3
            }
            self.resorts = self.resorts.filter { $0.size == sizeInt }
        }
    }
    
    func resetFilters() {
        self.resorts = Bundle.main.decode("resorts.json")
    }
}
