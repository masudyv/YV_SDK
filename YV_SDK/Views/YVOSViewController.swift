//
//  YVOSViewController.swift
//  
//
//  Created by Masud Onikeku on 01/06/2023.
//

import UIKit
import SafariServices
import BlinkID
import Vision
import VisionKit
//import RegulaCommon
//import FaceSDK



public class YVOSViewController: UIViewController {
    
    var blinkIdMultiSideRecognizer : MBBlinkIdMultiSideRecognizer?
    
    let back = UIView()
    let loader = UIActivityIndicatorView()
    var options : Options? = nil
    var refOptions : Options? = nil
    
    let viewModel = ViewModel()
    var id = ""
    var formUrl = ""
    
    var resultData : BaseResult? = nil
    
    public var vformOptions : vFormOptions? = nil
    public var livenessOptions : LivenessOptions? = nil
    public var documentOptions : DocumentOptions? = nil
    
    var image : UIImage? = nil
    
    public init(vformOptions: vFormOptions?) {
        
        self.vformOptions = vformOptions
        self.options = vformOptions
        super.init(nibName: nil, bundle: nil)
    }
    
    public init(livenessOptions: LivenessOptions?) {
        
        self.livenessOptions = livenessOptions
        self.options = livenessOptions
        super.init(nibName: nil, bundle: nil)
    }
    
    public init(documentOptions: DocumentOptions?) {
        
        self.documentOptions = documentOptions
        self.options = documentOptions
        super.init(nibName: nil, bundle: nil)
    }
    
