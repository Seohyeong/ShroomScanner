//
//  ContentView.swift
//  ShroomScanner
//
//  Created by Seohyeong Jeong on 8/26/24.
//

import SwiftUI

struct ShroomScannerView: View {
    
    @State var showShroomList: Bool = false
    @State var isPresenting: Bool = false
    @State var uiImage: UIImage?
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @ObservedObject var classifier: ImageClassifier
    
    var body: some View {
        NavigationView {
            if showShroomList {
                ShroomList(showShroomList: $showShroomList)
            } else {
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
                        Image(systemName: "book")
                            .onTapGesture {
                                showShroomList = true
                            }
                    }
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                    
                    Rectangle()
                        .strokeBorder()
                        .foregroundColor(.yellow)
                        .frame(width: 300, height:300)
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
                                VStack {
                                    NavigationLink{
                                        ShroomDetail(shroom: shrooms.first(where: { $0.species == imageClass })!)
                                    } label: {
                                        Text(imageClass.capFirstLetter())
                                            .bold()
                                    }
                                }
                            } else {
                                VStack {
                                    Text("Species: NA")
                                        .bold()
                                }
                            }
                        }
                        .font(.title2)
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
                .navigationTitle("ShroomAI")
            }
        }
    }
}

#Preview {
    ShroomScannerView(classifier: ImageClassifier())
}
