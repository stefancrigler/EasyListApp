//
//  StorageModel.swift
//  TheGroceryList
//
//  Created by Stefan Crigler on 5/18/23.
//

import Foundation
import SwiftUI
@MainActor
class DataStorage: ObservableObject {
    @Published var UserData: DatabaseModel =  DatabaseModel(userGroups: [], userItems: GroceryList(groceryList: []), selectedGroups: ["All Items"])
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("groceryList.data")
    }
    func load() async throws {
        let task = Task<DatabaseModel, Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return DatabaseModel(userGroups: [], userItems: GroceryList(groceryList: []), selectedGroups: ["All Items"])
            }
            let SavedData = try JSONDecoder().decode(DatabaseModel.self, from: data)
            return SavedData
        }
        let userdata = try await task.value
        self.UserData = userdata
    }
    
    func save(Data: DatabaseModel) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(Data)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
