//
//  FilteredImageView.swift
//  ImageFilter SwiftUI
//
//  Created by Dmitry Novosyolov on 29/03/2020.
//  Copyright © 2020 Dmitry Novosyolov. All rights reserved.
//

import SwiftUI

struct FilteredImageView: View {
    var imageFilter: ImageFilter
    @ObservedObject var imageFilterVM: ImageFilterViewModel
    @State private var filteredImage: UIImage? = nil
    private var validate: Bool { imageFilterVM.presentedImage == filteredImage }
    var body: some View {
        VStack {
            if filteredImage != nil {
                VStack {
                    Image(uiImage: filteredImage!)
                        .resizable()
                        .cornerRadius(7)
                        .scaledToFit()
                        .overlay(validate ? RoundedRectangle(cornerRadius: 7, style: .continuous).stroke(Color.red.opacity(0.35), lineWidth: 1.3) : nil)
                        .onTapGesture {
                            DispatchQueue.main.async {
                                withAnimation(.default)
                                { self.imageFilterVM.presentedImage = self.filteredImage }
                            }
                    }
                    Text(imageFilter.id.rawValue)
                        .font(.custom("Papyrus", size: 13))
                        .bold()
                        .foregroundColor(validate ? .primary : .secondary)
                        .underline(validate, color: .red)
                        .lineLimit(1)
                }
            } else {
                ProgressView(color: .secondaryLabel)
            }
        }
        .frame(maxWidth: 90, maxHeight: 90)
        .onAppear {
            self.imageFilter.performFilter(for: self.imageFilterVM.presentedImage!) {
                self.filteredImage = $0
            }
        }
    }
}

struct FilteredImageView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredImageView(imageFilter: ImageFilter.dotScreen,
                          imageFilterVM: ImageFilterViewModel())
    }
}

