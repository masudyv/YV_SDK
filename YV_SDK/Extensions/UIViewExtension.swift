//
//  File.swift
//  
//
//  Created by Masud Onikeku on 31/05/2023.
//

import Foundation
import UIKit

extension UIView {
    
    
    func constraint (equalToTop: NSLayoutYAxisAnchor? = nil,
                     equalToBottom: NSLayoutYAxisAnchor? = nil,
                     equalToLeft: NSLayoutXAxisAnchor? = nil,
                     equalToRight: NSLayoutXAxisAnchor? = nil,
                     paddingTop: CGFloat = 0,
                     paddingBottom: CGFloat = 0,
                     paddingLeft: CGFloat = 0,
                     paddingRight: CGFloat = 0,
                     width: CGFloat? = nil,
                     height: CGFloat? = nil
    ) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let equalToTop = equalToTop {
            
            topAnchor.constraint(equalTo: equalToTop, constant: paddingTop).isActive = true
        }
        
        if let equalTobottom = equalToBottom {
            
            bottomAnchor.constraint(equalTo: equalTobottom, constant: -paddingBottom).isActive = true
        }
        
        if let equalToLeft = equalToLeft {
            
            leadingAnchor.constraint(equalTo: equalToLeft, constant: paddingLeft).isActive = true
        }
        
        if let equalToRight = equalToRight {
            
            trailingAnchor.constraint(equalTo: equalToRight, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    
    func centre (centerX: NSLayoutXAxisAnchor? = nil, centreY: NSLayoutYAxisAnchor? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let centerx = centerX {
            
            centerXAnchor.constraint(equalTo: centerx).isActive = true
        }
        
        if let centery = centreY {
            
            centerYAnchor.constraint(equalTo: centery).isActive = true
        }
    }
    
    
    func removeProperly() {
        
        for view in self.subviews {
            
            view.removeFromSuperview()
        }
        self.removeFromSuperview()
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
           let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
           let mask = CAShapeLayer()
           mask.path = path.cgPath
           self.layer.mask = mask
      }
    
    func makeRounded() {
           self.layer.masksToBounds = false
           self.layer.cornerRadius = self.frame.height / 2
           self.clipsToBounds = true
       }
    
    func shadowBorder (){
        
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        self.layer.shadowRadius = 1.7
        self.layer.shadowOpacity = 0.2
        
    }
    
    
    func addBlurArea(area: CGRect, style: UIBlurEffect.Style) {
        let effect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: effect)
        let container = UIView(frame: area)
        blurView.frame = CGRect(x: 0, y: 0, width: area.width, height: area.height)
        container.addSubview(blurView)
        container.alpha = 0.9
        self.insertSubview(container, at: 1)
    }
    
    
}
