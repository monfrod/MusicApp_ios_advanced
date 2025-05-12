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
        HStack() {
            VStack(alignment: .leading, spacing: 4) {
                Text(track.track.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(1)
                Text(track.track.artists[0].name)
            }
            Spacer() // Занимает оставшееся пространство, прижимая контент влево
        }
        .padding(10) // Внутренние отступы для каждой ячейки
        .background(Color.gray.opacity(0.15)) // Легкий фон для каждой ячейки
        .cornerRadius(10)
    }
}
