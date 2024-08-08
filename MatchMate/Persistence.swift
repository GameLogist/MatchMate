//
//  Persistence.swift
//  MatchMate
//
//  Created by Ayush Tiwari on 08/08/24.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    private init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "MatchMate")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            } else {
                print("Successfully loaded database!")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func fetchHomeMatches() -> [MatchEntity] {
        let request = NSFetchRequest<MatchEntity>(entityName: "MatchEntity")
        do {
            return try container.viewContext.fetch(request)
        } catch let error {
            print("Error Fetching : \(error)")
        }
        return []
    }
    
    func fetchRespondedMatches() -> [RespondedMatchEntity] {
        let request = NSFetchRequest<RespondedMatchEntity>(entityName: "RespondedMatchEntity")
        do {
            return try container.viewContext.fetch(request)
        } catch let error {
            print("Error Fetching : \(error)")
        }
        return []
    }
    
    func addToHomeMatches(name: String,
                          age: Int,
                          address: String,
                          avatarURL: String,
                          matchState: MatchState) -> NSManagedObjectID {
        let newMatch = MatchEntity(context: container.viewContext)
        newMatch.name = name
        newMatch.age = Int16(age)
        newMatch.address = address
        newMatch.imageUrl = avatarURL
        newMatch.matchState = Int16(matchState.rawValue)
        
        saveData()
        
        return newMatch.objectID
    }
    
    func addToRespondedMatches(name: String,
                               age: Int,
                               address: String,
                               avatarURL: String,
                               matchState: MatchState) -> NSManagedObjectID {
        let newMatch = RespondedMatchEntity(context: container.viewContext)
        newMatch.name = name
        newMatch.age = Int16(age)
        newMatch.address = address
        newMatch.imageUrl = avatarURL
        newMatch.matchState = Int16(matchState.rawValue)
        
        saveData()
        
        return newMatch.objectID
    }
    
    func clearHomeMatches() {
        // get all entities and loop over them
        let entityNames = self.container.managedObjectModel.entities.map({ $0.name!})
        entityNames.forEach { [self] entityName in
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            
            do {
                try self.container.viewContext.execute(deleteRequest)
                try self.container.viewContext.save()
                print("Home matches cleared from CoreData")
            } catch {
                // error
            }
        }
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
}
