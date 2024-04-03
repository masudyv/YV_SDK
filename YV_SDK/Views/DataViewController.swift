//
//  File.swift
//  
//
//  Created by Masud Onikeku on 26/07/2023.
//

import Foundation
import UIKit

class DataViewController : UIViewController {
    
    var data : BaseResult? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        
        self.view.backgroundColor = .white
        
        let header = UILabel()
        header.text = "Data"
        header.textColor = .black
        header.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(header)
        header.constraint(equalToTop: view.topAnchor, paddingTop: 50, height: 50)
        header.centre(centerX: view.centerXAnchor)
        
        let data = UILabel()
        //data.text = 
        data.textAlignment = .left
        data.textColor = .black
        data.numberOfLines = 0
        data.font = UIFont.systemFont(ofSize: 8)
        view.addSubview(data)
        data.constraint(equalToTop: header.bottomAnchor, equalToBottom: view.bottomAnchor, equalToLeft: view.leadingAnchor, equalToRight: view.trailingAnchor, paddingTop: 20, paddingBottom: 50, paddingLeft: 12, paddingRight: 12)
        //data.centre(centerX: view.centerXAnchor)
        data.text = "Data is Loading..."
        
        do {
            if let dt = self.data as? LivenessData {
                
                let jsonEncoder = JSONEncoder()
                let jsonData = try jsonEncoder.encode(dt)
                let json = String(data: jsonData, encoding: String.Encoding.utf8)
                data.text = json
            }else if let dt = self.data as? DocumentData {
                
                let jsonEncoder = JSONEncoder()
                let jsonData = try jsonEncoder.encode(dt)
                let json = String(data: jsonData, encoding: String.Encoding.utf8)
                data.text = json
            }else if let dt = self.data as? VFormsEntryData {
                
                let jsonEncoder = JSONEncoder()
                let jsonData = try jsonEncoder.encode(dt)
                let json = String(data: jsonData, encoding: String.Encoding.utf8)
                data.text = json
            }
        } catch  {
            print(error)
        }
        
        
        
        /*if let dt = self.data as? LivenessResultData {
            
            //let dt = self.data as! LivenessData
            data.text = dt.data?.photo
        }else if let dt = self.data as? VFormsEntryData {
            
            //let dt = self.data as! LivenessData
            data.text = dt.fields.debugDescription
        }else {
            
            let dt = self.data as! DocumentResultData
            data.text = dt.data.debugDescription
        }*/
    }
}
