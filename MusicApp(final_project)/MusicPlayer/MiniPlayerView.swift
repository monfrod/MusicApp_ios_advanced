//
//  MiniPlayerView.swift
//  MusicApp(final_project)
//
//  Created by yunus on 12.05.2025.
//
import SwiftUI

struct MiniPlayerView: View {
    @EnvironmentObject var playerManager: MusicPlayerManager
    @Binding var showPlayerDetail: Bool // Для управления показом PlayerDetailView

    var body: some View {
        // Отображаем MiniPlayer только если есть текущий трек
        if let track = playerManager.currentTrack {
            VStack(spacing: 0) {
                // Progress Bar
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 3)
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: geometry.size.width * CGFloat(playerManager.playbackProgress), height: 3)
                    }
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                let progress = min(max(0, Double(value.location.x / geometry.size.width)), 1)
                                playerManager.seek(to: progress)
                            }
                    )
                }
                .frame(height: 3)
                
                HStack(spacing: 15) {
//                    AsyncImage(url: URL(string: track.track.coverUri ?? "")) { image in
//                        image.resizable().aspectRatio(contentMode: .fill)
//                    } placeholder: {
//                        Rectangle().fill(Color.gray.opacity(0.5))
//                            .overlay(Image(systemName: "music.note").foregroundColor(.white))
//                    }
//                    .frame(width: 40, height: 40)
//                    .cornerRadius(4)
//                    .clipped()

                    VStack(alignment: .leading, spacing: 2) {
                        Text(track.track.title)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                            .lineLimit(1)
                        Text(track.track.artists[0].name)
                            .font(.system(size: 12))
                            .foregroundColor(Color(white: 0.7))
                            .lineLimit(1)
                    }
                    
                    Spacer()

                    Button(action: {
                        playerManager.togglePlayPause()
                    }) {
                        Image(systemName: playerManager.isPlaying ? "pause.fill" : "play.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    .padding(.trailing, 10)
                }
                .padding(.horizontal)
                .padding(.vertical, 8) // Уменьшаем вертикальный padding для компактности
                .frame(height: 60) // Фиксированная высота для мини-плеера
                .background(Color(red: 0.15, green: 0.15, blue: 0.15)) // Фон для мини-плеера
                .onTapGesture {
                    showPlayerDetail = true // Показать детальный экран плеера
                }
            }
            .transition(.move(edge: .bottom).combined(with: .opacity)) // Анимация появления/исчезновения
        }
    }
}
