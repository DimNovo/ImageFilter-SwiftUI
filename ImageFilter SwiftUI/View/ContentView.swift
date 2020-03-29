//
//  ContentView.swift
//  ImageFilter SwiftUI
//
//  Created by Dmitry Novosyolov on 29/03/2020.
//  Copyright © 2020 Dmitry Novosyolov. All rights reserved.
//

import SwiftUI

let DEVICE_SIZE = UIScreen.main.bounds

struct ContentView: View {
    @ObservedObject var imageFilterVM = ImageFilterViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    @State private var contentMode: ContentMode = .fit
    @State private var scaleAmount: CGFloat = 1.0
    @State private var dragAmount: CGSize = .zero
    @State private var offSetAmount: CGSize = .zero
    
    var body: some View {
        NavigationView {
            VStack {
                Group {
                    if imageFilterVM.presentedImage != nil {
                        Image(uiImage: imageFilterVM.presentedImage!)
                            .resizable()
                            .aspectRatio(contentMode: contentMode)
                            .frame(maxWidth: DEVICE_SIZE.width, maxHeight: DEVICE_SIZE.height / 2)
                            
                            .offset(dragAmount)
                            .scaleEffect(scaleAmount)
                            
                            .onTapGesture(count: 2) {
                                withAnimation(.spring()) {
                                    (self.contentMode == .fit) ?
                                        (self.contentMode = .fill) :
                                        (self.contentMode = .fit)
                                }
                        }
                        .gesture(
                            MagnificationGesture(minimumScaleDelta: 0.05)
                                .onChanged { self.scaleAmount = $0 }
                                .onEnded { _ in withAnimation(.spring()) {
                                    self.scaleAmount = 1.0
                                    self.dragAmount = .zero
                                    self.offSetAmount = .zero
                                    }
                            }
                            .simultaneously(with:
                                DragGesture()
                                    .onChanged { self.dragAmount = $0.translation }
                                    .onEnded { _ in withAnimation(.spring()) {
                                        self.scaleAmount = 1.0
                                        self.dragAmount = .zero
                                        self.offSetAmount = .zero
                                        }
                                }
                            )
                        )
                        
                        
                        VStack(spacing: 15) {
                            Text("Choose Filter")
                                .font(.custom("Papyrus", size: 22))
                                .foregroundColor(colorScheme == .dark ? .black : .white)
                                .shadow(color: .primary, radius: 3)
                                .shadow(color: .primary, radius: 3)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(ImageFilter.allCases) { imageFilter in
                                        FilteredImageView(imageFilter: imageFilter, imageFilterVM: self.imageFilterVM)
                                    }
                                }
                                .padding(.horizontal, 10)
                            }
                        }
                        .offset(scaleAmount >= 2.2 ? CGSize(width: 0, height: 300) : offSetAmount)
                    } else {
                        Image(systemName: "rectangle.stack.badge.plus")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .foregroundColor(.secondary)
                            .opacity(0.5)
                    }
                }
                .modifier(CustomSheetView(isPresented: $imageFilterVM.selectedImageSource, isSelected: $imageFilterVM.isSelected, takePhoto: $imageFilterVM.takePhoto))
            }
            .navigationBarItems(
                leading:
                Button(action: {
                    self.imageFilterVM.presentedImage = nil
                    self.imageFilterVM.selectedImageSource.toggle()
                }, label: { Image(systemName: "camera.on.rectangle")})
                    .imageScale(.large)
                    .accentColor(.primary),
                trailing:
                Button(action: { self.imageFilterVM.shareImage()}, label: { Image(systemName: "square.and.arrow.up")})
                    .imageScale(.large)
                    .accentColor(.primary))
                .sheet(isPresented: $imageFilterVM.isSelected)
                { ImagePicker(image: self.$imageFilterVM.presentedImage,
                              takePhoto: self.$imageFilterVM.takePhoto)}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
