//
//  EditItemView.swift
//  TheGroceryList
//
//  Created by Stefan Crigler on 5/14/23.
//

//import SwiftUI
//
//struct EditItemView: View {
//    @Binding var masterGroupList:[String]
//    @Binding var userList:GroceryList
////    @Binding var itemName:String
////    @Binding var itemGroups:[String]
//    @Binding var showItemEdit: Bool
//    @State var localName: String
//    @State private var groupName:String = ""
//    @State private var showEmpty = false
//    @State private var showDuplicate = false
//    @State private var showAddedGroup = false
//    @State private var showGroups = false
//
//    //TODO: Update the logic in here for editing
//
//    var body: some View {
//        let placeHolderName = localName
//        ZStack{
//            VStack{
//                Text("Edit Item")
//                    .fontWeight(.bold)
//                    .font(.largeTitle)
//                HStack{
//                    TextField("Enter the Item Name", text: $localName)
//                        .font(.title2)
//                        .frame(height: 72.0)
//                        .padding(.horizontal)
//                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
//                        .padding(.horizontal)
//                    Button{
//                        if localName != "" && userList.groceryList.filter({$0.name == localName}).count == 0 || localName == placeHolderName {
//                            userList.groceryList.first(where: {$0.name = placeHolderName}).name = localName
//                            showItemEdit = false
//                        }
//                        else if localName == "" {
//                            showEmpty = true
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                                self.showEmpty = false
//                            }
//                        }
//                        else if userList.groceryList.filter({$0.name == localName}) != [] && localName != placeHolderName {
//                            showDuplicate = true
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                                self.showDuplicate = false
//                            }
//                        }
//
//                    } label: {
//                        Image(systemName: "checkmark.square.fill")
//                            .resizable()
//                            .foregroundColor(Color(.systemGreen))
//                            .scaledToFit()
//                            .offset(x: -15.0, y: 0)
//                            .frame(width: 50, height: 50)
//                    }
//                }
//                HStack{
//                    TextField("New Group? Add it in Here", text: $groupName)
//                        .font(.headline)
//                        .frame(height: 42.0)
//                        .padding(.horizontal)
//                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
//                        .padding(.horizontal)
//                    Button{
//                        if groupName != "" && !masterGroupList.contains(groupName) {
//                            masterGroupList.append(groupName)
//                            if !userList.groceryList.first(where: {$0.name == placeHolderName}).contains(groupName){
//                                userList.groceryList.first(where: {$0.name == placeHolderName}).append(groupName)
//                            }
//                            showAddedGroup = true
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                                self.showAddedGroup = false
//                                groupName = ""
//                            }
//                        }
//                    } label: {
//                        Image(systemName: "plus")
//                            .resizable()
//                            .scaledToFit()
//                            .offset(x: -5.0, y: 0)
//                            .frame(width: 23, height: 23)
//                    }
//                    .padding(.trailing)
//                }
//                Button{
//                    showGroups = true
//                } label: {
//                    HStack{
//                        Text("Add Existing Group")
//                        Image(systemName:  "note.text.badge.plus")
//                    }
//                }.popover(isPresented: $showGroups) {
//                    Text("Select Groups to Add")
//                        .font(.title3)
//                        .padding(.top)
//                    GroupListView(selectedGroups: $userList.groceryList.first(where: {$0.name == placeHolderName}), allGroups: masterGroupList, allowRemoveAllItems: false)
//                        .padding()
//                }
//                VStack{
//                    Text("Current Groups \(localName == "" ? "'your item'" : "'\(localName)'") belongs to:")
//                        .padding(.vertical)
//                    HStack{
//                        List(userList.groceryList.first(where: {$0.name == placeHolderName}), id:\.self){
//                            group in
//                            HStack{
//                                Text(group)
//                                Spacer()
//                                if group != "All Items"{
//                                    Button{
//                                        if userList.groceryList.first(where: {$0.name == placeHolderName}) != ["All Items"] && group != "All Items"{
//                                            userList.groceryList.first(where: {$0.name == placeHolderName}).removeAll { $0 == group }
//                                        }
//                                    } label: {
//                                        Image(systemName: "xmark.circle.fill")
//                                            .foregroundColor(Color(.systemRed))
//                                    }
//                                }
//                            }
//                        }
//                        .listRowBackground(Color(.systemGray6))
//                    }
//                }
//                .border(Color(.lightGray), width: 1)
//                .background(Color(.systemGray6))
//                .padding(.horizontal)
//                Spacer()
//            }
//            if showAddedGroup{
//                VStack{
//                    RoundedRectangle(cornerRadius: 16)
//                        .foregroundColor(Color(.systemGray6))
//                        .frame(width: 200, height: 50)
//                        .overlay(
//                            VStack {
//                                Text("Group: \(groupName) Added").font(.subheadline)
//                                    .fontWeight(.bold)
//                            }
//                        )
//                        .padding(.bottom)
//                    Spacer()
//                }
//            }
//            if showEmpty{
//                VStack{
//                    RoundedRectangle(cornerRadius: 16)
//                        .foregroundColor(Color(.systemRed))
//                        .frame(width: 200, height: 50)
//                        .overlay(
//                            VStack {
//                                Text("Please add an Item Name").font(.subheadline)
//                                    .fontWeight(.bold)
//                            }
//                        )
//                        .padding(.bottom)
//                    Spacer()
//                }
//            }
//            if showDuplicate{
//                VStack{
//                    RoundedRectangle(cornerRadius: 16)
//                        .foregroundColor(Color(.systemRed))
//                        .frame(width: 200, height: 50)
//                        .overlay(
//                            VStack {
//                                Text("An item with the name: \(localName) already exists").font(.subheadline)
//                                    .fontWeight(.bold)
//                                    .multilineTextAlignment(.center)
//                            }
//                        )
//                        .padding(.bottom)
//                    Spacer()
//                }
//            }
//        }
//    }
//}
//
//struct EditItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditItemView(masterGroupList: .constant([]), userList: .constant(GroceryList(groceryList: [])), showItemEdit: .constant(true), localName: "item_name")
//    }
//}
