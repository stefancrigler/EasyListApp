//
//  GroupListView.swift
//  TheGroceryList
//
//  Created by Stefan Crigler on 5/16/23.
//

import SwiftUI

struct GroupListView: View {
    @Binding var selectedGroups: [String]
    var allGroups: [String]
    var allowRemoveAllItems: Bool
    var body: some View {
        VStack{
            List(allGroups, id:\.self){
                group in
                HStack{
                    Text(group)
                    Spacer()
                    if group != "All Items" || allowRemoveAllItems == true  {
                        if selectedGroups.contains(group){
                            Button{
                                selectedGroups.removeAll(where: {$0 == group})
                            } label: {
                                Image(systemName: "circle.dashed.inset.fill")
                                    .foregroundColor(Color(.systemRed))
                            }
                        }
                        else{
                            Button{
                                selectedGroups.append(group)
                                if group == "All Items"{
                                    selectedGroups.removeAll(where: {$0 != "All Items"})
                                }
                                else if allowRemoveAllItems == true{
                                    selectedGroups.removeAll(where: {$0 == "All Items"})
                                }
                            } label: {
                                Image(systemName: "circle.dashed")
                                    .foregroundColor(Color(.systemGray))
                            }
                        }
                    }
                }
            }
        }
    }
}

struct GroupListView_Previews: PreviewProvider {
    static var previews: some View {
        GroupListView(selectedGroups: .constant(["test 1"]), allGroups: ["All Items", "test 1", "test 2"], allowRemoveAllItems: false)
    }
}
