//
//  ModelData.swift
//  ShroomScanner
//
//  Created by Seohyeong Jeong on 10/4/24.
//

import Foundation

//var shrooms: [Shroom] = load("meta.json").sorted { $0.species < $1.species }

var shrooms: [Shroom] = {
    let loadedShrooms: [Shroom] = load("meta.json")
    return loadedShrooms.sorted { $0.species < $1.species }
}()


func load<T: Decodable>(_ filename: String) -> T {
    let data: Data


    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }


    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }


    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
