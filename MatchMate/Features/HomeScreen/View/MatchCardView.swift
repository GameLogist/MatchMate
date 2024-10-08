//
//  MatchCardView.swift
//  MatchMate
//
//  Created by Ayush Tiwari on 08/08/24.
//

import SwiftUI

struct MatchCardView: View {
    
    @Binding var match: Match
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    var ownerScreen: CardOnwer
    
    var body: some View {
        ZStack {
            Color(.white)
                .ignoresSafeArea()
            VStack() {
                AsyncImage(url: URL(string: match.avatarURL ?? ""), content: view)
                    .padding(16)
                Text(match.name ?? "Name Not Found!")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding([.leading, .top, .trailing], 16)
                
                Text("\(match.age ?? 0), \(match.address ?? "")")
                    .font(.system(size: 16))
                    .foregroundStyle(.secondary)
                    .padding(16)
                
                if(match.matchState == .accepted) {
                    Button(StringConstants.Common.accepted) {
                        withAnimation {
                            if(ownerScreen == .HomePage) {
                                homeScreenViewModel.homeMatchAnswered(match: match, answer: .unanswered);
                            } else {
                                homeScreenViewModel.respondedMatchAnswered(match: match, answer: .unanswered);
                            }
                        }
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.extraLarge)
                    .buttonBorderShape(.roundedRectangle)
                    .foregroundColor(.green)
                    .padding([.bottom], 32)
                } else if (match.matchState == .declined) {
                    Button(StringConstants.Common.declined) {
                        withAnimation {
                            if(ownerScreen == .HomePage) {
                                homeScreenViewModel.homeMatchAnswered(match: match, answer: .unanswered);
                            } else {
                                homeScreenViewModel.respondedMatchAnswered(match: match, answer: .unanswered);
                            }
                        }}
                    .buttonStyle(.bordered)
                    .controlSize(.extraLarge)
                    .buttonBorderShape(.roundedRectangle)
                    .foregroundColor(.red)
                    .padding([.bottom], 32)
                } else {
                    HStack {
                        Button(action: {
                            withAnimation {
                                if(ownerScreen == .HomePage) {
                                    homeScreenViewModel.homeMatchAnswered(match: match, answer: .declined);
                                } else {
                                    homeScreenViewModel.respondedMatchAnswered(match: match, answer: .declined);
                                }
                            }
                        }) {
                            Image(systemName: "multiply")
                        }
                        .padding(24)
                        .background(.red.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(.infinity)
                        Spacer()
                            .frame(width: 24)
                        Button(action: {
                            withAnimation {
                                if(ownerScreen == .HomePage) {
                                    homeScreenViewModel.homeMatchAnswered(match: match, answer: .accepted);
                                } else {
                                    homeScreenViewModel.respondedMatchAnswered(match: match, answer: .accepted);
                                }
                            }
                        }) {
                            Image(systemName: "checkmark")
                        }
                        .padding(24)
                        .background(.green.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(.infinity)
                    }
                    .padding([.bottom], 32)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
    
    // Async Image handler to show loader or error message
    @ViewBuilder
    private func view(for phase: AsyncImagePhase) -> some View {
        switch phase {
        case .empty:
            ProgressView()
                .frame(height: 180)
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 18))
        case .success(let image):
            image
                .resizable()
                .frame(width: 180, height: 180)
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 18))
        case .failure(let error):
            VStack(spacing: 16) {
                Image(systemName: "xmark.octagon.fill")
                    .foregroundColor(.red)
                Text(error.localizedDescription)
                    .multilineTextAlignment(.center)
            }
        @unknown default:
            Text("Unknown")
                .foregroundColor(.gray)
        }
    }
}
