//
//  Shroom.swift
//  ShroomScanner
//
//  Created by Seohyeong Jeong on 10/4/24.
//

import Foundation
import SwiftUI

struct Shroom: Codable, Identifiable {
    let id: Int
    let species: String
    let gbifOccID: Int
    let gbifSpeciesID: Int
    let phylum: String
    let classification: String
    let order: String
    let family: String
    let genus: String
    let commonName: String
    let desc: String
    
    // Custom CodingKeys to handle reserved keywords
    enum CodingKeys: String, CodingKey {
        case id = "inatSpeciesID"
        case species
        case gbifOccID
        case gbifSpeciesID
        case phylum
        case classification = "class"
        case order
        case family
        case genus
        case commonName
        case desc
    }
}
