//
//  TrackRow.swift
//  MusicApp(final_project)
//
//  Created by yunus on 12.05.2025.
//

import SwiftUI

struct PlaylistView: View {
    let title: String
    let tracks: [TrackItem]
    @EnvironmentObject var playerManager: MusicPlayerManager
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    
                    LazyVStack(spacing: 12) {
                        ForEach(tracks) { track in
                            SimpleListItemView(track: track)
                                .onTapGesture {
                                    Task {
                                        await playerManager.playTrack(track)
                                    }
                                }
                        }
                    }
                    .padding(.horizontal) // Горизонтальные отступы для списка
                }
            }
            .padding(.top) // Отступ сверху для всего содержимого ScrollView
        }
        .background {
            LinearGradient(
                gradient: Gradient(colors: [Color.gradient, Color.black]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.large)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}


// 4. Упрощенное представление для элемента списка
struct SimpleListItemView: View {
    let track: TrackItem
    
    var body: some View {
        HStack(spacing: 12) {
            if let imageUrlString = track.track.coverUri {
                let resolvedUrlString = imageUrlString.replacingOccurrences(of: "%%", with: "100x100")
                if let url = URL(string: "https://\(resolvedUrlString)") {
                    AsyncImage(url: url) { phase in
                        if let image = phase.image {
                            image.resizable()
                        } else if phase.error != nil {
                            Image(systemName: "photo")
                                .resizable()
                                .foregroundColor(.gray)
                        } else {
                            ProgressView()
                        }
                    }
                    .frame(width: 50, height: 50)
                    .cornerRadius(4)
                    .clipped()
                } else {
                    Image(systemName: "music.note")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .padding(10)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(4)
                        .foregroundColor(.white)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(track.track.title)
                        .font(.headline)
                        .foregroundColor(.white)
                        .lineLimit(1)
                    Text(track.track.artists[0].name)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
                
                Spacer()
            }
        }
    }
}
