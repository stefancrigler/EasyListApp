//
//  HorizontalGroupFilterVIew.swift
//  TheGroceryList
//
//  Created by Stefan Crigler on 5/17/23.
//

import SwiftUI

struct HorizontalGroupFilterVIew: View {
    @State private var testList: [String] = ["test 1", "test 2", "test 3"]
    @Binding var selectedGroups: [String]
    var body: some View {
        VStack{
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    ForEach(selectedGroups, id: \.self) { item in
                        if item != "All Items"{
                            HStack{
                                Text(item)
                                Image(systemName: "x.circle.fill")
                                    .foregroundColor(Color(.systemRed))
                            }
                            .padding(5)
                            .background(.ultraThickMaterial, in: Capsule())
                            .onTapGesture{
                                selectedGroups.removeAll(where: {$0 == item})
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
                
}

struct HorizontalGroupFilterVIew_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalGroupFilterVIew(selectedGroups: .constant(["test 1", "test 2", "test 3"]))
    }
}
