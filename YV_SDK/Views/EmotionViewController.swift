//
//  EmotionViewController.swift
//  
//
//  Created by Masud Onikeku on 28/08/2023.
//

import UIKit

class EmotionViewController: UIViewController {
    
    var refImage : UIImage? = nil
    let text = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
        var predictionManager = PredictionManager()
        
        //guard let img = UIImage(named: "") else {print("photo don't exist"); return}
        let image = UIImageView(image: refImage!)
        
        
        let monoImage = refImage!.mono
        
        predictionManager.classification(for: monoImage){(result) in
            DispatchQueue.main.async {
                [weak self] in
                self?.text.text = result
                print(result)
            }
        }
        
    }
    
    func setup() {
        
        view.backgroundColor = .white
        
        let iv = UIImageView()
        iv.image = refImage
        self.view.addSubview(iv)
        iv.constraint(width: 300, height: 300)
        iv.centre(centerX: view.centerXAnchor, centreY: view.centerYAnchor)
        
        text.font = UIFont.systemFont(ofSize: 14)
        text.textColor = .black
        view.addSubview(text)
        text.constraint(equalToTop: iv.bottomAnchor, equalToLeft: view.leadingAnchor, equalToRight: view.trailingAnchor)
        text.textAlignment = .center
        
    }
    
}

extension UIImage {
    
    var mono: UIImage {
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: "CIPhotoEffectMono")!
        currentFilter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        let output = currentFilter.outputImage!
        let cgImage = context.createCGImage(output, from: output.extent)!
        let processedImage = UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        return processedImage
    }
}
