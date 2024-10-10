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
                    actionButtonsView
                    rectView

                    Group {
                        if classifier.topPredictions.isEmpty {
                            emptyStateView
                                .frame(height: 130)
                        } else {
                            predictionListView
                                .frame(height: 130)
                        }
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
    
    
    // main function buttons view
    private var actionButtonsView: some View {
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
        .padding(.top, -30)
    }
    
    
    // camera position view
    private var rectView: some View {
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
    }
    
    
    // empty prediction view
    private var emptyStateView: some View {
        VStack {
            Image(systemName: "bolt.fill")
                .foregroundColor(.orange)
                .font(.title)
            Text("Detect Your 🍄!")
                .font(.title3)
                .bold()
                .padding()
        }
    }

    
    // prediction view
    private var predictionListView: some View {
        VStack(spacing: 10) {
            ForEach(classifier.topPredictions) { pred in
                NavigationLink {
                    ShroomDetail(shroom: shrooms.first(where: { $0.species == pred.id })!)
                } label: {
                    HStack {
                        Text(pred.id.capFirstLetter())
                            .font(.title3)
                            .bold()
                        Spacer()
                        Text("\(String(format: "%.2f%%", pred.probability * 100))")
                            .font(.headline)
                    }
                }
            }
        }
    }
}


#Preview {
    ShroomScannerView(classifier: ImageClassifier())
}
