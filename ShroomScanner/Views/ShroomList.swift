//
//  ShroomList.swift
//  ShroomScanner
//
//  Created by Seohyeong Jeong on 10/4/24.
//

import SwiftUI

struct ShroomList: View {
    @Binding var showShroomList: Bool
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List(searchResults) { shroom in
                NavigationLink {
                    ShroomDetail(shroom: shroom)
                } label: {
                    ShroomRow(shroom: shroom)
                }
            }
            .navigationTitle("Species")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showShroomList = false
                    } label: {
                        HStack {
                            Image(systemName: "chevron.backward")
                            Text("Back")
                        }
                    }
                }
            }
        }
        .searchable(text: $searchText)
    }
    
    var searchResults: [Shroom] {
        if searchText.isEmpty {
            return shrooms
        } else {
            return shrooms.filter { $0.species.contains(searchText) }
        }
    }
}

//#Preview {
//    @State static var showShroomList: Bool = true
//    ShroomList()
//}

struct ShroomList_Previews: PreviewProvider {
    @State static var showShroomList: Bool = true

    static var previews: some View {
        ShroomList(showShroomList: $showShroomList)
    }
}
