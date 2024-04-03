//
//  File.swift
//  
//
//  Created by Masud Onikeku on 31/05/2023.
//

import Foundation
import UIKit


public class RegularView : UIView {
    
    public var name = "Adewale"
    public var button = UIButton()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        let backView = UIView()
        addSubview(backView)
        backView.backgroundColor = .white
        backView.constraint(equalToLeft: leadingAnchor, equalToRight: trailingAnchor, paddingLeft: 16, paddingRight: 16, height: 300)
        backView.layer.cornerRadius = 12
        backView.layer.borderColor = UIColor.black.cgColor
        backView.layer.borderWidth = 2
        backView.centre(centreY: centerYAnchor)
        
        let hello = UILabel()
        hello.text = "Hello"
        hello.font = UIFont.systemFont(ofSize: 18)
        hello.textColor = .black
        hello.textAlignment = .left
        
        let nameLabel = UILabel()
        //nameLabel.text = name
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        nameLabel.textColor = .black
        hello.textAlignment = .right
        
        let smallStack = UIStackView(arrangedSubviews: [hello, nameLabel])
        smallStack.distribution = .fillEqually
        smallStack.spacing = 12
        
        //let button = UIButton()
        button.constraint(height: 50)
        button.layer.cornerRadius = 12
        button.setTitle("Start Liveness Check", for: .normal)
        button.backgroundColor = .black
        button.tintColor = .white
        button.titleLabel?.textColor = .white
        button.setTitleColor(.white, for: .normal)
        button.constraint(width: 250)
        
        let bigStack = UIStackView(arrangedSubviews: [smallStack, button])
        bigStack.axis = .vertical
        bigStack.spacing = 16
        backView.addSubview(bigStack)
        bigStack.centre(centerX: backView.centerXAnchor, centreY: backView.centerYAnchor)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

public class HomeView : UIView {
    
    
    public var vForms = UIButton()
    public var livenessCheck = UIButton()
    public var documentCapture = UIButton()
    public var close = UILabel()
    
    override public init(frame: CGRect) {
        
        super.init(frame: frame)
        
        
        
        vForms.constraint(height: 50)
        vForms.layer.cornerRadius = 12
        vForms.setTitle("VForms", for: .normal)
        vForms.backgroundColor = .black
        vForms.tintColor = .white
        vForms.titleLabel?.textColor = .white
        vForms.setTitleColor(.white, for: .normal)
        vForms.constraint(width: 250)
        
        livenessCheck.constraint(height: 50)
        livenessCheck.layer.cornerRadius = 12
        livenessCheck.setTitle("Liveness Check", for: .normal)
        livenessCheck.backgroundColor = .black
        livenessCheck.tintColor = .white
        livenessCheck.titleLabel?.textColor = .white
        livenessCheck.setTitleColor(.white, for: .normal)
        livenessCheck.constraint(width: 250)
        
        documentCapture.constraint(height: 50)
        documentCapture.layer.cornerRadius = 12
        documentCapture.setTitle("Document Capture", for: .normal)
        documentCapture.backgroundColor = .black
        documentCapture.tintColor = .white
        documentCapture.titleLabel?.textColor = .white
        documentCapture.setTitleColor(.white, for: .normal)
        documentCapture.constraint(width: 250)
        
        let bigStack = UIStackView(arrangedSubviews: [vForms, livenessCheck, documentCapture])
        bigStack.axis = .vertical
        bigStack.spacing = 16
        addSubview(bigStack)
        bigStack.constraint(equalToTop: topAnchor, equalToBottom: bottomAnchor, equalToLeft: leadingAnchor, equalToRight: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

