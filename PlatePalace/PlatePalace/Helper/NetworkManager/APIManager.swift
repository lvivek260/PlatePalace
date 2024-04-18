//
//  APIManager.swift
//  Single_Response_Principle
//
//  Created by PHN MAC 1 on 05/10/23.
//

import Foundation
import UIKit

struct ResponseError: Decodable {
    let status : String
    let message: String
}

typealias ResultHandler<T> = (Result<T, FetchingError>) -> Void

//high-level class
final class APIManager{
    
    private let networkHandler: NetworkHandler
    private let responseHandler: ResponseHandler
    
    init(networkHandler: NetworkHandler,
         responseHandler: ResponseHandler) {
        self.networkHandler = networkHandler
        self.responseHandler = responseHandler
    }
    
    func request<T: Decodable>(
        modelType: T.Type,
        type: endPointItems,
        completion: @escaping ResultHandler<T>
    ){
        //check InterNet Connection
        if !Reachability.isConnected(){
            completion(.failure(.networkError))
            return
        }
        
        
        guard let url = type.url else{
            completion(.failure(.invalidUrl))
            return
        }
        
        //create request
        var request = URLRequest(url: url)
        request.httpMethod = type.httpMethod.rawValue
        request.allHTTPHeaderFields = type.header
        if let body = type.parameter{
            request.httpBody = body
        }
        let curlRequest = request.curlCommand
        networkHandler.requestDataAPI(url: request) { result in
            switch result{
            case .success(let data):
                //convert data
                self.responseHandler.parseResonseDecode(data: data,modelType: modelType) { result in
                    switch result{
                    case .success(let fetchingData):
                        completion(.success(fetchingData))
                        break
                    case .failure(let error):
                        completion(.failure(.DecodingError(error)))
                        break
                    }
                }
                break
                
            case .failure(let err):
                completion(.failure(err))
                break
            }
        }
    }
}

//low-level class
class NetworkHandler {

    func requestDataAPI(
        url: URLRequest,
        completionHandler: @escaping (Result<Data, FetchingError>) -> Void
    ) {
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            let curlRequest = url.curlCommand
            #if DEBUG
            print("CURL ----> \(curlRequest)")
            #endif
            if let response = response as? HTTPURLResponse, response.statusCode == 500 {
                DispatchQueue.main.async {
                    if let window = self.getWindow() {
                        let alertMessage = UIAlertController(title: "Internal Server Error", message: "\(url)", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "Ok", style: .cancel){_ in
//                            CustomUserDefaults.shared.resetDefaults()
//                            let loginVC = AppStoryboard.login.viewController(viewControllerClass: LoginVC.self)
//                            window.rootViewController = loginVC
//                            window.makeKeyAndVisible()
                        }
                        alertMessage.addAction(ok)
                        window.rootViewController?.present(alertMessage, animated: true)
                    }
                }
                return
            }
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                let responseError = try? JSONSerialization.jsonObject(with: data ?? Data()) as? [String: Any]
                let message = responseError?["message"] as? String ?? ""
                completionHandler(.failure(.invalidResponse(statusCode: statusCode ?? -1, error: message)))
                return
            }

            guard let data, error == nil else {
                completionHandler(.failure(.invalidData))
                return
            }
            completionHandler(.success(data))
        }
        session.resume()
    }
    
    func getWindow() -> UIWindow?{
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            return window
        }
        return nil
    }

}

//low-level class
class ResponseHandler {

    func parseResonseDecode<T: Decodable>(
        data: Data,
        modelType: T.Type,
        completionHandler: ResultHandler<T>
    ) {
        do {
            print(String(data: data, encoding: .utf8)!)
            let userResponse = try JSONDecoder().decode(modelType, from: data)
            completionHandler(.success(userResponse))
        } catch let error {
            completionHandler(.failure(.DecodingError(error)))
        }
    }

}

