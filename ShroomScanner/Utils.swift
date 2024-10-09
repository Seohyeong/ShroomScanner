//
//  Utils.swift
//  ShroomScanner
//
//  Created by Seohyeong Jeong on 10/5/24.
//

import Foundation

extension String {
    func capFirstLetter() -> String {
        return self.split(separator: " ")
            .map { $0.prefix(1).uppercased() + $0.dropFirst().lowercased() }
            .joined(separator: " ")
    }
}
