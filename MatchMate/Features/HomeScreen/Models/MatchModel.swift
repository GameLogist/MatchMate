//
//  MatchModel.swift
//  MatchMate
//
//  Created by Ayush Tiwari on 09/08/24.
//

import Foundation
import CoreData

enum MatchState: Int {
    case unanswered = 0
    case accepted
    case declined
}

struct Match: Identifiable {
    var id: NSManagedObjectID
    
    var name: String?
    var age: Int?
    var address: String?
    var avatarURL: String?
    var matchState: MatchState
}
