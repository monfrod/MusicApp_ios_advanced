//
//  PlaylistView.swift
//  MusicApp(final_project)
//
//  Created by Диас Нургалиев on 11.05.2025.
//

import SwiftUI

struct PlaylistView: View {
    let tracks: [Track] = [
        Track(title: "grainy days", artist: "moody.", imageName: "grainy"),
        Track(title: "Coffee", artist: "Kainbeats", imageName: "grainy"),
        Track(title: "raindrops", artist: "rainyyxx", imageName: "grainy"),
        Track(title: "Tokyo", artist: "SmYang", imageName: "grainy"),
        Track(title: "Lullaby", artist: "iamfinenow", imageName: "grainy"),
        Track(title: "Hazel Eyes", artist: "moody.", imageName: "grainy"),
        Track(title: "Track 7", artist: "moody.", imageName: "grainy"),
        Track(title: "Track 8", artist: "moody.", imageName: "grainy"),
        Track(title: "Track 9", artist: "moody.", imageName: "grainy"),
        Track(title: "Track 10", artist: "moody.", imageName: "grainy")
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    // Playlist Image & Title (static block)
                    VStack {
                        Image("grainy")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 250, height: 250)
                            .cornerRadius(16)
                            .clipped()

                        Text("Lofi Loft")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 8)

                        Text("soft, chill, dreamy, lo-fi beats")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 16)

                    // Track list
                    VStack(spacing: 16) {
                        ForEach(tracks) { track in
                            NavigationLink(destination: PlayerDetailView(track: track)) {
                                HStack {
                                    Image(track.imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(8)
                                    
                                    VStack(alignment: .leading) {
                                        Text(track.title)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text(track.artist)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    Image(systemName: "ellipsis")
                                        .foregroundColor(.white)
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
                .padding(.top, 16)
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("FROM \"PLAYLISTS\"")
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Menu action
                    }) {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.degrees(90))
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView()
    }
}
