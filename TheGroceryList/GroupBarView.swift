//
//  GroupBarView.swift
//  TheGroceryList
//
//  Created by Stefan Crigler on 5/17/23.
//

import SwiftUI

struct GroupBarView: View {
    @Binding var showGroupList: Bool
    @Binding var selectedGroups: [String]
    @Binding var quickAddGroupPresented: Bool
    @Binding var masterGroupList:[String]
    var body: some View {
        HStack{
            Button{
                showGroupList = true
            } label: {
                HStack{
                    Image(systemName:"tag.fill")
                }
                .padding(.horizontal)
                .background(.ultraThickMaterial, in: Capsule())
            }
            HorizontalGroupFilterVIew(selectedGroups: $selectedGroups)
            Button{
                quickAddGroupPresented = true
            } label: {
                Text("Create Group")
                    .padding(5)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
            .padding(.trailing)
            .popover(isPresented: $showGroupList) {
                Text("Select Groups to Filter By")
                    .font(.title3)
                    .padding(.top)
                GroupListView(selectedGroups: $selectedGroups, allGroups: masterGroupList, allowRemoveAllItems: true)
                    .padding()
            }
        }
    }
}

struct GroupBarView_Previews: PreviewProvider {
    static var previews: some View {
        GroupBarView(showGroupList: .constant(false), selectedGroups: .constant(["test 1"]), quickAddGroupPresented: .constant(false), masterGroupList: .constant(["test 1", "test 2"]))
    }
}
