//
//  ViewController.swift
//  TextRecognitionWithVision
//
//  Created by Leonardo Oliveira on 22/09/20.
//

import UIKit

internal class ViewController: UIViewController {
    
    private lazy var selectedPhotoImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .blue
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
        photoButton.setTitle("Select photo", for: .normal)
        photoButton.backgroundColor = .red
        self.view.addSubview(photoButton)
        return photoButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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

