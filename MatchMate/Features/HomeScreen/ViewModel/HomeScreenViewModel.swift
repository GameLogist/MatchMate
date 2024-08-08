//
//  HomeScreenViewModel.swift
//  MatchMate
//
//  Created by Ayush Tiwari on 08/08/24.
//

import Foundation
import SwiftUI

@MainActor
class HomeScreenViewModel: ObservableObject {
    
    // Single truth: The fetched API list will be stored here
    @Published var matches: [Match] = []
    
    init() {
        fetchMatches()
    }
    
    func addMatchToDatabase(match: Match) {
        // Add to Coredata
    }
    
    //
    // API Call
    //
    
    func fetchMatches() {
        MatchServices.getMatches(completion: { (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    print("Matches - \(response?.results?.count ?? 0)")
                    for person in response?.results ?? [] {
                        self.appendToMatches(person: person)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func appendToMatches(person: Person) {
        let title = person.name?.title ?? ""
        let firstName = person.name?.first ?? ""
        let lastName = person.name?.last ?? ""
        let fullName = "\(title) \(firstName) \(lastName)"
        
        let age = person.registered?.age
        
        let street = person.location?.street?.name ?? ""
        let state = person.location?.state ?? ""
        let city = person.location?.city ?? ""
        let country = person.location?.country ?? ""
        let fullAddress = "\(street), \(state), \(city), \(country)"
        
        let url = person.picture?.large ?? ""
        
        let match = Match(
            id: UUID(),
            name: fullName,
            age: age,
            address: fullAddress,
            avatarURL: url, 
            matchState: .unanswered)
        self.matches.append(match)
    }
}
