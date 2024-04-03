//
//  File.swift
//  
//
//  Created by Masud Onikeku on 15/07/2023.
//

import Foundation



struct AccessPointResponse : Codable {
    
    let data: AccessPointData
    //let links: [String]
    //let details: [String : String] = [:]
    //let message: String
    //let statusCode: Int
    //let success: Bool
}

struct AccessPointData : Codable {
    
    let _createdAt: String?
    let _lastModifiedAt: String?
    let createdAt: String?
    let creatorId: String?
    let details: UserDetail?
    let id: String?
    let lastModifiedAt: String?
    let mode: String?
    let templateId: String?
}

struct AccessPointRequest : Codable {
    let businessId: String
    //let metadata: [String : Any] = [:]
    let details: UserDetail?
    let mode: String = "sdk"
    let templateId: String
}

struct UserDetail : Codable {
    var firstName: String? = nil
    var lastName: String? = nil
    var middleName: String? = nil
    var email: String? = nil
    var mobile: String? = nil
    var gender: String? = nil
}
