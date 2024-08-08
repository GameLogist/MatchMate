//
//  MatchMateApp.swift
//  MatchMate
//
//  Created by Ayush Tiwari on 08/08/24.
//

import SwiftUI

@main
struct MatchMateApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var homeScreenViewModel: HomeScreenViewModel = HomeScreenViewModel()

    var body: some Scene {
        WindowGroup {
            HomeScreenView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(homeScreenViewModel)
        }
    }
}
