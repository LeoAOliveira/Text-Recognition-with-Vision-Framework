//
//  TextRecognition.swift
//  TextRecognitionWithVision
//
//  Created by Paula Leite on 23/09/20.
//

import UIKit
import Vision

internal class TextRecognition {
    private var currentBuffer: CVPixelBuffer?
    private var results: [VNRecognizedTextObservation]?
    private var image: CIImage?
    private var requestHandler: VNImageRequestHandler?
    private var resultTextRecognition = String()
    
    private lazy var textRecognitionRequest: VNRecognizeTextRequest = {
        let textRecognition = VNRecognizeTextRequest(completionHandler: recognizeTextHandler)
        textRecognition.recognitionLanguages = ["pt-BR", "en-US"]
        textRecognition.usesLanguageCorrection = true
        textRecognition.recognitionLevel = .accurate
        textRecognition.usesCPUOnly = true
        return textRecognition
    }()
    
    func imageRequest(toImage image: UIImage) -> String {
        if let ciImage = CIImage(image: image) {
            requestHandler = VNImageRequestHandler(ciImage: ciImage, options: [:])
            
            performOCRRequest()
        } else {
            textRecognitionRequest.cancel()
            requestHandler = nil
        }
        
        return resultTextRecognition
    }
    
    func performOCRRequest() {
        do {
            try self.requestHandler?.perform([self.textRecognitionRequest])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /**
     We obtain the results that the text recognition request aquires, and prints them.
     - Parameter request: the actual request being made;
     - Parameter error: error that might happen.
     */
    func recognizeTextHandler(request: VNRequest, error: Error?) {
        self.results = self.textRecognitionRequest.results as? [VNRecognizedTextObservation]
        
        if let results = self.results {
            var transcript: String = ""
            for observation in results {
                transcript.append(observation.topCandidates(1)[0].string)
                transcript.append(" ")
            }
            resultTextRecognition = transcript
        }
    }
}
