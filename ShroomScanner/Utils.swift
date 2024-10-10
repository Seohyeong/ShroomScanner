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


func softmax(_ scores: [Float]) -> [Float] {
        let maxScore = scores.max() ?? 0
        let expScores = scores.map { exp($0 - maxScore) }
        let sumExpScores = expScores.reduce(0, +)
        return expScores.map { $0 / sumExpScores }
    }
