//
//  DocViewController.swift
//  
//
//  Created by Masud Onikeku on 31/08/2023.
//

import UIKit
import BlinkID

@available(iOS 13.0, *)
class DocViewController: UIViewController {
    
    var blinkIdMultiSideRecognizer : MBBlinkIdMultiSideRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let license = Bundle.module.url(forResource: "Blinkid_license_ios", withExtension:"key")!
        let data = NSData(contentsOf: license)
        
        let lic = data!.base64EncodedString()
        MBMicroblinkSDK.shared().setLicenseKey(lic, errorCallback: { error in
            
            print(error)
        })
        /*MBMicroblinkSDK.shared().setLicenseResource("Blinkid_license_ios", withExtension: "key", inSubdirectory: "", for: Bundle.main, errorCallback: { error in
            
            print(error)
        })*/
        
        startScan()
    }
    
    func startScan() {
        
        self.blinkIdMultiSideRecognizer = MBBlinkIdMultiSideRecognizer()
        
        /** Create BlinkID settings */
        let settings : MBBlinkIdOverlaySettings = MBBlinkIdOverlaySettings()
        
        /** Crate recognizer collection */
        let recognizerList = [self.blinkIdMultiSideRecognizer!]
        let recognizerCollection : MBRecognizerCollection = MBRecognizerCollection(recognizers: recognizerList)
        
        /** Create your overlay view controller */
        let blinkIdOverlayViewController : MBBlinkIdOverlayViewController = MBBlinkIdOverlayViewController(settings: settings, recognizerCollection: recognizerCollection, delegate: self)
        
        /** Create recognizer view controller with wanted overlay view controller */
        let recognizerRunneViewController : UIViewController = MBViewControllerFactory.recognizerRunnerViewController(withOverlayViewController: blinkIdOverlayViewController)!
        
        /** Present the recognizer runner view controller. You can use other presentation methods as well (instead of presentViewController) */
        self.navigationController?.pushViewController(recognizerRunneViewController, animated: true)
        //self.present(recognizerRunneViewController, animated: true, completion: nil)
    }
    
}

@available(iOS 13.0, *)
extension DocViewController: MBBlinkIdOverlayViewControllerDelegate {
    
    func blinkIdOverlayViewControllerDidFinishScanning(_ blinkIdOverlayViewController: MBBlinkIdOverlayViewController, state: MBRecognizerResultState) {
        //
    }
    
    
    func blinkIdOverlayViewControllerDidTapClose(_ blinkIdOverlayViewController: MBBlinkIdOverlayViewController) {
        //
    }
    
    
    
}
