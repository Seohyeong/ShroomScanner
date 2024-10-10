//
//  Classifier.swift
//  ShroomScanner
//
//  Created by Seohyeong Jeong on 8/26/24.
//

import CoreML
import Vision
import CoreImage

struct Prediction: Identifiable {
    let id: String
    let confidence: Float
    let probability: Float
}

struct Classifier {
    
    private(set) var results: [Prediction] = []
    
    mutating func detect(ciImage: CIImage) {
        
        guard let model = try? VNCoreMLModel(for: mobilenet_v2_finetuned(configuration: MLModelConfiguration()).model)
        else {
            return
        }
        
        let request = VNCoreMLRequest(model: model)
        
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        
        try? handler.perform([request])
        
        guard let results = request.results as? [VNClassificationObservation] else {
            return
        }
        
        // apply softmax
        let confidences = results.map { $0.confidence }
        let probabilities = softmax(confidences)
        
        let topResults = results.sorted { $0.confidence > $1.confidence }.prefix(3)
        self.results = topResults.enumerated().map { index, observation in
            Prediction(id: observation.identifier,
                       confidence: observation.confidence,
                       probability: probabilities[index])
        }
    }
    
    
    private func softmax(_ scores: [Float]) -> [Float] {
            let maxScore = scores.max() ?? 0
            let expScores = scores.map { exp($0 - maxScore) }
            let sumExpScores = expScores.reduce(0, +)
            return expScores.map { $0 / sumExpScores }
        }
}


