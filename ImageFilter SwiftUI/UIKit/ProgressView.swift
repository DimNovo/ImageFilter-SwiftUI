//
//  ProgressView.swift
//  ImageFilter SwiftUI
//
//  Created by Dmitry Novosyolov on 29/03/2020.
//  Copyright © 2020 Dmitry Novosyolov. All rights reserved.
//

import SwiftUI

struct ProgressView: UIViewRepresentable {
    var style: UIActivityIndicatorView.Style?
    var color: UIColor?
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let progressView = UIActivityIndicatorView()
        progressView.style = style ?? .large
        progressView.color = color ?? .clear
        return progressView
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        uiView.startAnimating()
    }
}
