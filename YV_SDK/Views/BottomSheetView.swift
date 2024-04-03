//
//  SwiftUIView 2.swift
//  
//
//  Created by Adewale Sanusi on 25/05/2023.
//

import SwiftUI

@available(iOS 13.0, *)
public struct BottomSheetView: View {
    
    public init() {}
    
    @State private var name = "Adewale"
    @State private var isShowingWebView: Bool = false
    
    public var body: some View {
        ZStack {
            // MARK: Outer Rounded Rectangle
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.blue, lineWidth: 0.6)
                .frame(height: 300)
                .padding()
            
            
            VStack(spacing: 30) {
                HStack {
                    Text("Hello")
                        .font(.title)
                        .foregroundColor(.purple)
                    
                    Text(name + "!")
                        .font(.title)
                }
                
                
                Button(action: {isShowingWebView = true}){
                    Text("Liveness Check")
                }.sheet(isPresented: $isShowingWebView) {
                    WebView(url: URL(string:"https://os.dev.youverify.co/v-forms/644933b8c451436821dac571")!)
                }
                
            }
        }
    }
}
