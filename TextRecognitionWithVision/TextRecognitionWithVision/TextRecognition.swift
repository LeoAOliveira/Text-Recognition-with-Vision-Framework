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
    
    /**
     With the image that the user sends, this function transforms this image into a CIImage and creates the requestHandler, calling another function, performOCRRequest(). If the image can't be converted into a CIImage, the text recognition request is canceled. The result of the request, our string, is then returned.
     - Parameter image: the image that the user requested be recognized.
     - Returns: A String with the result of the text recognition.
     */
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
    
    /**
     With the requestHandler that was executed in the function imageRequest, this function executes the textRecognitionRequest. If it does not work, it will return the error with the localize description.
     */
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
