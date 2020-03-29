//
//  ImagePicker.swift
//  ImageFilter SwiftUI
//
//  Created by Dmitry Novosyolov on 29/03/2020.
//  Copyright © 2020 Dmitry Novosyolov. All rights reserved.
//

import SwiftUI

final class ImagePickerCoordinator: NSObject {
    @Binding var image: UIImage?
    @Binding var takePhoto: Bool
    init(image: Binding<UIImage?>, takePhoto: Binding<Bool>) {
        _image = image
        _takePhoto = takePhoto
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var takePhoto: Bool
    
    func makeCoordinator() -> ImagePickerCoordinator {
        ImagePickerCoordinator(image: $image, takePhoto: $takePhoto)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        pickerController.delegate = context.coordinator
        return pickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        switch self.takePhoto {
        case true:
            uiViewController.sourceType = .camera
            uiViewController.showsCameraControls = true
        case false:
            uiViewController.sourceType = .photoLibrary
        }
        uiViewController.allowsEditing = true
    }
}

extension ImagePickerCoordinator: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageOriginal = info[.originalImage] as? UIImage { image = imageOriginal }
        if let imageEdited = info[.editedImage] as? UIImage { image = imageEdited }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) { picker.dismiss(animated: true, completion: nil)}
}
