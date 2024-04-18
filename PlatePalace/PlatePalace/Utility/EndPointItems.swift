//
//  EndPointItems.swift
//  Single_Response_Principle
//
//  Created by PHN MAC 1 on 05/10/23.
//

import Foundation

enum HttpMethod: String{
    case get    = "GET"
    case post   = "POST"
    case delete = "DELETE"
    case put    = "PUT"
}

protocol EndPointType{
    var baseURL   : String { get }
    var path      : String { get }
    var url       : URL? { get }
    var httpMethod: HttpMethod { get }
    var parameter : Data? { get }
    var header    : [String: String]? { get }
}

enum endPointItems{
  
}

extension endPointItems: EndPointType{
    var baseURL: String {  return "" }
    
    var path: String {
      ""
    }
    
    var url: URL? {
        return URL(string: baseURL+path)
    }
    
    var httpMethod: HttpMethod {
        .get
    }
    
    var parameter: Data? {
         nil
    }
    
    var header: [String : String]? {
        guard let authToken = CustomUserDefaults.shared.get(key: .authToken) as? String else {
            return [  "Content-Type"  : "application/json" ]
        }
        
        return [
            "Authorization" : "Bearer \(authToken)",
            "Content-Type"  : "application/json"
        ]
    }
}


struct EncodeJson{
    static func encode<T: Encodable>(model: T) -> Data{
        var data: Data = Data()
        do{
            data = try JSONEncoder().encode(model)
        }
        catch let error{
            print("Error During encode the object:- ",error)
        }
        return data
    }
}
