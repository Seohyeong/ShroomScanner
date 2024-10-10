//
//  ImageClassifier.swift
//  ShroomScanner
//
//  Created by Seohyeong Jeong on 8/26/24.
//

import SwiftUI

class ImageClassifier: ObservableObject {
    
    @Published private var classifier = Classifier()
    
    var topPredictions: [Prediction] {
            classifier.results
        }
        
    func detect(uiImage: UIImage) {
        guard let ciImage = CIImage (image: uiImage) else { return }
        classifier.detect(ciImage: ciImage)
    }

}

