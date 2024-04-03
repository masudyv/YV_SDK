//
//  WebViewController.swift
//  
//
//  Created by Masud Onikeku on 18/07/2023.
//

import UIKit
import WebKit

@available(iOS 13.0, *)
public class WebViewController: UIViewController, WKNavigationDelegate {
    
    var url = ""
    let webViewUnderlay = UIView()
    let loadView2 = UIView()
    let arrow = UIImageView()
    var webView = WKWebView()
    var gotResponse = false
    var option : Options? = nil
    
    var yvosContoller : YVOSViewController? = nil
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        webView(url: url)
        
        for view in self.navigationController!.viewControllers {
            
            if let view = view as? YVOSViewController {
                
                yvosContoller = view
            }
        }
    }
    
    @objc func goBack() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func webView(url: String) {
        
        self.view.addSubview(webViewUnderlay)
        
        webViewUnderlay.backgroundColor = .white
        
        webViewUnderlay.alpha = 0
        
        //UIManipulation.shadowBorder(view: inputView2)
        
        webViewUnderlay.constraint(equalToTop: self.view.topAnchor, equalToBottom: self.view.bottomAnchor, equalToLeft: self.view.leadingAnchor, equalToRight: self.view.trailingAnchor)
        
        UIView.animate(withDuration: 0.2, animations: {self.webViewUnderlay.alpha = 1})
        
        let web : WKWebView = {
            
            let source = """
    window.addEventListener('message', function(e) {
        window.webkit.messageHandlers.iosListener.postMessage(JSON.stringify(e.data));
    });
    """
            let script = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
            
            let contentController = WKUserContentController()
            let config = WKWebViewConfiguration()
            config.userContentController = contentController
            config.userContentController.addUserScript(script)
            
            contentController.add(self,name: "iosListener")
            
            if #available(iOS 13.0, *) {
                
                let prefs = WKWebpagePreferences()
                config.defaultWebpagePreferences = prefs
                config.allowsInlineMediaPlayback = true
                
                if #available(iOS 14.0, *) {
                    prefs.allowsContentJavaScript = true
                } else {
                    // Fallback on earlier versions
                    
                }
            }
            
            webView = WKWebView(frame: .zero, configuration: config)
            return webView
            
        }()
        
        web.navigationDelegate = self
        
        webViewUnderlay.addSubview(web)
        web.constraint(equalToTop: webViewUnderlay.topAnchor, equalToBottom: webViewUnderlay.bottomAnchor, equalToLeft: webViewUnderlay.leadingAnchor, equalToRight: webViewUnderlay.trailingAnchor, paddingTop: 12)
        
        webViewUnderlay.addSubview(loadView2)
        loadView2.alpha = 0
        loadView2.constraint(height: 70)
        loadView2.centre(centerX: webViewUnderlay.centerXAnchor, centreY: webViewUnderlay.centerYAnchor)
        loadView2.backgroundColor = .white
        UIView.animate(withDuration: 0.3, animations: {self.loadView2.alpha = 1})
        loadView2.shadowBorder()
        
        
        let arrow = UIImageView()
        
        if #available(iOS 13.0, *) {
            
            arrow.image = UIImage(systemName: "arrow.clockwise")
            
        } else {
            
            arrow.image = UIImage(named: "arrow.clockwise")
            
        }
        loadView2.addSubview(arrow)
        arrow.constraint(equalToLeft: loadView2.leadingAnchor, paddingLeft: 16, width: 40, height: 40)
        arrow.centre(centreY: loadView2.centerYAnchor)
        arrow.tintColor = .darkGray
        
        let loading = UILabel()
        loadView2.addSubview(loading)
        loading.constraint(equalToLeft: arrow.trailingAnchor, equalToRight: loadView2.trailingAnchor, paddingLeft: 16, paddingRight: 16)
        loading.centre(centreY: arrow.centerYAnchor)
        loading.font = UIFont(name: "Roboto-Regular", size: 14)
        loading.text = "Loading..."
        loading.textColor = .darkGray
        
        let url2 = URL(string: url)
        web.load(URLRequest(url: url2!))
        
        
    }
    
    @objc func dismissWebView() {
        
        UIView.animate(withDuration: 0.2, animations: {self.webViewUnderlay.alpha = 0}, completion: {_ in
            self.webViewUnderlay.removeFromSuperview()
        })
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIView.animate(withDuration: 0.3, animations: {self.loadView2.alpha = 0}, completion: {ss in
            
            self.loadView2.removeFromSuperview()
        })
        
        /*self.webView.evaluateJavaScript("window.webkit.messageHandlers.iosListener.postMessage('test');", completionHandler: { (result, err) in
            if (err != nil) {
                // show error feedback to user.
                print(err)
            }
        })*/
        //print("ok")
    }
    
    func handleVformsResult(dict: [String:Any]?) {
        
        //let data = message.data(using: .utf8)!
        var result : VFormResultData? = nil
        
        if let data = dict, data["id"] as! String == FormResultType.COMPLETED.rawValue {
            
            let res = data.toVformsResultData()
            result = res
            let dt : BaseResult? = res?.data?.entry
            yvosContoller?.resultData = dt
            print(dt!)
        }
        
        if let id = result?.id {
            if id.contains(FormResultType.COMPLETED.rawValue) {
                
                if let result = result {
                    
                    let opt = option as! vFormOptions
                    opt.onCompleted(result.data?.entry)
                }
                return
            }
            
            if id.contains(FormResultType.SUCCESS.rawValue) {
                if let result = result {
                    
                    let opt = option as! vFormOptions
                    opt.onSuccess(result.data?.entry)
                }
                return
            }
            
            if id.contains(FormResultType.FAILURE.rawValue) {
                if let result = result {
                    
                    let opt = option as! vFormOptions
                    opt.onFailed(result.data?.entry)
                }
                return
            }
        }
    }
    
    func handleDocuResult(dict: [String:Any]?) {
        
        //let data = message.data(using: .utf8)!
        var result : DocumentResultData? = nil
        if let data = dict, data["id"] as! String == DocumentResultType.SUCCESS.rawValue {
            
            let res = data.toDocumentResultData()
            result = res
            let dt : BaseResult? = res?.data
            yvosContoller?.resultData = dt
            print(dt!)
        }
        
        if let id = result?.id {
            
            if id.contains(DocumentResultType.SUCCESS.rawValue) {
                
                if let result = result {
                    
                    let opt = option as! DocumentOptions
                    opt.onSuccess(result.data)
                }
                return
            }
            
            if id.contains(DocumentResultType.CLOSED.rawValue) || id.contains(DocumentResultType.CANCELLED.rawValue) {
                if let result = result {
                    
                    let opt = option as! DocumentOptions
                    opt.onSuccess(result.data)
                }
                return
            }
            
        }
    }
    
    func handleLivenessResult(dict: [String:Any]?) {
        //print(message)
        
        var result : LivenessResultData? = nil
        
        if let data = dict, data["id"] as! String == LivenessResultType.SUCCESS.rawValue {
            
            let res = data.toLivenessResultData()
            result = res
            let dt : BaseResult? = res?.data
            yvosContoller?.resultData = dt
            print(dt!)
        }
        
        
        
        if let id = result?.id {
            
            if id.contains(LivenessResultType.SUCCESS.rawValue) {
                if let result = result {
                    
                    let opt = option as! LivenessOptions
                    opt.onSuccess(result.data)
                }
                return
            }
            
            if id.contains(LivenessResultType.FAILED.rawValue) {
                if let result = result {
                    
                    let opt = option as! LivenessOptions
                    opt.onFailure(result.data)
                }
                return
            }
            
            if id.contains(LivenessResultType.CANCELLED.rawValue) {
                
                if id.contains(LivenessResultType.CLOSED.rawValue) {
                    
                    if let result = result {
                        
                        let opt = option as! LivenessOptions
                        opt.onClosed(result.data)
                    }
                    return
                }
                
                if id.contains(LivenessResultType.RETRY.rawValue) {
                    
                    if let result = result {
                        
                        let opt = option as! LivenessOptions
                        opt.onRetry(result.data)
                    }
                    return
                }
                
            }
        }
    }
    
    
}


extension WebViewController : WKScriptMessageHandler {
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if(message.name == "iosListener") {
            if let message = message.body as? String {
                
                var dict : [String:Any]? = nil
                
                let data = message.data(using: .utf8)!
                
                do {
                    let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [String:Any]
                    dict = jsonArray
                    
                } catch {
                    print("error: \(error)")
                    
                    return
                    
                }
                
                switch option?.info {
                    
                case is VFormsInfo : handleVformsResult(dict: dict)
                case is LivenessPersonalInfo : handleLivenessResult(dict: dict)
                case is DocumentPersonalInfo : handleDocuResult(dict: dict)
                default : print("")
                }
            }
        }
    }
    
    
    
}
