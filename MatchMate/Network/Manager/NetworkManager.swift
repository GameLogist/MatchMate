//
//  NetworkManager.swift
//  MatchMate
//
//  Created by Ayush Tiwari on 08/08/24.
//

import Foundation

class NetworkManager {
    static let shared: NetworkManager = NetworkManager()
    
    func sendRequest<T: Codable>(requestModel: RequestModel, completion: @escaping(Swift.Result<T, ErrorModel>) -> Void) {
        
        guard let request = requestModel.urlRequest() else { return }
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(Result.failure(ErrorModel(errors: [ErrorSummary(code: "", reason: error.localizedDescription, datetime: nil)])))
                return
            }
            
            if let data = data, let responseModel = try? JSONDecoder().decode(T.self, from: data) {
                completion(Result.success(responseModel))
            } else {
                guard let data = data, let error = try? JSONDecoder().decode(ErrorModel.self, from: data) else { return }
                completion(Result.failure(error))
            }
            
        }.resume()
    }
}
