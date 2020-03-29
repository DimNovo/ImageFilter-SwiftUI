//
//  CustomSheet.swift
//  ImageFilter SwiftUI
//
//  Created by Dmitry Novosyolov on 29/03/2020.
//  Copyright © 2020 Dmitry Novosyolov. All rights reserved.
//

import SwiftUI

struct CustomSheetView: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var isSelected: Bool
    @Binding var takePhoto: Bool
    func body(content: Content) -> some View {
        content
            .actionSheet(isPresented: $isPresented) {
                ActionSheet(title: Text("Please select a source"), message: nil, buttons: [
                    .default(Text("Camera"), action: {
                        self.takePhoto = true
                        self.isSelected.toggle()
                    }),
                    .default(Text("Photo Library"), action: {
                        self.takePhoto = false
                        self.isSelected.toggle()
                    }),
                    .cancel()
                ])
        }
    }
}
