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
    
    var body: some View {
        ZStack {
            Color(.white)
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: match.avatarURL ?? ""), content: view)
                Text(match.name ?? "Title Not Found!")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding([.leading, .top, .trailing], 16)
                
                Text("\(match.age ?? 0), \(match.address ?? "")")
                    .font(.system(size: 16))
                    .foregroundStyle(.secondary)
                    .padding(16)
                
                HStack {
                    Button(action: {}) {
                            Image(systemName: "multiply")
                          }
                          .padding()
                          .background(.blue)
                          .foregroundColor(.white)
                          .cornerRadius(.infinity)
                    Button(action: {}) {
                            Image(systemName: "checkmark")
                          }
                          .padding()
                          .background(.blue)
                          .foregroundColor(.white)
                          .cornerRadius(.infinity)
                }
            }
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
