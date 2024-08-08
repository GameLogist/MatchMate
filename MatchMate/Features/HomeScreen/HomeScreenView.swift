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
                    ForEach(homeScreenViewModel.matches, id:\.id) { match in
                        Text(match.name)
                        Spacer()
                            .frame(height:12)
                    }
                    Spacer()
                }
                .environmentObject(homeScreenViewModel)
            }
        }
    }
}
