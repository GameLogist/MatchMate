//
//  MatchServices.swift
//  MatchMate
//
//  Created by Ayush Tiwari on 08/08/24.
//

import Foundation

class MatchServices {
    class func getMatches(completion: @escaping(Swift.Result<MatchesResponseModel?, ErrorModel>) -> Void) {
        let request = GetMatchesRequestModel()
        NetworkManager.shared.sendRequest(requestModel: request) { (result) in
            completion(result)
        }
    }
}
