//
//  ChooseImage.swift
//  TextRecognitionWithVision
//
//  Created by Paula Leite on 23/09/20.
//

import UIKit

internal class ImagePickerDelegate: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Image wasn't returned")
        }
    }
}
