//
//  GetMatchesRequestModel.swift
//  MatchMate
//
//  Created by Ayush Tiwari on 08/08/24.
//

import Foundation

class GetMatchesRequestModel: RequestModel {
    
    override var path: String {
        return APIConstants.GetMatches.matches
    }
    
    override var method: HTTPMethod {
        return HTTPMethod.get
    }
}

class GetSingleMatchRequestModel: RequestModel {
    
    override var path: String {
        return APIConstants.GetMatches.match
    }
    
    override var method: HTTPMethod {
        return HTTPMethod.get
    }
}
