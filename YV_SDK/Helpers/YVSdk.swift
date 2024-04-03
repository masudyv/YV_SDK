//
//  File.swift
//  
//
//  Created by Masud Onikeku on 18/07/2023.
//

import Foundation
import UIKit

@available(iOS 13.0, *)
public class YVSdk {
    
    
    var options : Options?
    var selfVC: UIViewController
    var vc: YVOSViewController? = nil
    
    public var image : UIImage? = nil
    
    public init(options: Options, selfVC : UIViewController) {
        
        self.options = options
        self.selfVC = selfVC
        switch options {
            
        case is vFormOptions:  self.vc = YVOSViewController(vformOptions: options as? vFormOptions)
        case is LivenessOptions: self.vc = YVOSViewController(livenessOptions: options as? LivenessOptions)
        case is DocumentOptions: self.vc = YVOSViewController(documentOptions: options as? DocumentOptions)
            
        default: self.vc = YVOSViewController(options: options)
        }
        
    }
    
    public func initialize() {
        
        if let op = options {
            
            if op.info is VFormsInfo && (op.vFormId == nil || op.vFormId == "") {
                print("A Vform ID is needed to use VForms, please change your \"info\" argument if you don't intend to use Vforms  ")
                return
            }
        }
        vc?.image = image
        let vcc = UINavigationController(rootViewController: vc!)
        //vcc.hidesBarsOnTap = true
        vcc.modalPresentationStyle = .fullScreen
        selfVC.present(vcc, animated: true)
        
    }
}
