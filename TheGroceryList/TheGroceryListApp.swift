//
//  TheGroceryListApp.swift
//  TheGroceryList
//
//  Created by Stefan Crigler on 5/11/23.
//

import SwiftUI

@main
struct TheGroceryListApp: App {
    @StateObject private var store = DataStorage()
    var body: some Scene {
        WindowGroup {
            ContentView(userList: $store.UserData.userItems, masterGroupList: $store.UserData.userGroups, selectedGroups: $store.UserData.selectedGroups){
                Task {
                    do {
                        try await store.save(Data: DatabaseModel(userGroups: store.UserData.userGroups, userItems: store.UserData.userItems, selectedGroups: store.UserData.selectedGroups))
                    } catch{
                        print(error)
                        fatalError(error.localizedDescription)
                    }
                }
            }
                .task {
                    do {
                        try await store.load()
                    } catch{
                        print(error)
                        fatalError(error.localizedDescription)
                    }
                }
        }
    }
}
