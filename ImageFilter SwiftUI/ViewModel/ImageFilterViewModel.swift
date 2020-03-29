//
//  ImageFilterViewModel.swift
//  ImageFilter SwiftUI
//
//  Created by Dmitry Novosyolov on 29/03/2020.
//  Copyright © 2020 Dmitry Novosyolov. All rights reserved.
//

import UIKit.UIImage

final class ImageFilterViewModel: ObservableObject {
    
    @Published var presentedImage: UIImage? = nil
    @Published var selectedImageSource = false
    @Published var takePhoto = false
    @Published var isSelected = false
    
}

extension ImageFilterViewModel {
    func shareImage() {
        //some logic for sharing selected image ...
    }
}
