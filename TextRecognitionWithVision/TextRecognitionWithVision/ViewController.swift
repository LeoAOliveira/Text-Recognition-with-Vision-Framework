//
//  ViewController.swift
//  TextRecognitionWithVision
//
//  Created by Leonardo Oliveira on 22/09/20.
//

import UIKit

internal class ViewController: UIViewController {
    
    private var textRecognition = TextRecognition()
    
    private lazy var delegate = ImagePickerDelegate { (image) in
        self.selectedPhotoImageView.image = image
        self.executeTextRecognition(image: image)
        self.dismiss(animated: true, completion: nil)
    }
    
    private lazy var imagePickerController: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = delegate
        
        #warning("Defining image picker 'sourceType' as '.camera' will cause error when running in the simulator. Comment the line below while testing.")
        // imagePicker.sourceType = .camera
        imagePicker.sourceType = .photoLibrary
        
        return imagePicker
    }()
    
    private lazy var selectedPhotoImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemGray
        self.view.addSubview(imageView)
        return imageView
    }()
    
    private lazy var digitalizationTextView: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Salve o tricolor paulista!"
        textView.layer.cornerRadius = 10.0
        self.view.addSubview(textView)
        return textView
    }()
    
    private lazy var selectPhotoButton: UIButton = {
        let photoButton = UIButton(frame: .zero)
        photoButton.translatesAutoresizingMaskIntoConstraints = false
        photoButton.setTitle("Selecione uma foto", for: .normal)
        photoButton.backgroundColor = .red
        photoButton.addTarget(self, action: #selector(selectPhotoAction), for: .touchUpInside)
        self.view.addSubview(photoButton)
        return photoButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    private func executeTextRecognition(image: UIImage?) {
        guard let imageVision = image else { return }
        
        let results = textRecognition.imageRequest(toImage: imageVision)
        
        digitalizationTextView.text = results
    }
    
    private func showImagePickerControllerAction() {
        let photoLibraryAction = UIAlertAction(title: "Fotos e Vídeos", style: .default) { (action) in
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
        
        let cameraAction = UIAlertAction(title: "Câmera", style: .default) { (action) in
            self.imagePickerController.sourceType = .camera
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
        
        AlertManager.createMultipleActionsAlert(on: self, title: "Escolha a sua imagem", message: "Dica: você pode transformar imagens em texto.", actions: [photoLibraryAction, cameraAction])
    }

    /**
    Select image from photo library
    */
    @objc func selectPhotoAction() {
        
        showImagePickerControllerAction()
    }
    
    override func viewDidLayoutSubviews() {
        
        NSLayoutConstraint.activate([
            selectedPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            selectedPhotoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            selectedPhotoImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            selectedPhotoImageView.heightAnchor.constraint(equalToConstant: 300),
            
            digitalizationTextView.topAnchor.constraint(equalTo: selectedPhotoImageView.bottomAnchor),
            digitalizationTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            digitalizationTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            digitalizationTextView.heightAnchor.constraint(equalToConstant: 300),
            
            selectPhotoButton.topAnchor.constraint(equalTo: digitalizationTextView.bottomAnchor),
            selectPhotoButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            selectPhotoButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            selectPhotoButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    


}

