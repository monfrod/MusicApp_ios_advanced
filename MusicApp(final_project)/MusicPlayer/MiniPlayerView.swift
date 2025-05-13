//
//  MiniPlayerView.swift
//  MusicApp(final_project)
//
//  Created by yunus on 12.05.2025.
//
import SwiftUI

struct MiniPlayerView: View {
    @EnvironmentObject var playerManager: MusicPlayerManager
    var onTapAction: () -> Void
    
    var body: some View {
        let _ = print("MiniPlayerView body. currentTrack: \(playerManager.currentTrack?.title ?? "nil"), isPlaying: \(playerManager.isPlaying)")
        if let track = playerManager.currentTrack {
            VStack(spacing: 0) {
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
                
                HStack(spacing: 12) {
                    
                    AsyncImage(url: playerManager.currentTrack?.coverURL) { image in
                        image.resizable().aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Rectangle().fill(Color.gray.opacity(0.5))
                            .overlay(Image(systemName: "music.note").foregroundColor(.white.opacity(0.7)))
                    }
                    .frame(width: 40, height: 40)
                    .cornerRadius(4)
                    .clipped()
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(track.title)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                            .lineLimit(1)
                        HStack(spacing: 4) {
                            ForEach(track.artistNames, id: \.self) { artist in
                                Text(artist)
                                    .font(.system(size: 12))
                                    .foregroundColor(Color(white: 0.7))
                                    .lineLimit(1)
                            }
                        }
                    }
                    .padding(.leading, 4)
                    
                    Spacer()
                    
                    Button(action: {
                        playerManager.togglePlayPause()
                    }) {
                        Image(systemName: playerManager.isPlaying ? "pause.fill" : "play.fill")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .frame(height: 60)
            .background(Color(UIColor.systemGray5.withAlphaComponent(0.2)))
            .contentShape(Rectangle())
            .onTapGesture {
                onTapAction()
            }
            .background(.ultraThinMaterial)
            .transition(.move(edge: .bottom).combined(with: .opacity))
            .frame(height: 63)
        }
    }
}
