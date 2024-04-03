//
//  File.swift
//  
//
//  Created by Masud Onikeku on 28/08/2023.
//

import Foundation
import UIKit
import CoreML
import Vision

class PredictionManager{
    var emotionModel: MLModel? = nil //classic machine learning model created with createml
    var visionModel: VNCoreMLModel? = nil //Vision Container for Core Ml Model
    
    init(){
        
        if #available(iOS 12.0, *) {
            let bundle = Bundle.module
            let url = bundle.url(forResource: "EmotionClassificator", withExtension: "mlmodelc")!
            self.emotionModel = try? EmotionClassificator(configuration: MLModelConfiguration()).model
            do{
                if let model = self.emotionModel {
                    self.visionModel = try VNCoreMLModel(for: model)
                }
            }catch{
                fatalError("Unable to create Vision Model...")
            }
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    func classification(for image: UIImage, complete: @escaping (String) -> Void){
        if let model = visionModel {
            let request = VNCoreMLRequest(model: model){(request,error) in
                guard error == nil else {complete("Error"); return} //If the model encapsulation doesn't work
                guard let results = request.results as? [VNClassificationObservation], let firstResult = results.first else{complete("No Results"); return} //If the result of conversion isn't saved or the image wasn't classified
                complete(String(format: "%@ %.1f%%", firstResult.identifier, firstResult.confidence * 100)) //Escaping Closure for giving string to write the classification and the confidence
            }
            request.imageCropAndScaleOption = .centerCrop//Considering only the center
            
            guard let ciImage = CIImage(image: image) else {complete("error creating image"); return}
            let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))
            
            //We use CIImage to optimize the image for our handler
            
            DispatchQueue.global(qos: .userInitiated).async {
                let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation!)
                do{
                    try handler.perform([request]) //we will try with an handler to perform the request, if it works, the classification can be done.
                }catch{
                    complete("Failed to perform classification.")
                }
            }
        }
    }
}

