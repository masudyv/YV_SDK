//
//  SwiftUIView.swift
//  
//
//  Created by Adewale Sanusi on 14/05/2023.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
public struct SwiftUIView: View {
    
    // This is required to initialise the struct
    public init() {}
    
    @State private var isShowingWebView: Bool = false
    
    public var body: some View {
        Text("Liveness-Check")
            .padding()
        
        Button {
            isShowingWebView = true
        } label: {
            Text("Launch Liveness-Check")
            
        }
        .buttonStyle(.borderless)
        .sheet(isPresented: $isShowingWebView) {
            WebView(url: URL(string:"https://os.dev.youverify.co/v-forms/644933b8c451436821dac571")!)
        }
        
    }
}

