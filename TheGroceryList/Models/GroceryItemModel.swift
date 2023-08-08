//
//  GroceryItemModel.swift
//  TheGroceryList
//
//  Created by Stefan Crigler on 5/11/23.
//

import Foundation

struct GroceryItem:Identifiable, Hashable, Codable{
    var id = UUID()
    var quantity: Int
    var name: String = ""
    var groupList: [String] = ["All Items"]
    var selected: Bool
    
    init( quantity:Int, name:String, groupList:[String], selected:Bool){
        self.quantity = quantity
        self.name = name
        self.groupList = ["All Items"] + groupList
        self.selected = selected
    }
}

struct GroceryList:Codable{
    var groceryList: [GroceryItem]
}

//class GroceryListClass:ObservableObject, Codable{
//    var listName:String
//    @Published var GroceryList:[GroceryItem] = []
//    init(name: String){
//        self.listName = name
//        self.GroceryList = []
//    }
//    private enum CodingKeys : String, CodingKey {
//            case name
//        }
//    func encode(to encoder: Encoder) throws {
//            var container = encoder.container(keyedBy: CodingKeys.self)
//            try container.encode(listName, forKey: .name)
//        }
//}
//
//func == (test1: GroceryItem, test2:GroceryItem) -> Bool {
//    return test1.name == test2.name
//}

var testGroceryItem = GroceryItem(quantity: 1, name: "test", groupList: [], selected: false)

var testGroceryList: [GroceryItem] = [
    GroceryItem(quantity: 1, name: "Frozen Pizza", groupList: ["Costco"], selected: false),
    GroceryItem(quantity: 1, name: "Frozen Chicken", groupList: ["Costco"], selected: false),
    GroceryItem(quantity: 2, name: "Sushi", groupList: ["Albertsons"], selected: false),
    GroceryItem(quantity: 3, name: "Steak", groupList: ["Costco"], selected: false),
    GroceryItem(quantity: 1, name: "Ketchup", groupList: ["Target"], selected: false),
    GroceryItem(quantity: 2, name: "Paper Towels", groupList: ["Target"], selected: false)
]

var GroceryListModel = GroceryList(groceryList: testGroceryList)