    public init(options: Options?) {
        
        self.options = options
        
        if let options = options {
            
            if options.info is VFormsInfo {
                
                self.vformOptions = vFormOptions(vFormId: options.vFormId!, publicMerchantKey: options.publicMerchantKey, personalInfo: options.info! as? VFormsInfo)
            }else if options.info is LivenessPersonalInfo {
                self.livenessOptions = LivenessOptions(publicMerchantKey: options.publicMerchantKey, appearance: options.appearance, personalInfo: options.info as? LivenessPersonalInfo)
                
            }else if options.info is DocumentPersonalInfo {
                
                self.documentOptions = DocumentOptions(publicMerchantKey: options.publicMerchantKey, appearance: options.appearance, personalInfo: options.info as? DocumentPersonalInfo)
            }
            
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setup()
        
        
        if options?.vFormId != nil {
            bindings()
            
        }else {
            
            //configure()
            
        }
        
        /*let text = "{\"id\":\"yvos:liveness:success\",\"data\":{\"passed\":true,\"photo\":\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAPoAAADICAYAAADBXvybAAAAAXNSR0IArs4c6QAAAERlWElmTU0AKgAAAAgAAYdpAAQAAAABAAAAGgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAA+qADAAQAAAABAAAAyAAAAAB2lQbVAABAAElEQVR4AVTdWa9l63rY9Vm1ulpVtZvTx3Z6OwQSiUikMekc0kAuUBRxxy3KZ4Dr+hqIW67gggsUIQJEAqTQRCgBxcQoBMfxsX18jvfZbTWrVjX8f88zx94nY9WsOecY7/v03duMMR88+4//6vvL69vT+/cXp+vrR6c+nO7v70+OD55+eHr16s3p1d396f2D96c3b9+cTg8enh4+vDzdPHpy+uzzn56urk6n68v6nR6eHtTm3bt3p7u7u85dnx4/fnR6/vz56eGDB8GtxQXwb04XlxenB+8CFa5HN09Or1+/qd/708XFw9OLly9PV9Hz9t2DgbX96tiHd73evn17enP/uvfXp5vHt6d3wbi4eHB6/uKLaL07PXn6Qd8vw381sG4fPTrdvXtz+urlq+iPiAcX0f+wtq9OH37w4ent/ZvT7e1t31+f3r99lwyuh/93796e7l89Pz168uHp+iY8XfN68+ZNPLw/XQb//u396ca1eH4Xjnd9v6r/XfJyXMbww2h5EM6XL+9O98G8vr6s72U8x8P7d3Pu8uJ62r++T24XF6e3yeN9fH78nW+fPvviy2QcL9H3+s19fa+TzfvTzdX14H0bTZEzcsDXu/RDJp999bzr708fffRxdL053VzfDF8Po+lNPL/v3OXV0vGtj759+uLTz06PHl2n3uQeTEAvomWOdAb3TbKkyjf3r0aObOZhvF1ePTy9TiddOt0++uD0pr4Ps4W77OigCb/k+OZNsNPjVfS/eU1elyM7NvEu\"}}"
        
        let data = text.data(using: .utf8)!
        
        do {
            let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [String:AnyObject]
            print(jsonArray)
            
        } catch let error as NSError {
            print(error)
            return
        }*/
        blinkInit()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.modalPresentationStyle = .fullScreen
    }
    
    
    func blinkInit() {
        
        //MBMicroblinkSDK.shared().set
        
        //var blinkIdMultiSideRecognizer : MBBlinkIdMultiSideRecognizer?
        let license = Bundle.module.url(forResource: "Blinkid_license_ios", withExtension:"key")!
        let data = NSData(contentsOf: license)
        
        let lic = data!.base64EncodedString()
        /*MBMicroblinkSDK.shared().setLicenseKey("sRwCAA1jb20ubG9jYWxob3N0AWxleUpEY21WaGRHVmtUMjRpT2pFMk9UVXhNamN3TkRjd056VXNJa055WldGMFpXUkdiM0lpT2lJME4ySmxNRFZrWXkxbE9HVTFMVFEzWkdZdFlUSXhZaTAzTkdWaFlqbGxZbVkwWTJRaWZRPT0VrWcASdt60Nk5ZeLlawQop5lIwbHtuXSodzuBSgmBS81QNDYH1cQuJhNBr+4ArPpcR5dacjz8PutpfmpLcnlKBMGbEbPm+1Yr+faYILQF+4l5AFc2+gV0F/MC1IJMf7LNgvvs3jlo40dTlPS8i4hFYYlVPKvSqKkXpoG+hXt5nQ==", andLicensee: "com.localhost", errorCallback: { error in
            
            print(error)
        })*/
        MBMicroblinkSDK.shared().setLicenseResource("Blinkid_license_ios", withExtension: "key", inSubdirectory: nil, for: Bundle.module, andLicensee: "co.youverify.YouID.YouID", errorCallback: {[weak self] error in
            
            print(error)
        })
        
        //MBMicroblinkSDK.shared().set
        
        /*MBMicroblinkSDK.shared().setLicenseKey("sRwAAAEYY28ueW91dmVyaWZ5LllvdUlELllvdUlEn1/30NfZN4aSi2UXSb/z7Ph4FY+MLBW18p19eWhMWo1SOgFmuUVdOF2e4aWFNx9rBsW6s6T07k7LwxCn481gsomXo4JCPLmXKJeNH187D4/QjQje5zonvm21+BLIWliuahDccYp1+/cFvtaeCCL8t0NsbrNeOFrdEDclAmk3At9tjOgQsInP9CyJyaFzUOj2Uqa7uvQf6VssYbjt9KqKxPV5N2eZ", anda errorCallback: {[weak self] error in
            
            print(error)
        })*/
    }
    
    func bindings() {
        
        viewModel.AccessResponse.bind(completion: {[weak self] response in
            
            DispatchQueue.main.async {
                self?.loader.removeProperly()
                
            }
            if let response = response {
                
                if let accessResp = response.object as? AccessPointResponse {
                    
                    self?.id = accessResp.data.id ?? ""
                    
                    if let options = self?.options {
                        
                        if options.info is VFormsInfo {
                            
                            
                            if self!.validate(key: options.publicMerchantKey, formId: options.vFormId!) {
                                
                                if let info = options.info as? VFormsInfo {
                                    
                                    if let name = info.firstName, name != "" {
                                        
                                        DispatchQueue.main.async {
                                            self?.showWelcomeDialog(options: options)
                                        }
                                        
                                    }else {
                                        
                                        let baseUrl = Constants.prodUrl //options.dev ? Constants.devUrl : Constants.prodUrl
                                        let formUrl = "\(baseUrl)/v-forms/\(options.vFormId)?accessId=\(accessResp.data.id)"
                                        self?.openFormWeb(url: formUrl)
                                        
                                    }
                                }
                                
                            }else {
                                DispatchQueue.main.async {
                                    self?.showAlert(msg: "Please check merchant id and template id")
                                }
                            }
                        }
                    }
                }else {
                    
                    if !response.check {
                        
                        DispatchQueue.main.async {
                            self?.back.removeProperly()
                            //self?.showAlert(msg: response.description)
                            
                            if let code = response.object as? Int {
                                
                                if String(code).contains("4") {
                                    self?.showAlert(msg: "Template not found")
                                }
                            }
                        }
                    }
                }
            }
        })
        
        //
    }
    
    
    func openSafari(url: String) {
        
        if validate(key: options!.publicMerchantKey) {
            
            showWelcomeDialog(options: options!)
        }
    }
    
    private func setup() {
        
        let close = UILabel()
        self.view.addSubview(close)
        close.text = "CLOSE"
        close.font = UIFont.boldSystemFont(ofSize: 12)
        close.textColor = .black
        close.isUserInteractionEnabled = true
        close.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeSdk)))
        close.constraint(equalToTop: self.view.topAnchor, equalToLeft: self.view.leadingAnchor, paddingTop: 120, paddingLeft: 32)
        
        let reg = HomeView()
        //reg.button.addTarget(self, action: #selector(openWeb), for: .touchUpInside)
        self.view.backgroundColor = .white
        self.view.addSubview(reg)
        reg.centre(centerX: self.view.centerXAnchor, centreY: self.view.centerYAnchor)
        
        reg.vForms.addTarget(self, action: #selector(openVForms), for: .touchUpInside)
        reg.documentCapture.addTarget(self, action: #selector(openDocumentCapture), for: .touchUpInside)
        reg.livenessCheck.addTarget(self, action: #selector(openLivenessCheck), for: .touchUpInside)
        
        let data = UIButton()
        view.addSubview(data)
        data.constraint(equalToBottom: view.bottomAnchor, paddingBottom: 70, width: 250, height: 50)
        data.centre(centerX: view.centerXAnchor)
        data.layer.cornerRadius = 12
        data.setTitle("Display Data", for: .normal)
        data.backgroundColor = .black
        data.tintColor = .white
        data.titleLabel?.textColor = .white
        data.setTitleColor(.white, for: .normal)
        data.addTarget(self, action: #selector(DisplayData), for: .touchUpInside)
        
    }
    
    @objc func DisplayData() {
        
        //self.navigationController?.dismiss(animated: true)
        if let data = self.resultData {
            
            let vc = DataViewController()
            vc.data = data
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            
            self.showAlert(msg: "No data to display yet")
        }
    }
    
    @objc func closeSdk() {
        
        self.navigationController?.dismiss(animated: true)
    }
    
    func openFormWeb(url: String) {
        
        /*if let url = URL(string: url) {
         
         let vc = SFSafariViewController(url: url)
         vc.modalPresentationStyle = .fullScreen
         self.present(vc, animated: true)
         }*/
        
        let vc = WebViewController()
        vc.url = url
        vc.option = self.refOptions
        self.navigationController?.pushViewController(vc, animated: true)
        back.removeProperly()
        
    }
    
    @objc func openVForms() {
        
        showLoader(back: back, loader: loader)
        
        if options?.vFormId != nil {
            
            var options = self.options!
            if self.options?.info is VFormsInfo {
                
                var formOptions = vFormOptions(vFormId: options.vFormId!, publicMerchantKey: options.publicMerchantKey, appearance: options.appearance, personalInfo: nil)
                formOptions.info = self.options?.info as! VFormsInfo
                options.info = self.options?.info as! VFormsInfo
                self.refOptions = formOptions
                let info = formOptions.info as! VFormsInfo
                let request = AccessPointRequest(businessId: formOptions.publicMerchantKey, details: info != nil ? UserDetail(firstName: info.firstName, lastName: info.lastname, middleName: info.middleName, email: info.email, mobile: info.phone, gender: info.gender?.rawValue) : nil, templateId: formOptions.vFormId!)
                viewModel.requestFormId(dev: options.dev, body: request)
                
                //UserDetail()
            }else {
                
                var formOptions = vFormOptions(vFormId: options.vFormId!, publicMerchantKey: options.publicMerchantKey, appearance: options.appearance, personalInfo: nil)
                
                
                options.info = VFormsInfo(firstName: options.info?.firstName ?? nil, lastname: nil, middleName: nil, email: nil, phone: nil)
                let info = options.info as! VFormsInfo
                formOptions.info = options.info as! VFormsInfo
                self.refOptions = formOptions
                let request = AccessPointRequest(businessId: formOptions.publicMerchantKey, details: info != nil ? UserDetail(firstName: info.firstName ?? nil, lastName: info.lastname ?? nil, middleName: info.middleName ?? nil, email: info.email ?? nil, mobile: info.phone ?? nil, gender: info.gender?.rawValue ?? nil) : nil, templateId: formOptions.vFormId!)
                viewModel.requestFormId(dev: options.dev, body: request)
            }
            
            
            
            
        }else {
            
            back.removeProperly()
            refOptions = self.options
            showAlert(msg: "A VForm id is needed to use VForms")
        }
        
        
    }
    
    @objc func openLivenessCheck() {
        
        if let options = self.options {
            
            var liveOptions = LivenessOptions(publicMerchantKey: options.publicMerchantKey, appearance: options.appearance, personalInfo: nil)
            
            options.info = LivenessPersonalInfo(firstName: options.info?.firstName ?? "")
            liveOptions.info = LivenessPersonalInfo(firstName: options.info?.firstName ?? "")
           
            self.refOptions = liveOptions
            
            back.backgroundColor = .white
            view.addSubview(back)
            back.constraint(equalToTop: view.topAnchor, equalToBottom: view.bottomAnchor, equalToLeft: view.leadingAnchor, equalToRight: view.trailingAnchor)
            
            if validate(key: liveOptions.publicMerchantKey) {
                
                showWelcomeDialog(options: liveOptions)
            }else {
                self.showAlert(msg: "Merchant Key is invalid")
            }
            //showWelcomeDialog(options: options)
        }
    }
    
    @objc func openDocumentCapture() {
        
        if let options = self.options {
            var docOptions = DocumentOptions(publicMerchantKey: options.publicMerchantKey, appearance: options.appearance, personalInfo: nil)
            docOptions.personalInfo = DocumentPersonalInfo(firstName: options.info?.firstName ?? "")
            options.info = DocumentPersonalInfo(firstName: options.info?.firstName ?? "")
            self.refOptions = docOptions
            back.backgroundColor = .white
            view.addSubview(back)
            back.constraint(equalToTop: view.topAnchor, equalToBottom: view.bottomAnchor, equalToLeft: view.leadingAnchor, equalToRight: view.trailingAnchor)
            if validate(key: docOptions.publicMerchantKey) {
                
                showWelcomeDialog(options: docOptions)
            }else {
                self.showAlert(msg: "Merchant Key is invalid")
            }
        }
    }
    
    @objc func closeBack() {
        
        back.removeProperly()
        self.refOptions = self.options
    }
    
    func showWelcomeDialog(options: Options) {
        
        let xmark = UIImageView()
        if #available(iOS 13.0, *) {
            
            xmark.image = UIImage(systemName: "xmark")
        } else {
            // Fallback on earlier versions
        }
        xmark.tintColor = .black
        back.addSubview(xmark)
        xmark.constraint(equalToTop: back.topAnchor, equalToRight: back.trailingAnchor, paddingTop: 120, paddingRight: 32, width: 20, height: 20)
        xmark.isUserInteractionEnabled = true
        xmark.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeBack)))
        
        var nameString = ""
        
        if let info = options.info as? VFormsInfo {
            
            nameString = (info.firstName ?? "") + " " + (info.lastname ?? "")
            
        }else if let info = options.info as? LivenessPersonalInfo {
            
            nameString = info.firstName!
            
            
        }else if let info = options.info as? DocumentPersonalInfo {
            
            nameString = info.firstName!
        }
        
        let name = UILabel()
        name.text = "Hey, \(nameString)"
        name.textAlignment = .left
        name.textColor = .black
        name.font = UIFont.boldSystemFont(ofSize: 15)
        
        let description = UILabel()
        description.text = options.appearance?.greeting ?? ""
        description.textColor = .black
        description.font = UIFont.boldSystemFont(ofSize: 10)
        description.numberOfLines = 0
        description.textAlignment = .left
        
        let btn = UIButton()
        btn.setTitle(options.appearance?.actionText ?? "", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        btn.titleLabel?.textColor = options.appearance?.bTnTextColor ?? .white
        btn.constraint(height: 40)
        btn.layer.cornerRadius = 8
        btn.backgroundColor = options.appearance?.btnBackgroundColor ?? .black
        btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [name,description, btn])
        stack.spacing = 16
        stack.axis = .vertical
        
        back.addSubview(stack)
        stack.constraint(equalToLeft: back.leadingAnchor, equalToRight: back.trailingAnchor, paddingLeft: 32, paddingRight: 32)
        stack.centre(centreY: back.centerYAnchor)
        
    }
    
    @objc func btnAction() {
        
        let baseUrl = Constants.prodUrl //options!.dev ? Constants.devUrl : Constants.prodUrl
        if self.options!.info is VFormsInfo {
            
            print(id)
            
            let formUrl = "\(baseUrl)/v-forms/\(options!.vFormId!)?accessId=\(id)"
            openFormWeb(url: formUrl)
        }else {
            
            var url = ""
            var colorString = ""
            let countries = ""
            
            let color = "#FFFFFF"
            do {
                let data = color.data(using: String.Encoding.ascii)
                colorString = data!.base64EncodedString()
                
            } catch  {
                print(error.localizedDescription)
            }
            
            
            
            switch options!.info {
                
            case is LivenessPersonalInfo : url = "\(baseUrl)/services/\(options!.publicMerchantKey)/liveness" //openEmotionCheck() //url = "\(baseUrl)/services/\(options!.publicMerchantKey)/liveness"
            case is DocumentPersonalInfo : url = "\(baseUrl)/services/\(options!.publicMerchantKey)/document?countries=\(countries)&primaryColor=\(colorString)" //startvisionScan() //startScan() //openBlinkId() //
            default : ""
            }
            print(url)
            if let curl = URL(string: url) {
                
                /*let vc = SFSafariViewController(url: url)
                 //vc.modalPresentationStyle = .fullScreen
                 self.navigationController?.pushViewController(vc, animated: true)*/
                openFormWeb(url: url)
            }
        }
        
        
    }
    
    func startvisionScan() {
        
        let vc = VNDocumentCameraViewController()
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    func openEmotionCheck() {
        
        let vc = EmotionViewController()
        vc.refImage = image!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openBlinkId() {
        
        if #available(iOS 13.0, *) {
            let vc = DocViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            // Fallback on earlier versions
        }
       
        
    }
    
    @objc func showFormWeb() {
        
        if let options = vformOptions {
            
            let baseUrl = options.dev ? Constants.devUrl : Constants.prodUrl
            let formUrl = "\(baseUrl)/v-forms/\(options.vFormId)?accessId=\(id)"
            openFormWeb(url: formUrl)
            
        }
    }
    
    func validate(key: String, formId: String) -> Bool {
        
        if key.isEmpty || key.count != Constants.idLength || formId.isEmpty || formId.count != Constants.idLength {
            
            return false
        }else {
            
            return true
        }
        
    }
    
    func validate(key: String) -> Bool {
        
        if key.isEmpty || key.count != Constants.idLength  {
            
            return false
        }else {
            
            return true
        }
        
    }
}

