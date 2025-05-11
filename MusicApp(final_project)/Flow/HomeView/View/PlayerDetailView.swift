//
//  PlayerDetailView.swift
//  MusicApp(final_project)
//
//  Created by Диас Нургалиев on 10.05.2025.
//

import SwiftUI

struct PlayerDetailView: View {
    var track: Track
    @State private var isPlaying = true
    @State private var currentTime: Double = 0.0
    let duration: Double = 163

    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 16) {
            // Close button
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.down")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                }
                Spacer()
            }

            Text("PLAYING FROM PLAYLIST:")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.horizontal)

            Text("Lofi Lofi")
                .font(.subheadline)
                .bold()
                .foregroundColor(.white)
                .padding(.horizontal)

            Image(uiImage: UIImage(named: track.imageName) ?? UIImage(systemName: "music.note")!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 240)
                .cornerRadius(12)
                .padding()

            VStack(spacing: 4) {
                Text(track.title)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                Text(track.artist)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Slider(value: $currentTime, in: 0...duration)
                .accentColor(.cyan)
                .padding(.horizontal)

            HStack {
                Text(formatTime(currentTime))
                Spacer()
                Text(formatTime(duration))
            }
            .font(.caption)
            .foregroundColor(.gray)
            .padding(.horizontal)

            HStack(spacing: 40) {
                Image(systemName: "backward.fill")
                Button(action: { isPlaying.toggle() }) {
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.cyan)
                }
                Image(systemName: "forward.fill")
            }
            .foregroundColor(.white)

            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Lyrics here...")
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.cyan.opacity(0.2))
                .cornerRadius(16)
                .padding(.horizontal)
            }

            Spacer()
        }
        .background(Color.black.ignoresSafeArea())
    }

    private func formatTime(_ time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
