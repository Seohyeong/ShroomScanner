//
//  ShroomScannerApp.swift
//  ShroomScanner
//
//  Created by Seohyeong Jeong on 8/26/24.
//

import SwiftUI

@main
struct ShroomScannerApp: App {
    var body: some Scene {
        WindowGroup {
            ShroomScannerView(classifier: ImageClassifier())
        }
    }
}
