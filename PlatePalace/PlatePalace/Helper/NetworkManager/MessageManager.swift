//
//  MessageManager.swift
//  LMS
//
//  Created by PHN MAC 1 on 07/02/24.
//

import Foundation

enum FetchingError: Error{
    case networkError
    case invalidUrl
    case invalidData
    case invalidResponse(statusCode: Int, error: String?)
    case DecodingError(Error)
}

final class MessageManager{
    let error: FetchingError
    
    init(error: FetchingError){
        self.error = error
    }
    
    func getMessage()->(title: String, message: String){
        let message: String = "Oops, seems like a glitch got in our way. Please retry your action."
        
        switch error{
        case .networkError:
            return (title: "Network Error", message: "There was an error connecting. Please check your internet.")
            
        case .invalidUrl, .invalidData:
            return (title: "Error", message: message)
            
        case let .invalidResponse(statusCode, error): 
            if let error, error != ""{
                return (title: "Error", message: error)
            }else{
                return (title: "Error", message: message)
            }
        
        case .DecodingError(let error): 
            #if DEBUG
            print("Decoding Error:------> ",error)
            #endif
            return (title: "Error", message: message)
        }
    }
}
