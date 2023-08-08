//
//  AddItemView.swift
//  TheGroceryList
//
//  Created by Stefan Crigler on 5/14/23.
//

import SwiftUI

struct AddItemView: View {
    @Binding var masterGroupList:[String]
    @Binding var itemAdded: Bool
    @Binding var userList:GroceryList
    @State private var itemName:String = ""
    @State private var groupName:String = ""
    @State private var testGroups: [String] = ["All Items","Costco", "Target", "Albertsons", "a", "b", "c", "d", "e", "f", "g", "h", "j", "k"]
    @State private var showAdded = false
    @State private var showEmpty = false
    @State private var showDuplicate = false
    @State private var showAddedGroup = false
    @State private var showGroups = false
    @State private var itemGroups:[String] = ["All Items"]
    var body: some View {
        ZStack{
            VStack{
                Text("Add Item")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                HStack{
                    TextField("Enter the Item Name", text: $itemName)
                        .font(.title2)
                        .frame(height: 72.0)
                        .padding(.horizontal)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        .padding(.horizontal)
                    Button{
                        if itemName != "" && userList.groceryList.filter({$0.name == itemName}) == [] {
                            userList.groceryList.append(GroceryItem(quantity: 1, name: itemName, groupList: itemGroups, selected: false))
                            showAdded = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.showAdded = false
                                itemName = ""
                                itemGroups = ["All Items"]
                            }
                        }
                        else if itemName == "" {
                            showEmpty = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.showEmpty = false
                            }
                        }
                        else if userList.groceryList.filter({$0.name == itemName}) != [] {
                            showDuplicate = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.showDuplicate = false
                            }
                        }
                        
                    } label: {
                        Image(systemName: "checkmark.square.fill")
                            .resizable()
                            .foregroundColor(Color(.systemGreen))
                            .scaledToFit()
                            .offset(x: -15.0, y: 0)
                            .frame(width: 50, height: 50)
                    }
                }
                HStack{
                    TextField("New Group? Add it in Here", text: $groupName)
                        .font(.headline)
                        .frame(height: 42.0)
                        .padding(.horizontal)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        .padding(.horizontal)
                    Button{
                        if groupName != "" && !masterGroupList.contains(groupName) {
                            masterGroupList.append(groupName)
                            if !itemGroups.contains(groupName){
                                itemGroups.append(groupName)
                            }
                            showAddedGroup = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.showAddedGroup = false
                                groupName = ""
                            }
                        }
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .offset(x: -5.0, y: 0)
                            .frame(width: 23, height: 23)
                    }
                    .padding(.trailing)
                }
                Button{
                    showGroups = true
                } label: {
                    HStack{
                        Text("Add Existing Group")
                        Image(systemName:  "note.text.badge.plus")
                    }
                }.popover(isPresented: $showGroups) {
                    Text("Select Groups to Add")
                        .font(.title3)
                        .padding(.top)
                    GroupListView(selectedGroups: $itemGroups, allGroups: masterGroupList, allowRemoveAllItems: false)
                        .padding()
                }
                VStack{
                    Text("Current Groups \(itemName == "" ? "'your item'" : "'\(itemName)'") belongs to:")
                        .padding(.vertical)
                    HStack{
                        List(itemGroups, id:\.self){
                            group in
                            HStack{
                                Text(group)
                                Spacer()
                                if group != "All Items"{
                                    Button{
                                        if itemGroups != ["All Items"] && group != "All Items"{
                                            itemGroups.removeAll { $0 == group }
                                        }
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(Color(.systemRed))
                                    }
                                }
                            }
                        }
                        .listRowBackground(Color(.systemGray6))
                    }
                }
                .border(Color(.lightGray), width: 1)
                .background(Color(.systemGray6))
                .padding(.horizontal)
                Spacer()
            }
            if showAdded{
                VStack{
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(Color(.systemGray6))
                        .frame(width: 200, height: 50)
                        .overlay(
                            VStack {
                                Text("Item: \(itemName) Added").font(.subheadline)
                                    .fontWeight(.bold)
                            }
                        )
                        .padding(.bottom)
                    Spacer()
                }
            }
            if showAddedGroup{
                VStack{
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(Color(.systemGray6))
                        .frame(width: 200, height: 50)
                        .overlay(
                            VStack {
                                Text("Group: \(groupName) Added").font(.subheadline)
                                    .fontWeight(.bold)
                            }
                        )
                        .padding(.bottom)
                    Spacer()
                }
            }
            if showEmpty{
                VStack{
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(Color(.systemRed))
                        .frame(width: 200, height: 50)
                        .overlay(
                            VStack {
                                Text("Please add an Item Name").font(.subheadline)
                                    .fontWeight(.bold)
                            }
                        )
                        .padding(.bottom)
                    Spacer()
                }
            }
            if showDuplicate{
                VStack{
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(Color(.systemRed))
                        .frame(width: 200, height: 50)
                        .overlay(
                            VStack {
                                Text("An item with the name: \(itemName) already exists").font(.subheadline)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                            }
                        )
                        .padding(.bottom)
                    Spacer()
                }
            }
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(masterGroupList: .constant([]), itemAdded: .constant(false), userList: .constant(GroceryList(groceryList: [])))
    }
}
