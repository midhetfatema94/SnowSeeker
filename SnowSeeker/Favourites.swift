//
//  Favourites.swift
//  SnowSeeker
//
//  Created by Waveline Media on 1/25/21.
//

import SwiftUI

class Favourites: ObservableObject {
    private var resorts: Set<String>
    
    private let saveKey = "Favourites"
    
    init() {
        //load our saved data
        self.resorts = []
        
        self.load()
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
            let resortIds = Array(self.resorts)
            let data = try JSONEncoder().encode(resortIds)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            print("Resort data saved")
        } catch {
            print("Unable to save data.")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    func load() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
        do {
            let data = try Data(contentsOf: filename)
            let resortIds = try JSONDecoder().decode([String].self, from: data)
            resorts = Set(resortIds)
        } catch {
            print("Unable to load saved data.")
        }
    }
}
