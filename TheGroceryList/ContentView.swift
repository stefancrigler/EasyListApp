//
//  ContentView.swift
//  TheGroceryList
//
//  Created by Stefan Crigler on 5/11/23.
//

import SwiftUI

struct ContentView: View {
    // Item Related Variables
    @Binding var userList:GroceryList
    @State private var itemAdded:Bool = false
    @State var quickAddPresented: Bool = false
    @State private var showItemEdit: Bool = false
    @State private var editItemIndex: Int? = 0
    @State private var tempItemName: String = ""
    
    // Group Related Variables
    @Binding var masterGroupList:[String]
    @Binding var selectedGroups: [String]
    @State private var showGroupList: Bool = false
    @State var quickAddGroupText: String = ""
    @State var quickAddGroupPresented: Bool = false
    @State var filteredList: [GroceryItem] = []
    
    //
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: () -> Void
    @State private var searchText: String = ""
    @State var quickAddText: String = ""
    @State private var selectedSort: Bool = false
    
    func searchResults(in grocery: String) -> Bool {
        if searchText.isEmpty {
            return true
        }
        else{
            if grocery.contains(searchText) {
                return true
            }
        }
        return false
    }
    
    
    func isSubset(smallerList:[String], largerList:[String]) -> Bool {
        for item in smallerList{
            if !largerList.contains(item){
                return false
            }
        }
        return true
    }
    
    var body: some View {
        TabView{
            VStack {
                HStack{
                    SearchBarView(text: $searchText)
                        .padding(.top, -15)
                    Button{
                        quickAddPresented = true
                    }label:{
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .offset(x: -5.0, y: -5.0)
                            .frame(width: 23, height: 23)
                    }
                    Button{
                        if userList.groceryList.filter({ searchResults(in: $0.name)}).filter({$0.selected == true}) != [] || selectedSort != false{
                            selectedSort.toggle()
                        }//Currently no real indication that list is empty, try adding a popup of some kind if checked list is empty
                    }label:{
                        if selectedSort{
                            Image(systemName:"checklist")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color(.red))
                                .offset(x: -5.0, y: -5.0)
                                .frame(width: 23, height: 23)
                        }else{
                            Image(systemName:"checklist")
                                .resizable()
                                .scaledToFit()
                                .offset(x: -5.0, y: -5.0)
                                .frame(width: 23, height: 23)
                        }
                    }
                    .padding(.horizontal)
                }
                .alert("Quick Add Item", isPresented: $quickAddPresented){
                    TextField("Your New Grocery Item...", text: $quickAddText)
                    Button("Cancel", role:.cancel){}
                    Button("Add"){
                        userList.groceryList.append(GroceryItem(quantity: 1, name: quickAddText, groupList: [], selected: false))
                        
                        quickAddText = ""
                    }
                }
                .alert("Quick Add Group", isPresented: $quickAddGroupPresented){
                    TextField("Your New Grocery Item...", text: $quickAddGroupText)
                    Button("Cancel", role:.cancel){}
                    Button("Add"){
                        if !masterGroupList.contains(quickAddGroupText){
                            masterGroupList.append(quickAddGroupText)
                        }
                        quickAddGroupText = ""
                    }
                }
                GroupBarView(showGroupList: $showGroupList, selectedGroups: $selectedGroups, quickAddGroupPresented: $quickAddGroupPresented, masterGroupList: $masterGroupList)
                NavigationStack{
                    if userList.groceryList != [] {
                        if selectedSort {
                            List {
                                ForEach(userList.groceryList.filter({ searchResults(in: $0.name)}).filter({$0.selected == true && isSubset(smallerList: selectedGroups, largerList: $0.groupList)})){
                                    groceryItem in
                                    GroceryItemView(groceryList: $userList, groceryItem: groceryItem, isSelected: groceryItem.selected)
                                        .swipeActions(edge: .leading) {
                                            Button {
                                                tempItemName = groceryItem.name
                                                showItemEdit = true
                                                
                                                
                                            } label: {
                                                Label("Edit Item", systemImage: "pencil.circle")
                                            }
                                        }
                                        .tint(.blue)
                                        .swipeActions(edge: .trailing) {
                                            Button {
                                                if userList.groceryList != []{
                                                    userList.groceryList.removeAll { $0.name == groceryItem.name }
                                                }
                                            } label: {
                                                Label("Delete Grocery", systemImage: "trash")
                                            }
                                            .tint(.red)
                                        }
                                    }
                                    
                            }
                        }
                        else{
                            List(userList.groceryList.filter({ searchResults(in: $0.name) && isSubset(smallerList: selectedGroups, largerList: $0.groupList)})){
                                groceryItem in
                                GroceryItemView(groceryList: $userList, groceryItem: groceryItem, isSelected: groceryItem.selected)
                                    .swipeActions(edge: .leading){
                                        Button {
                                            tempItemName = groceryItem.name
                                            showItemEdit = true
                                        } label: {
                                            Label("Delete Grocery", systemImage: "pencil.circle")
                                        }
                                        .tint(.blue)
                                    }
                                    .swipeActions(edge: .trailing) {
                                        Button {
                                            if userList.groceryList != []{
                                                userList.groceryList.removeAll { $0.name == groceryItem.name }
                                            }
                                        } label: {
                                            Label("Delete Grocery", systemImage: "trash")
                                        }
                                        .tint(.red)
                                    }
                            }
                        }
                    }

                    else{
                        Text("No groceries in your list, please add an item by using the quick add feature or by clicking the Add Item tab")
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                }
                .popover(isPresented: $showItemEdit) {
                    Text("Work In Progress")
                        .font(.title3)
                        .padding(.top)
                    SettingsView()
                }
                .padding()
            }
            .onChange(of: scenePhase) { phase in
                if phase == .inactive {saveAction()}
            }
            .tabItem{Label("My Grocery List", systemImage: "list.dash.header.rectangle")}
            VStack{
                AddItemView(masterGroupList: $masterGroupList, itemAdded: $itemAdded, userList: $userList)
            }.tabItem{Label("Add Item", systemImage: "plus.rectangle")}
//            VStack{
//                SettingsView()
//            }
//            .tabItem{Label("Settings", systemImage: "gearshape")}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(userList: .constant(GroceryList(groceryList: [GroceryItem(quantity: 1, name: "chicken", groupList: ["Costco"], selected: false)])), masterGroupList: .constant(["All Items", "Costco", "Albertsons"]), selectedGroups: .constant(["All Items"]), saveAction: {})
    }
}
