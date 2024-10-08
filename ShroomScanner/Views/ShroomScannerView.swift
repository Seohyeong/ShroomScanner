//
//  ContentView.swift
//  ShroomScanner
//
//  Created by Seohyeong Jeong on 8/26/24.
//

import SwiftUI

struct ShroomScannerView: View {
    
    @State var isPresenting: Bool = false
    @State var uiImage: UIImage?
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @ObservedObject var classifier: ImageClassifier
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "photo")
                    .onTapGesture {
                        isPresenting = true
                        sourceType = .photoLibrary
                    }
                Image(systemName: "camera")
                    .onTapGesture {
                        isPresenting = true
                        sourceType = .camera
                    }
            }
            .font(.largeTitle)
            .foregroundColor(.blue)
            
            Rectangle()
                .strokeBorder()
                .foregroundColor(.yellow)
                .overlay(
                    Group {
                        if uiImage != nil {
                            Image(uiImage: uiImage!)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                )
                .padding()
            
            VStack {
                Button(action: {
                    if uiImage != nil {
                        classifier.detect(uiImage: uiImage!)
                    }
                }) {
                    Image(systemName: "bolt.fill")
                        .foregroundColor(.orange)
                        .font(.title)
                }
                
                Group {
                    if let imageClass = classifier.imageClass {
                        HStack {
                            Text("Image categories:")
                                .font(.subheadline)
                            Text(imageClass)
                                .bold()
                        }
                    } else {
                        HStack {
                            Text("Image categories: NA")
                                .font(.subheadline)
                        }
                    }
                }
                .font(.subheadline)
                .padding()
            }
        }
        .sheet(isPresented: $isPresenting) {
            ImagePicker(uiImage: $uiImage, isPresenting: $isPresenting, sourceType: $sourceType)
                .onDisappear{
                    if uiImage != nil {
                        classifier.detect(uiImage: uiImage!)
                    }
                }
        }
        .padding()
    }
}

#Preview {
    ShroomScannerView(classifier: ImageClassifier())
}
