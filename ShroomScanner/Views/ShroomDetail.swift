//
//  ShroomDetail.swift
//  ShroomScanner
//
//  Created by Seohyeong Jeong on 10/5/24.
//

import SwiftUI

struct ShroomDetail: View {
    var shroom: Shroom
    
    var body: some View {
        ScrollView {
            CircleImage(image: Image(shroom.species))
                .offset(y: -40)
                .padding(.bottom, -20)
            
            VStack(alignment: .leading) {
                Text(shroom.species.capFirstLetter())
                    .font(.title)
                    .italic()
                
                if !shroom.commonName.isEmpty && shroom.commonName.capFirstLetter() != shroom.species.capFirstLetter() {
                    HStack {
                        Text("also known as ")
                            .foregroundColor(.secondary) +
                        Text(shroom.commonName.capFirstLetter())
                            .foregroundColor(.blue)
                    }
                }
                
                
                Divider()
                
                Text("Taxonomy")
                    .font(.title2)
                
                VStack(alignment: .leading) {
                    TaxonomyRow(label: "Phylum", value: shroom.phylum)
                    TaxonomyRow(label: "Class", value: shroom.classification)
                    TaxonomyRow(label: "Order", value: shroom.order)
                    TaxonomyRow(label: "Family", value: shroom.family)
                    TaxonomyRow(label: "Genus", value: shroom.genus)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
                
                Spacer()
                
                HStack {
                    Text("About")
                        .font(.title2) +
                    Text(" \(shroom.species.capFirstLetter())")
                        .font(.title2)
                        .italic()
                }
                
                if !shroom.desc.isEmpty {
                    Text(shroom.desc.replacingOccurrences(of: "\n\n", with: " ").replacingOccurrences(of: "\n", with: " "))
                } else {
                    Text("No matched Wikipedia page found. Help the world out and create the page on Wikipedia!")
                }
            }
            .padding()
            
            Spacer()
            
            Text("Sourced from Wikipedia")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

struct TaxonomyRow: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label)
                .fontWeight(.bold)
            Spacer()
            Text(value)
                .foregroundStyle(.secondary)
        }
    }
    
}

#Preview {
    ShroomDetail(shroom: shrooms[93])
}
