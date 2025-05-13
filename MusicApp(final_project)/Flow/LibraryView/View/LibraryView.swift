//
//  HomeView.swift
//  MusicApp(final_project)
//
//  Created by yunus on 03.05.2025.
//
import SwiftUI

struct LibraryView: View {
    @StateObject var viewModel: LibraryViewModel
    var playerManager: MusicPlayerManager
    
    let backgroundColorStart = Color("gradient", bundle: nil)
    let backgroundColorEnd = Color.black
    let textColor = Color.white
    let secondaryTextColor = Color.gray
    let accentColor = Color.blue

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    LikedSongsRow(count: viewModel.likedSongsCount)
                        .onTapGesture {
                            print("Navigate to liked songs")
                        }
                        .padding(.horizontal)
                    
                    Text("Downloaded Tracks")
                        .font(.title2.bold())
                        .foregroundColor(textColor)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: textColor))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                    } else if viewModel.downloadedTracks.isEmpty {
                        Text("You have no downloaded tracks yet.")
                            .foregroundColor(secondaryTextColor)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                    } else {
                        LazyVStack(spacing: 0) {
                            ForEach(viewModel.downloadedTracks) { track in
                                DownloadedTrackRowView(track: track)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        Task {
                                            await playerManager.playTrack(track)
                                        }
                                    }
                                Divider().background(Color.gray.opacity(0.3)).padding(.leading, 70)
                            }
                        }
                        .padding(.horizontal)
                    }
                    Spacer()
                }
                .padding(.top)
            }
            .background(LinearGradient(gradient: Gradient(colors: [backgroundColorStart, backgroundColorEnd]), startPoint: .top, endPoint: .bottom).ignoresSafeArea())
            .navigationTitle("Library")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct LikedSongsRow: View {
    let count: Int
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: "heart.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
                .padding(15)
                .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(6)
            
            VStack(alignment: .leading) {
                Text("Liked Songs")
                    .font(.headline)
                    .foregroundColor(.white)
                Text("\(count) tracks")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}

struct DownloadedTrackRowView: View {
    let track: AppTrack
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: track.coverURL) { phase in
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
                    // Icon for downloaded track default removed
                    EmptyView()
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 50, height: 50)
            .cornerRadius(4)
            .clipped()
            
            VStack(alignment: .leading, spacing: 4) {
                Text(track.title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .lineLimit(1)
                Text(track.artistNames.joined(separator: ", "))
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            
            Spacer()
            
            Button {
                print("Actions for track: \(track.title)")
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundColor(.gray)
                    .padding(8)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.vertical, 10)
    }
}

