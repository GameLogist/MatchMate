//
//  RespondedMatchesView.swift
//  MatchMate
//
//  Created by Ayush Tiwari on 09/08/24.
//

import SwiftUI

struct RespondedMatchesView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    
    var body: some View {
        ZStack {
            Color(.systemBlue.withAlphaComponent(0.1))
                .ignoresSafeArea()
            VStack {
                if(homeScreenViewModel.respondedMatches.isEmpty) {
                    Text(StringConstants.RespondedPage.emptyListMessage)
                        .font(.system(size: 20))
                        .padding(24)
                } else {
                    ScrollView {
                        LazyVStack {
                            ForEach(0..<getMatchDataBinding().count, id:\.self) { index in
                                MatchCardView(match: getMatchDataBinding()[index], ownerScreen: .RespondedPage)
                                    .padding(.horizontal, 48)
                                    .padding(.bottom, 24)
                            }
                        }
                        .environmentObject(homeScreenViewModel)
                    }
                }
            }
        }
        .navigationTitle(StringConstants.RespondedPage.title)
    }
    
    func getMatchDataBinding() -> Binding<[Match]> {
        $homeScreenViewModel.respondedMatches
    }
}
