//
//  File.swift
//  
//
//  Created by Masud Onikeku on 10/07/2023.
//

import Foundation

public class DocumentOptions : Options {
    
    
    let metadata : [String : Any]? = nil
    var personalInfo : DocumentPersonalInfo?
    //let appearance = Appearance(greeting: "We will need to carry out a  document capture. It will only take a moment.", actionText: "Start Document Capture")
    let onSuccess : (DocumentData?) -> Void = {_ in}
    let onClosed : (DocumentData?) -> Void = {_ in}
    let onCancelled : (DocumentData?) -> Void = {_ in}
    let countries : [Country]?  = nil
    
    public init(publicMerchantKey: String, appearance: Appearance? = nil, personalInfo: DocumentPersonalInfo?) {
        
        super.init(publicMerchantKey: publicMerchantKey, appearance: appearance, info: personalInfo)
        self.publicMerchantKey = publicMerchantKey
        self.personalInfo = personalInfo
    }
}

public struct Country{
    let countryCode: String = ""
    let idTypes: [String] = []
    let province: [String]  = []
}

public class DocumentPersonalInfo : Info {
    
    public override init(firstName: String? = nil) {
        super.init(firstName: firstName)
        
    }
    
}

public class DocumentResultData : Codable {
    let id: String
    let data: DocumentData?
    
    public init(id: String, data: DocumentData? = nil) {
        self.id = id
        self.data = data
    }
}


public class DocumentData : BaseResult{
    var documentNumber: String
    var firstName: String
    var lastName: String
    var fullName: String
    var dateOfBirth: String
    var dateOfExpiry: String
    var gender: String
    var rawMRZString: String
    var fullDocumentFrontImage: String
    var fullDocumentBackImage: String?
    var fullDocumentImage: String?
    
    init(documentNumber: String, firstName: String, lastName: String, fullName: String, dateOfBirth: String, dateOfExpiry: String, gender: String, rawMRZString: String, fullDocumentFrontImage: String, fullDocumentBackImage: String?, fullDocumentImage: String?) {
        self.documentNumber = documentNumber
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = fullName
        self.dateOfBirth = dateOfBirth
        self.dateOfExpiry = dateOfExpiry
        self.gender = gender
        self.rawMRZString = rawMRZString
        self.fullDocumentFrontImage = fullDocumentFrontImage
        self.fullDocumentBackImage = fullDocumentBackImage
        self.fullDocumentImage = fullDocumentImage
        super.init()
    }
    
    enum CodingKeys : String, CodingKey {
        case documentNumber
        case firstName
        case lastName
        case fullName
        case dateOfBirth
        case dateOfExpiry
        case gender
        case rawMRZString
        case fullDocumentFrontImage
        case fullDocumentBackImage
        case fullDocumentImage
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        documentNumber = try container.decode(String.self, forKey: .documentNumber)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        fullName = try container.decode(String.self, forKey: .fullName)
        dateOfBirth = try container.decode(String.self, forKey: .dateOfBirth)
        dateOfExpiry = try container.decode(String.self, forKey: .dateOfExpiry)
        gender = try container.decode(String.self, forKey: .gender)
        rawMRZString = try container.decode(String.self, forKey: .rawMRZString)
        fullDocumentFrontImage = try container.decode(String.self, forKey: .fullDocumentFrontImage)
        fullDocumentBackImage = try container.decode(String.self, forKey: .fullDocumentBackImage)
        fullDocumentImage = try container.decode(String.self, forKey: .fullDocumentImage)
        
        // otherVar = ...
        
        // Get superDecoder for superclass and call super.init(from:) with it
        let superDecoder = try container.superDecoder()
        try super.init(from: superDecoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.documentNumber, forKey: .documentNumber)
        try container.encode(self.firstName, forKey: .firstName)
        try container.encode(self.lastName, forKey: .lastName)
        try container.encode(self.fullName, forKey: .fullName)
        try container.encode(self.dateOfBirth, forKey: .dateOfBirth)
        try container.encode(self.dateOfExpiry, forKey: .dateOfExpiry)
        try container.encode(self.gender, forKey: .gender)
        try container.encode(self.rawMRZString, forKey: .rawMRZString)
        try container.encode(self.fullDocumentFrontImage, forKey: .fullDocumentFrontImage)
        try container.encode(self.fullDocumentBackImage, forKey: .fullDocumentBackImage)
        try container.encode(self.fullDocumentImage, forKey: .fullDocumentImage)
    }
}


public enum DocumentResultType : String {
    case SUCCESS = "yvos:document:success"
    case CANCELLED = "yvos:document:cancelled"
    case CLOSED = "yvos:document:closed"
}



public enum DocumentType : String {
    case NATIONAL_ID = "national_id"
    case VOTERS_CARD = "voters_card"
    case DRIVERS_LICENSE = "drivers_license"
    case DRIVERS_CARD = "drivers_card"
    case PASSPORT = "passport"
    case ID_CARD = "id_card"
    case PROFESSIONAL_DL = "professional_dl"
    case ALIEN_ID = "alien_id"
    case PROOF_OF_AGE_CARD = "proof_of_age_card"
    case ID_CARDB = "id_cardb"
    case MINORS_CARD = "minors_card"
    case RESIDENCE_PERMIT = "residence_permit"
    case TEMPORARY_RESIDENCE_PERMIT = "temporary_residence_permit"
    case CITIZENSHIP_CERTIFICATE = "citizenship_certificate"
    case TRIBAL_ID = "tribal_id"
    case WEAPON_PERMIT = "weapon_permit"
    case PUBLIC_SERVICES_CARD = "public_services_card"
    case CONSULAR_ID = "consular_id"
    case PAN_CARD = "pan_card"
    case TAX_ID = "tax_id"
    case MILITARY_ID = "military_id"
    case MY_KAS = "my_kas"
    case MY_KAD = "my_kad"
    case MY_KID = "my_kid"
    case MY_PR = "my_pr"
    case MY_POLIS = "my_polis"
    case REFUGEE_ID = "refugee_id"
    case I_KAD = "i-kad"
    case FIN_CARD = "fin_card"
    case WORK_PERMIT = "work_permit"
    case SOCIAL_SECURITY_CARD = "social_security_card"
    case GREEN_CARD = "green_card"
    case NEXUS_CARD = "nexus_card"
    
}
