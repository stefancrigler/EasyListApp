//
//  GroceryItemView.swift
//  TheGroceryList
//
//  Created by Stefan Crigler on 5/11/23.
//

import SwiftUI

struct GroceryItemView: View {
    @Binding var groceryList:GroceryList
    @State var groceryItem: GroceryItem
    @State var isSelected: Bool
    var body: some View {
        if !isSelected {
            HStack{
                Text(groceryItem.name)
                    .foregroundColor(Color(.black))
                Spacer()
                Button{
                    isSelected.toggle()
                    if let idx = groceryList.groceryList.firstIndex(where: {$0.name == groceryItem.name}){
                        groceryList.groceryList[idx].selected.toggle()
                    }
                }label:{
                    Image(systemName:"circle.dashed")
                        .foregroundColor(Color(.systemGray))
                }
            }
        }
        else{
            HStack{
                Text(groceryItem.name)
                    .foregroundColor(Color(.black))
                Spacer()
                Button{
                    isSelected.toggle()
                    if let idx = groceryList.groceryList.firstIndex(where: {$0.name == groceryItem.name}){
                        groceryList.groceryList[idx].selected.toggle()
                    }
                }label:{
                    Image(systemName:"circle.dashed.inset.fill")
                        .foregroundColor(Color(.systemRed))
                }
            }
        }
    }
}

struct GroceryItemView_Previews: PreviewProvider {
    static var previews: some View {
        GroceryItemView(groceryList: .constant(GroceryList(groceryList: [])), groceryItem: testGroceryItem, isSelected: false)
    }
}
