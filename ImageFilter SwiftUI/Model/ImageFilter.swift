//
//  ImageFilter.swift
//  ImageFilter SwiftUI
//
//  Created by Dmitry Novosyolov on 29/03/2020.
//  Copyright © 2020 Dmitry Novosyolov. All rights reserved.
//

import UIKit.UIImage
import CoreImage.CIFilterBuiltins

enum ImageFilter: String, Identifiable, Hashable, CaseIterable, Equatable {
    
    var id: ImageFilter { self }
    
    case `default` = "Default"
    case posterize = "Posterize"
    case fade = "Fade"
    case chrome = "Chrome"
    case instant = "Instant"
    case falseColor = "False Color"
    case process = "Process"
    case transfer = "Transfer"
    case mono = "Mono"
    case noir = "Noir"
    case dotScreen = "Dot Screen"
    case edges = "Edges"
    
    func performFilter(for image: UIImage, completion: @escaping(UIImage) -> Void) {
        
        DispatchQueue.main.async {
            let outputImage: UIImage?
            switch self {
            case .default:
                outputImage = image
            case .posterize:
                outputImage = self.applyProcessing(image, filter: .colorPosterize())
            case .fade:
                outputImage = self.applyProcessing(image, filter: .photoEffectFade())
            case .chrome:
                outputImage = self.applyProcessing(image, filter: .photoEffectChrome())
            case .instant:
                outputImage = self.applyProcessing(image, filter: .photoEffectInstant())
            case .falseColor:
                outputImage = self.applyProcessing(image, filter: .falseColor())
            case .process:
                outputImage = self.applyProcessing(image, filter: .photoEffectProcess())
            case .transfer:
                outputImage = self.applyProcessing(image, filter: .photoEffectTransfer())
            case .mono:
                outputImage = self.applyProcessing(image, filter: .photoEffectMono())
            case .noir:
                outputImage = self.applyProcessing(image, filter: .photoEffectNoir())
            case .dotScreen:
                outputImage = self.applyProcessing(image, filter: .dotScreen())
            case .edges:
                outputImage = self.applyProcessing(image, filter: .edges())
            }
            guard outputImage != nil else { completion(image); return }
            completion(outputImage!)
        }
    }
    
    private func applyProcessing(_ image: UIImage, filter: CIFilter) -> UIImage {
        var uiImage = image
        guard let inputImage = CIImage(image: uiImage) else { return uiImage }
        let context = CIContext()
        
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        filter.setDefaults()
        
        guard let outputImage = filter.outputImage else { return uiImage }
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            uiImage = UIImage(cgImage: cgImage)
        }
        return uiImage
    }
}
