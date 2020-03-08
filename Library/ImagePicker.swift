//
//  ImagePicker.swift
//  Library
//
//  Created by 加藤直行 on 2020/03/08.
//  Copyright © 2020 加藤直行. All rights reserved.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {

    
    @Environment(\.presentationMode)
    var presentationMode
    
    /// 端末の画像
    @Binding var image: Image?
    
    /// PickerType (PhotoLibrary or Camera or  savedPhotosAlbum )
    var sourceType: UIImagePickerController.SourceType?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        @Binding var presentationMode: PresentationMode
        @Binding var image: Image?

        init(presentationMode: Binding<PresentationMode>, image: Binding<Image?>) {
            _presentationMode = presentationMode
            _image = image
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            image = Image(uiImage: uiImage)
            presentationMode.dismiss()

        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, image: $image)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        guard let sourceType = self.sourceType else {
            return picker
        }
        picker.sourceType = sourceType
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

}
