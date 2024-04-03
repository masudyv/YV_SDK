//
//  File.swift
//  
//
//  Created by Adewale Sanusi on 14/05/2023.
//

import Foundation
import UIKit
import SwiftUI
import WebKit

@available(iOS 13.0, *)
public struct WebView: UIViewRepresentable {
    public let url: URL
    // Creates the view to be displayed
    public func makeUIView(context: Context) -> some UIView {
        let webView = WKWebView()
        let request = URLRequest (url: url)
        webView.load(request)
        return webView
    }
    
    // Updates the created view with necessary data
    public func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

@available(iOS 13.0, *)
public struct SwiftuiView : UIViewRepresentable {
    
    public let frame: CGRect
    
    public func makeUIView(context: Context) -> some UIView {
        return RegularView(frame: frame)
    }
    
    // Updates the created view with necessary data
    public func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
}


