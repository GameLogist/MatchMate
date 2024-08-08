//
//  HomeScreenView.swift
//  MatchMate
//
//  Created by Ayush Tiwari on 08/08/24.
//

import SwiftUI

struct HomeScreenView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    
    var body: some View {
        ZStack {
            Color(.systemBlue.withAlphaComponent(0.1))
                .ignoresSafeArea()
            VStack {
                ZStack {
                    HStack() {
                        Button(action: {
                            withAnimation {
                                homeScreenViewModel.loadMatches(forceLoad: true)
                            }
                        }) {
                            Image(systemName: "arrow.clockwise")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.green)
                                .padding()
                        }
                        Spacer()
                        Image(systemName: "heart.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.red)
                            .padding()
                    }
                    Text("Profile Matches")
                        .font(.title)
                        .fontWeight(.bold)
                }
                ScrollView {
                    LazyVStack {
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
    }
    
    func getMatchDataBinding() -> Binding<[Match]> {
        $homeScreenViewModel.matches
    }
}
