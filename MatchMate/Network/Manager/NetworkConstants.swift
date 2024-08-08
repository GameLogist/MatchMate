//
//  NetworkConstants.swift
//  MatchMate
//
//  Created by Ayush Tiwari on 08/08/24.
//

import Foundation

class NetworkConstants {
    public static var shared: NetworkConstants = NetworkConstants()
    
    private init() {
        // Singleton
    }
    
    public var token: String {
        get {
            return ""
        }
    }
    
    public var serverAddress: String {
        get {
            return "https://randomuser.me/"
        }
    }
}
