//
//  ShroomRow.swift
//  ShroomScanner
//
//  Created by Seohyeong Jeong on 10/4/24.
//

import SwiftUI

struct ShroomRow: View {
    var shroom: Shroom
    
    var body: some View {
        HStack{
            Image(shroom.species)
                .resizable()
                .frame(width: 50, height: 50)
            
            Text(shroom.species.capFirstLetter())
            
            Spacer()
        }
    }
}

#Preview {
    Group{
        ShroomRow(shroom: shrooms[0])
        ShroomRow(shroom: shrooms[1])
    }
}
