//
//  GetSingleMatchRequestModel.swift
//  MatchMate
//
//  Created by Ayush Tiwari on 09/08/24.
//

import Foundation

class GetSingleMatchRequestModel: RequestModel {
    
    override var path: String {
        return APIConstants.GetMatches.match
    }
    
    override var method: HTTPMethod {
        return HTTPMethod.get
    }
}
