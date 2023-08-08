//
//  DatabaseModel.swift
//  TheGroceryList
//
//  Created by Stefan Crigler on 5/18/23.
//

import Foundation
import SwiftUI

struct DatabaseModel: Codable {
    var id = UUID()
    var userGroups: [String]
    var userItems: GroceryList
    var selectedGroups: [String]
}
