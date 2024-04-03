//
//  File.swift
//  
//
//  Created by Masud Onikeku on 13/07/2023.
//

import Foundation

public class Options {
    
    public var vFormId : String?
    public var publicMerchantKey : String
    public var dev : Bool = true
    public var info : Info?
    public var appearance : Appearance? = Appearance()
    
    public init(publicMerchantKey: String, appearance : Appearance?, info : Info?, vFormId: String? = nil) {
       
        self.publicMerchantKey = publicMerchantKey
        self.appearance = appearance
        self.vFormId = vFormId
        self.info = info
    }
}

public class Info {
    
    public var firstName : String?
    
    public init(firstName: String? = nil) {
        self.firstName = firstName
    }
    
    
}

public class ResultData {
    
    public var type : String?
    
    public init(type: String?) {
        self.type = type
    }
    
    
}

public class BaseResult : Codable {
    
    
}
