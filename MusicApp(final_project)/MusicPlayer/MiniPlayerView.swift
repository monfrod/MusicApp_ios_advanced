//
//  MiniPlayerView.swift
//  MusicApp(final_project)
//
//  Created by yunus on 12.05.2025.
//
import SwiftUI

struct MiniPlayerView: View {
    @EnvironmentObject var playerManager: MusicPlayerManager
    var onTapAction: () -> Void // Замыкание для обработки нажатия

    var body: some View {
        let _ = print("MiniPlayerView body. currentTrack: \(playerManager.currentTrack?.track.title ?? "nil"), isPlaying: \(playerManager.isPlaying)")
        if let track = playerManager.currentTrack {
            VStack(spacing: 0) {
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3)) // Фон прогресс-бара
                            .frame(height: 3)
                        Rectangle()
                            .fill(Color.white) // Заполненная часть прогресс-бара
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
                .frame(height: 3) // Высота прогресс-бара
                
                HStack(spacing: 12) { // Уменьшен spacing
//                    AsyncImage(url: URL(string: track. ?? "")) { image in
//                        image.resizable().aspectRatio(contentMode: .fill)
//                    } placeholder: {
//                        Rectangle().fill(Color.gray.opacity(0.5))
//                            .overlay(Image(systemName: "music.note").foregroundColor(.white.opacity(0.7)))
//                    }
//                    .frame(width: 40, height: 40)
//                    .cornerRadius(4)
//                    .clipped()

                    VStack(alignment: .leading, spacing: 2) {
                        Text(track.track.title)
                            .font(.system(size: 14, weight: .semibold)) // Немного жирнее
                            .foregroundColor(.white)
                            .lineLimit(1)
                        HStack(spacing: 4) {
                            ForEach(track.track.artists, id: \.id) { artist in
                                Text(artist.name)
                                    .font(.system(size: 12))
                                    .foregroundColor(Color(white: 0.7))
                                    .lineLimit(1)
                            }
                        }
                    }
                    .padding(.leading, 4) // Небольшой отступ для текста
                    
                    Spacer()

                    Button(action: {
                        playerManager.togglePlayPause()
                    }) {
                        Image(systemName: playerManager.isPlaying ? "pause.fill" : "play.fill")
                            .font(.system(size: 22)) // Размер иконки плей/пауза
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40) // Увеличиваем область нажатия
                    }
                    // .padding(.trailing, 5) // Уменьшен отступ
                }
                .padding(.horizontal, 12) // Горизонтальные отступы
                .padding(.vertical, 8)  // Вертикальные отступы
                .frame(height: 60) // Общая высота контентной части мини-плеера
                .background(Color(UIColor.systemGray5.withAlphaComponent(0.2))) // Полупрозрачный фон, близкий к системному
                .contentShape(Rectangle()) // Делаем всю область HStack таппабельной
                .onTapGesture {
                    onTapAction() // Вызываем замыкание при нажатии
                }
            }
            .background(.ultraThinMaterial) // Эффект размытия фона для iOS 15+
            .transition(.move(edge: .bottom).combined(with: .opacity))
            .frame(height: 63) // Общая высота MiniPlayerView, включая прогресс-бар
        } else {
            EmptyView() // Не отображаем ничего, если нет текущего трека
        }
    }
}