@available(iOS 13.0, *)
extension YVOSViewController : MBBlinkIdOverlayViewControllerDelegate {
    public func blinkIdOverlayViewControllerDidFinishScanning(_ blinkIdOverlayViewController: MBBlinkIdOverlayViewController, state: MBRecognizerResultState) {
        //
        print(state)
        print(blinkIdMultiSideRecognizer?.result)
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    public func blinkIdOverlayViewControllerDidTapClose(_ blinkIdOverlayViewController: MBBlinkIdOverlayViewController) {
        //
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

extension YVOSViewController : VNDocumentCameraViewControllerDelegate {
    
    public func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        
       let images = extractImages(from: scan)
        let text = recognizeText(from: images)
        print(text)
        
    }
    
    func extractImages(from scan: VNDocumentCameraScan) -> [CGImage] {
        var extractedImages = [CGImage]()
        for index in 0..<scan.pageCount {
            let extractedImage = scan.imageOfPage(at: index)
            guard let cgImage = extractedImage.cgImage else { continue }
            
            extractedImages.append(cgImage)
        }
        return extractedImages
    }
    
    func recognizeText(from images: [CGImage]) -> String {
        var entireRecognizedText = ""
        let recognizeTextRequest = VNRecognizeTextRequest { (request, error) in
            guard error == nil else { return }
            
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            
            let maximumRecognitionCandidates = 1
            for observation in observations {
                guard let candidate = observation.topCandidates(maximumRecognitionCandidates).first else { continue }
                
                entireRecognizedText += "\n\(candidate.string)\n"
                
            }
        }
        recognizeTextRequest.recognitionLevel = .accurate
        
        for image in images {
            let requestHandler = VNImageRequestHandler(cgImage: image, options: [:])
            
            try? requestHandler.perform([recognizeTextRequest])
        }
        
        return entireRecognizedText
    }
}
