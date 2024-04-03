//
//  File.swift
//  
//
//  Created by Masud Onikeku on 13/07/2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(msg: String) {
        
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        let btn = UIAlertAction(title: "OK", style: .default)
        alert.addAction(btn)
        present(alert, animated: true)
    }
    
    func showLoader(back: UIView, loader: UIActivityIndicatorView) {
        
        //let back = UIView()
        if back.superview == nil {
            back.backgroundColor = .white
            view.addSubview(back)
            back.constraint(equalToTop: view.topAnchor, equalToBottom: view.bottomAnchor, equalToLeft: view.leadingAnchor, equalToRight: view.trailingAnchor)
        }
        
        //let loader = UIActivityIndicatorView()
        if loader.superview == nil {
            
            loader.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
            loader.layer.cornerRadius = 8
            loader.startAnimating()
            back.addSubview(loader)
            loader.constraint(width: 80, height: 80)
            loader.centre(centerX: back.centerXAnchor, centreY: back.centerYAnchor)
        }
    }
}
