//
//  File.swift
//  
//
//  Created by Masud Onikeku on 15/07/2023.
//

import Foundation

class Service {
    
    typealias parameters = [String:Any]
    
    enum HTTPMethod: String {
        case options = "OPTIONS"
        case get     = "GET"
        case head    = "HEAD"
        case post    = "POST"
        case put     = "PUT"
        case patch   = "PATCH"
        case delete  = "DELETE"
        case trace   = "TRACE"
        case connect = "CONNECT"
    }
    
    
    static func requestData(dev: Bool, url:String,method:HTTPMethod,parameters:AccessPointRequest?,completion: @escaping (Response)->Void) {
        
        let header =  ["Content-Type": "application/json"]
        //print(baseUrl+url)
        
        var urlRequest = dev ? URLRequest(url: URL(string: Constants.VformDevUrl+url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10) : URLRequest(url: URL(string: Constants.VformProdUrl+url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        //urlRequest.allHTTPHeaderFields = header
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        if let parameters = parameters {
            
            let jsonEncoder = JSONEncoder()
            let jsonData = try? jsonEncoder.encode(parameters)
            //let json = String(data: jsonData, encoding: String.Encoding.utf8)
            if let data = jsonData {
                
                urlRequest.httpBody = data
            }
            
        }
        
        print(urlRequest)
        
        
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print(error)
                completion(Response(check: false, description: error.localizedDescription))
            }else if let data = data ,let responseCode = response as? HTTPURLResponse {
                do {
                    
                    //let responseJson = try JSON(data: data)
                    let dt = try? JSONSerialization.jsonObject(with: data)
                    print(dt.debugDescription)
                    print("responseCode : \(responseCode.statusCode)")
                    
                    
                    switch responseCode.statusCode {
                    case 200...201:
                        
                        let responseJson : AccessPointResponse? = try JSONDecoder().decode(AccessPointResponse.self, from: data)
                        print("responseJSON : \(responseJson)")
                        completion(Response(check: true, description: "", object: responseJson))
                    case 400...499:
                        let dt = try? JSONSerialization.jsonObject(with: data)
                        //let prettyJSON = NSString(data: dt!, encoding: String.Encoding.utf8.rawValue)
                        
                        print(dt.debugDescription)
                        completion(Response(check: false, description: dt.debugDescription, object: responseCode.statusCode))
                    case 500...599:
                        completion(Response(check: false, description: "Server error"))
                    default:
                        completion(Response(check: false, description: "Unknown error"))
                        break
                    }
                }
                catch let parseJSONError {
                    
                    
                    if parseJSONError.localizedDescription == "The data couldn’t be read because it is missing." {
                        completion(Response(check: true, description: "User not found", object: nil))
                    }else {
                        
                        completion(Response(check: false, description: "error on parsing request to JSON : \(parseJSONError.localizedDescription)"))
                    }
                    print("error on parsing request to JSON : \(parseJSONError.localizedDescription)")
                }
            }
        }.resume()
    }
    
    
    static func requestIdentityData(dev: Bool, url:String,method:HTTPMethod,parameters:parameters?,completion: @escaping (Response)->Void) {
        
        let header =  ["Content-Type": "application/json"]
        //print(baseUrl+url)
        
        var urlRequest = dev ? URLRequest(url: URL(string: Constants.idDevUrl+url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10) : URLRequest(url: URL(string: Constants.idProdUrl+url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        //urlRequest.allHTTPHeaderFields = header
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        if let parameters = parameters {
            let p = parameters.reduce("") { (result, param) -> String in
                return result + "&\(param.key)=\((param.value as! [String : String]).description)"
            }
            
            let q = parameters as! [String : [String : String]]
            let encoder = JSONEncoder()
            if let jsonData = try? encoder.encode(q) {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                    let parameterData = jsonString.data(using: .utf8)
                    urlRequest.httpBody = parameterData
                    
                }
            }
            //print(p)
            
            
        }
        
        
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print(error)
                completion(Response(check: false, description: error.localizedDescription))
            }else if let data = data ,let responseCode = response as? HTTPURLResponse {
                do {
                    let responseJson : AccessPointResponse? = try JSONDecoder().decode(AccessPointResponse.self, from: data)
                    //let responseJson = try JSON(data: data)
                    print("responseCode : \(responseCode.statusCode)")
                    print("responseJSON : \(responseJson)")
                    //completion(Response(check: false, description: "Unknown error", object: responseJson))
                    
                    switch responseCode.statusCode {
                    case 200...201:
                        completion(Response(check: true, description: "", object: responseJson))
                    case 400...499:
                        completion(Response(check: false, description: "Error 400"))
                    case 500...599:
                        completion(Response(check: false, description: "Server error"))
                    default:
                        completion(Response(check: false, description: "Unknown error"))
                        break
                    }
                }
                catch let parseJSONError {
                    
                    
                    if parseJSONError.localizedDescription == "The data couldn’t be read because it is missing." {
                        completion(Response(check: true, description: "not found", object: nil))
                    }else {
                        
                        completion(Response(check: false, description: "error on parsing request to JSON : \(parseJSONError.localizedDescription)"))
                    }
                    print("error on parsing request to JSON : \(parseJSONError.localizedDescription)")
                }
            }
        }.resume()
    }
    
}

class Response {
    
    var check : Bool
    var description : String
    var object: Any?
    
    init(check : Bool, description : String, object : Any? = nil) {
        self.check = check
        self.description = description
        self.object = object
    }
}

