//
//  SwiftUIView 2.swift
//  
//
//  Created by Adewale Sanusi on 18/05/2023.
//

import SwiftUI
import Foundation

@available(iOS 13.0, *)
public struct LivenessCheck: View {
    
    public init() {}
    
    @State private var isShowingWebView: Bool = false
    
    public var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

/*
@available(iOS 13.0, *)
public struct SwiftUIView: View {
    
    // This is required to initialise the struct
    public init() {}
    
    @State private var isShowingWebView: Bool = false
    
    public var body: some View {
        Text("Welcome!")
        Button {
            isShowingWebView = true
        } label: {
            Text("Launch Vforms")
        }
        .buttonStyle(.borderless)
        .sheet(isPresented: $isShowingWebView) {
            WebView(url: URL(string:"https://os.dev.youverify.co/v-forms/644933b8c451436821dac571")!)
        }
        
    }
}
*/
