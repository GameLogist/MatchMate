//
//  HomeScreenView.swift
//  MatchMate
//
//  Created by Ayush Tiwari on 08/08/24.
//

import SwiftUI

struct HomeScreenView: View {
    
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    
    var body: some View {
        ZStack {
            Color(.systemBlue.withAlphaComponent(0.1))
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    Text("Profile Matches")
                        .font(.title)
                        .fontWeight(.bold)

                    ForEach(0..<getMatchDataBinding().count, id:\.self) { index in
                        MatchCardView(match: getMatchDataBinding()[index])
                            .padding(.horizontal, 48)
                            .padding(.bottom, 24)
                    }
                }
                .environmentObject(homeScreenViewModel)
            }
        }
    }
    
    func getMatchDataBinding() -> Binding<[Match]> {
        $homeScreenViewModel.matches
    }
}
