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
                    LazyVStack(spacing: 0) {
                        ForEach(tracks) { trackItem in
                            SimpleListItemView(trackItem: trackItem)
                                .padding(.bottom, 1)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    if let appTrack = AppTrack(from: trackItem.track) {
                                        Task {
                                            await playerManager.playTrack(appTrack)
                                        }
                                    } else {
                                        print("Error: Could not convert track \(trackItem.track.title) to AppTrack.")
                                    }
                                }
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer().frame(height: 50)
                }
            }
            .padding(.top)
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
}


struct SimpleListItemView: View {
    let trackItem: TrackItem
    
    private var artistDisplayName: String {
        return trackItem.track.artists.first?.name ?? "Unknown Artist"
    }
    
    private var coverImageUrl: URL? {
        guard let coverUriTemplate = trackItem.track.coverUri else { return nil }
        
        if coverUriTemplate.contains("%%") {
            let resolvedUrlString = coverUriTemplate.replacingOccurrences(of: "%%", with: "100x100")
            return URL(string: "https://\(resolvedUrlString)")
        } else if let url = URL(string: coverUriTemplate), url.scheme != nil {
            return url
        } else if let url = URL(string: "https://\(coverUriTemplate)") {
            return url
        }
        return nil
    }

    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: coverImageUrl) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 50, height: 50)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(4)
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .frame(width: 50, height: 50)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(4)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 50, height: 50)
            .cornerRadius(4)
            .clipped()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(trackItem.track.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(1)
                Text(artistDisplayName)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
}
