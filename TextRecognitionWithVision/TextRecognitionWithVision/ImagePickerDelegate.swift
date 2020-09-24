//
//  ChooseImage.swift
//  TextRecognitionWithVision
//
//  Created by Paula Leite on 23/09/20.
//

import UIKit

internal class ImagePickerDelegate: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var selectedImage: ((UIImage?) -> Void)?
    
    init(_ selectedImage: @escaping (UIImage?) -> Void) {
        self.selectedImage = selectedImage
    }
    
    /**
     With this function, we access the image that the user selected from their galary or took a photo of.
     - Parameter picker: UIImagePickerController;
     - Parameter info: the key from our Controller (UIIMagePickerController.InfoKey).
     */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        selectedImage?(originalImage)
    }
}
