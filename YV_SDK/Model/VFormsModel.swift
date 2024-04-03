//
//  File.swift
//  
//
//  Created by Masud Onikeku on 10/07/2023.
//

import Foundation
import UIKit


public class vFormOptions : Options {
    
    let sandboxEnvironment = true
    let onSuccess : (VFormsEntryData?) -> Void = {_ in}
    let onFailed : (VFormsEntryData?) -> Void = {_ in }
    let onCompleted : (VFormsEntryData?) -> Void = {_ in }
    public var personalInfo : VFormsInfo?
    
    let metadata : [String : Any]? = nil
    
    public init(vFormId: String, publicMerchantKey: String, appearance: Appearance? = nil, personalInfo: VFormsInfo?) {
        super.init(publicMerchantKey: publicMerchantKey, appearance: appearance, info: personalInfo, vFormId: vFormId)
        //self.vFormId = vFormId
        self.publicMerchantKey = publicMerchantKey
        self.personalInfo = personalInfo
    }
}

public struct Appearance {
    
    public var greeting : String? = "We will need to verify your identity. It will only take a moment."
    public var actionText = "Verify Identity"
    public var bTnTextColor = UIColor.white
    public var primaryColor = UIColor.white
    public var btnBackgroundColor = UIColor.black
    
    public init(greeting: String? = nil, actionText: String = "Verify Identity", bTnTextColor: UIColor = UIColor.white, primaryColor: UIColor = UIColor.white, btnBackgroundColor: UIColor = UIColor.black) {
        self.greeting = greeting
        self.actionText = actionText
        self.bTnTextColor = bTnTextColor
        self.primaryColor = primaryColor
        self.btnBackgroundColor = btnBackgroundColor
    }
}

public class VFormsInfo : Info {
    
    
    public var lastname : String?
    public var middleName : String?
    public var email : String?
    public var phone : String?
    public var gender : Gender? = Gender.Male
    
    public init(firstName: String? = nil, lastname: String? = nil, middleName: String? = nil, email: String? = nil, phone: String? = nil) {
        super.init(firstName: firstName)
        self.lastname = lastname
        self.middleName = middleName
        self.email = email
        self.phone = phone
    }
}

class VFormResultData : Codable{
    let data: Data?
    let id: String
    
    public init(data: Data?, id: String) {
        self.data = data
        self.id = id
    }
}

class Data : Codable {
    let entry: VFormsEntryData?
    
    public init(entry: VFormsEntryData) {
        self.entry = entry
    }
}

public class VFormsEntryData : BaseResult {
    
    var id : String
    var fields : [[String : Any]]
    
    public init(id: String, fields: [[String : Any]]) {
        
        self.id = id
        self.fields = fields
        super.init()
        
    }
    
    enum CodingKeys : String, CodingKey {
        case id
        case fields
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from) is not implemented")
    }
}




public enum Gender : String {
    
    case Male = "M"
    case Female = "F"
}

public enum FormResultType : String {
    case SUCCESS = "yvos:vform:submit-success"
    case FAILURE = "yvos:vform:submit-failed"
    case COMPLETED = "yvos:vform:submit-completed"
}

