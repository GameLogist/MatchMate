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
    @Published var respondedMatches: [Match] = []
    
    init() {
        loadMatches(forceLoad: false)
    }
    
    func homeMatchAnswered(match: Match, answer: MatchState) {
        // Add to Coredata
        if(answer != .unanswered) {
            if let idx = matches.firstIndex(where: { $0.id == match.id }) {
                matches[idx].matchState = answer
                PersistenceController.shared.editHomePageEntity(match.id, matchState: answer)
                
                let objectId = PersistenceController.shared.addToRespondedMatches(
                    name: match.name ?? "",
                    age: match.age ?? 0,
                    address: match.address ?? "",
                    avatarURL: match.avatarURL ?? "",
                    matchState: answer)
                let tempMatch = Match(
                    id: objectId,
                    name: match.name,
                    age: match.age,
                    address: match.address,
                    avatarURL: match.avatarURL,
                    matchState: answer)
                self.respondedMatches.append(tempMatch)
                PersistenceController.shared.deleteHomePageEntity(match.id)
                loadSingleMatch()
                fetchHomeMatchesFromCoreData()
            }
        }
        fetchRespondedMatchesFromCoreData()
    }
    
    func respondedMatchAnswered(match: Match, answer: MatchState) {
        // Add to Coredata
        if let idx = respondedMatches.firstIndex(where: { $0.id == match.id }) {
            respondedMatches[idx].matchState = answer
            PersistenceController.shared.editRespondedPageEntity(match.id, matchState: answer)
        }
        fetchRespondedMatchesFromCoreData()
    }
    
    
    //
    // API Call
    //
    
    func loadMatches(forceLoad: Bool) {
        if(PersistenceController.shared.fetchHomeMatches().isEmpty || forceLoad) {
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
        } else {
            fetchHomeMatchesFromCoreData()
        }
        fetchRespondedMatchesFromCoreData()
    }
    
    func loadSingleMatch() {
        MatchServices.getSingleMatch(completion: { (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    print("Match - \(response?.results?.count ?? 0)")
                    for person in response?.results ?? [] {
                        self.appendToMatches(person: person)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
        fetchHomeMatchesFromCoreData()
    }
    
    //
    //  Data Management
    //
    
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
        
        let objectId = PersistenceController.shared.addToHomeMatches(
            name: fullName,
            age: age ?? 0,
            address: fullAddress,
            avatarURL: url,
            matchState: .unanswered)
        
        let match = Match(
            id: objectId,
            name: fullName,
            age: age,
            address: fullAddress,
            avatarURL: url,
            matchState: .unanswered)
        self.matches.append(match)
    }
    
    func fetchHomeMatchesFromCoreData() {
        self.matches.removeAll()
        let fetchedMatches = PersistenceController.shared.fetchHomeMatches()
        for item in fetchedMatches {
            matches.append(Match(
                id: item.objectID,
                name: item.name,
                age: Int(item.age),
                address: item.address,
                avatarURL: item.imageUrl,
                matchState: MatchState(rawValue: Int(item.matchState)) ?? .unanswered
            ))
        }
    }
    
    func fetchRespondedMatchesFromCoreData() {
        self.respondedMatches.removeAll()
        let fetchedMatches = PersistenceController.shared.fetchRespondedMatches()
        for item in fetchedMatches {
            respondedMatches.append(Match(
                id: item.objectID,
                name: item.name,
                age: Int(item.age),
                address: item.address,
                avatarURL: item.imageUrl,
                matchState: MatchState(rawValue: Int(item.matchState)) ?? .unanswered
            ))
        }
    }
    
    func deleteAllHomeMatchesData() {
        matches.removeAll()
        PersistenceController.shared.clearHomeMatches()
    }
}
