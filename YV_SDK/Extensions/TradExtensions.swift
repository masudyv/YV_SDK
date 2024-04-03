//
//  File.swift
//  
//
//  Created by Masud Onikeku on 06/08/2023.
//

import Foundation

extension Dictionary {
    
    //Liveness parsings
    
    /*func toLivenessResultData() -> LivenessResultData? {
        
        var result : LivenessResultData? = nil
        
        let dict : Dictionary<Key, Value>? = self
        
        if let dic = dict as? [String : Any] {
            
            //print(dic["data"])
            result = LivenessResultData(id: dic["id"] as! String, data: (dic["data"] as? [String : Any])!.toLivenessData())
        }
        return result
    }
    
    func toLivenessData()  -> LivenessData {
        
        var result : LivenessData? = nil
        
        let dict : Dictionary<Key, Value>? = self
        
        if let dic = dict as? [String : Any] {
            
            //print(dic["data"] as! LivenessData)
            result = LivenessData(passed: dic["passed"] as! Bool, photo: dic["photo"] as? String)
        }
        return result!
    }*/
    
    func toLivenessResultData() -> LivenessResultData? {
        
        var result : LivenessResultData? = nil
        do {
            let json = try JSONSerialization.data(withJSONObject: self)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedCountries = try decoder.decode(LivenessResultData.self, from: json)
            result = decodedCountries
            //decodedCountries.forEach{print($0)}
        } catch {
            print(error)
        }
        return result
    }
    
    //VForms parsings
    
    func toVformsResultData() -> VFormResultData? {
        
        var result : VFormResultData? = nil
        
        let dict : Dictionary<Key, Value>? = self
        
        if let dic = dict as? [String : Any] {
            
            //print(dic["data"])
            result = VFormResultData(data: (dic["data"] as? [String:Any])?.tovformData(), id: dic["id"] as! String)
        }
        return result
    }
    
    func tovformData()  -> Data {
        
        var result : Data? = nil
        
        let dict : Dictionary<Key, Value>? = self
        
        if let dic = dict as? [String : Any] {
            
            //print(dic["data"] as! LivenessData)
            result = Data(entry: (dic["entry"] as! [String:Any]).tovFormEntryData())
        }
        return result!
    }
    
    func tovFormEntryData() -> VFormsEntryData {
        
        var result : VFormsEntryData? = nil
        
        let dict : Dictionary<Key, Value>? = self
        
        if let dic = dict as? [String : Any] {
            
            //print(dic["data"] as! LivenessData)
            result = VFormsEntryData(id: dic["id"] as! String, fields: dic["fields"] as! [[String:Any]])
        }
        return result!
    }
    
    //Document Parsings
    
    func toDocumentResultData() -> DocumentResultData? {
        
        var result : DocumentResultData? = nil
        do {
            let json = try JSONSerialization.data(withJSONObject: self)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedCountries = try decoder.decode(DocumentResultData.self, from: json)
            result = decodedCountries
            //decodedCountries.forEach{print($0)}
        } catch {
            print(error)
        }
        return result
    }
}
