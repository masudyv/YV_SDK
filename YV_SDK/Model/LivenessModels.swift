//
//  File.swift
//  
//
//  Created by Masud Onikeku on 10/07/2023.
//

import Foundation

public class LivenessOptions : Options {
    
    
    let metadata : [String : Any]? = nil
    var personalInfo : LivenessPersonalInfo?
    //let appearance = Appearance(greeting: "We will need to carry out a liveness check. It will only take a moment.", actionText: "Start Liveness Test")
    let onSuccess : (LivenessData?) -> Void = {_ in}
    let onFailure : (LivenessData?) -> Void =  {_ in}
    let onClosed : (LivenessData?) -> Void =  {_ in}
    let onCancelled : (LivenessData?) -> Void = {_ in}
    let onRetry : (LivenessData?) -> Void = {_ in}
    
    public init(publicMerchantKey: String, appearance: Appearance? = nil, personalInfo: LivenessPersonalInfo?) {
        
        super.init(publicMerchantKey: publicMerchantKey, appearance: appearance, info: personalInfo)
        self.publicMerchantKey = publicMerchantKey
        self.personalInfo = personalInfo
    }
}

public class LivenessPersonalInfo : Info {
    
    
    public var lastName : String?
    
    public init(firstName: String? = nil, lastName : String? = nil) {
        super.init(firstName: firstName)
        self.lastName = lastName
    }
}

public class LivenessData : BaseResult {
    
    var passed : Bool
    var photo : String?
    
    public init(passed: Bool, photo: String?) {
        self.passed = passed
        self.photo = photo
        super.init()
    }
    
    enum CodingKeys: String, CodingKey {
        case passed
        case photo
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        passed = try container.decode(Bool.self, forKey: .passed)
        photo = try container.decode(String.self, forKey: .photo)

        // otherVar = ...
        
        // Get superDecoder for superclass and call super.init(from:) with it
        let superDecoder = try container.superDecoder()
        try super.init(from: superDecoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
            try super.encode(to: encoder)
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(self.passed, forKey: .passed)
            try container.encode(self.photo, forKey: .photo)
        }
    
}

public class LivenessResultData : Codable{
    let id: String
    let data: LivenessData?
    
    public init(id: String, data: LivenessData?) {
        self.id = id
        self.data = data
    }
}


public enum LivenessResultType : String {
    case SUCCESS = "yvos:liveness:success"
    case FAILED = "yvos:liveness:failed"
    case CANCELLED = "yvos:liveness:cancelled"
    case CLOSED = "yvos:liveness:closed"
    case RETRY = "yvos:liveness:retry"
}
