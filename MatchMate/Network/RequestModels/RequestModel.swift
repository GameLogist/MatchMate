//
//  RequestModel.swift
//  MatchMate
//
//  Created by Ayush Tiwari on 08/08/24.
//

import Foundation

public enum HTTPMethod: String {
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

class RequestModel: NSObject {
    
    // MARK: - Properties
    var path: String {
        return ""
    }
    
    var parameters: [String: Any?] {
        return [:]
    }
    
    var headers: [String: String] {
        return [:]
    }
    
    var method: HTTPMethod {
        return body.isEmpty ? HTTPMethod.get : HTTPMethod.post
    }
    
    var body: [String: Any?] {
        return [:]
    }
    
    var token: String {
        // One can store this in user defaults as well
        return NetworkConstants.shared.apiReadAccessToken
    }
}

extension RequestModel {
    
    func urlRequest() -> URLRequest? {
        var endpoint: String = NetworkConstants.shared.serverAddress.appending(path)
        
        var flag: Bool = true
        for parameter in parameters {
            if let value = parameter.value as? String {
                if flag {
                    flag = false
                    endpoint.append("?\(parameter.key)=\(value)")
                } else {
                    endpoint.append("&\(parameter.key)=\(value)")
                }
            }
        }
        
        guard let url = URL(string: endpoint) else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        if method != HTTPMethod.get {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch let error {
                print("Request body parse error: \(error.localizedDescription)")
            }
        }
        
        return request
    }
}
