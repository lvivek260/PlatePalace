//
//  URLRequest+Ext.swift
//  PlatePalace
//
//  Created by PHN MAC 1 on 18/04/24.
//

import Foundation

//MARK: Extension of URLRequest to generate the CURL request from URLRequest
extension URLRequest {
    var curlCommand: String {
        guard let url = self.url else {
            return "Unable to generate cURL command without URL."
        }

        var curlCommand = "curl -X \(self.httpMethod ?? "GET") '\(url.absoluteString)'"

        if let headers = self.allHTTPHeaderFields {
            for (key, value) in headers {
                curlCommand += " -H '\(key): \(value)'"
            }
        }

        if let bodyData = self.httpBody, let bodyString = String(data: bodyData, encoding: .utf8) {
            curlCommand += " -d '\(bodyString)'"
        }

        return curlCommand
    }
}
