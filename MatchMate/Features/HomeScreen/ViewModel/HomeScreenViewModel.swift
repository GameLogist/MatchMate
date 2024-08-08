//
//  HomeScreenViewModel.swift
//  MatchMate
//
//  Created by Ayush Tiwari on 08/08/24.
//

import Foundation
import SwiftUI

struct Match: Identifiable {
    var id: UUID
    
    var name: String?
    var age: Int?
    var address: String?
    var avatarURL: String?
}

@MainActor
class HomeScreenViewModel: ObservableObject {
    
    // Single truth: The fetched API list will be stored here
    @Published var matches: [Match] = []
    
    init() {
        self.matches = [
            Match(id: UUID(), name: "ayush", age: 12, address: "53 Bhagwati Vihar", avatarURL: ""),
            Match(id: UUID(), name: "ayush", age: 12, address: "53 Bhagwati Vihar", avatarURL: ""),
            Match(id: UUID(), name: "ayush", age: 12, address: "53 Bhagwati Vihar", avatarURL: ""),
            Match(id: UUID(), name: "ayush", age: 12, address: "53 Bhagwati Vihar", avatarURL: ""),
            Match(id: UUID(), name: "ayush", age: 12, address: "53 Bhagwati Vihar", avatarURL: "")
        ]
    }
    
    //
    // API Call
    //
    
    func fetchMatches() {
        
    }
}
