//
//  TrackRow.swift
//  MusicApp(final_project)
//
//  Created by yunus on 12.05.2025.
//
import SwiftUI

struct PlaylistView: View {
    let playlistTitle: String
    let playlistDescription: String
    let playlistCoverImageUrl: String?
    let tracks: [TrackItem]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .center, spacing: 20) { // Increased main VStack spacing
                    // --- Playlist Header ---
                    VStack(spacing: 8) {
                        // Playlist Cover Image
                        // Uses AsyncImage to load from a URL, with a placeholder system image.
                        AsyncImage(url: URL(string: playlistCoverImageUrl ?? "")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            // Placeholder if the image is loading or URL is invalid/nil
                            Image("lofi_main_placeholder") // Ensure you have this image in your assets
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .background(Color.gray.opacity(0.3)) // Placeholder background
                        }
                        .frame(width: 250, height: 250)
                        .cornerRadius(10) // Slightly less corner radius as per screenshot
                        .clipped()
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5) // Subtle shadow

                        // Playlist Title
                        Text(playlistTitle)
                            .font(.system(size: 28, weight: .bold)) // Larger and bolder title
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)

                        // Playlist Description
                        Text(playlistDescription)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(Color(white: 0.7)) // Lighter gray for description
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30) // Add some horizontal padding
                    }
                    .padding(.top, 10) // Add some padding at the top of the header
                    .padding(.bottom, 20) // Add some padding below the header

                    // --- Track List ---
                    // LazyVStack is efficient for long lists as it only loads items as they appear.
                    LazyVStack(spacing: 12) { // Spacing between track rows
                        ForEach(tracks) { track in
                            NavigationLink(destination: PlayerDetailView(track: track)) {
                                TrackRow(track: track)
                            }
                        }
                    }
                    .padding(.horizontal) // Add horizontal padding to the list
                }
                .padding(.vertical) // Add overall vertical padding to the VStack content
            }
            .background(Color.black.edgesIgnoringSafeArea(.all)) // Dark background for the entire view
            .navigationBarTitleDisplayMode(.inline) // Uses the toolbar item for the title
            .toolbar {

                // Centered Title in Toolbar
                ToolbarItem(placement: .principal) {
                    Text("FROM \"PLAYLISTS\"") // As per screenshot
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(Color(white: 0.6)) // Light gray color
                }

                // Trailing Ellipsis Button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Action for the ellipsis menu
                        print("Ellipsis menu tapped")
                    }) {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.white)
                            // The screenshot shows a vertical ellipsis, which is the default for "ellipsis"
                            // If you need a horizontal one, you might use "ellipsis.circle" or a custom image.
                            // The rotationEffect in your original code makes it horizontal.
                            // .rotationEffect(.degrees(90)) // Uncomment if you want horizontal ellipsis
                    }
                }
            }
            .toolbarColorScheme(.dark, for: .navigationBar) // Ensures nav bar items (like back button text) are white
        }
    }
}

// 4. Track Row View
// Extracted the track row into its own subview for better organization and reusability.
struct TrackRow: View {
    let track: TrackItem

    var body: some View {
        HStack(spacing: 12) {
            // Track Cover Image
            AsyncImage(url: URL(string: track.coverUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                // Placeholder if the image is loading or URL is invalid/nil
                Image(track.imageName ?? "track_placeholder") // Ensure you have a default track placeholder
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .background(Color.gray.opacity(0.2))
            }
            .frame(width: 48, height: 48) // Slightly smaller as per screenshot
            .cornerRadius(6) // Slightly less corner radius
            .clipped()

            // Track Title and Artist
            VStack(alignment: .leading, spacing: 4) {
                Text(track.title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .lineLimit(1) // Ensure title doesn't wrap excessively

                Text(track.artist)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(Color(white: 0.6)) // Light gray for artist
                    .lineLimit(1)
            }

            Spacer() // Pushes the ellipsis to the right

            // More Options Button (Ellipsis)
            Image(systemName: "ellipsis")
                .foregroundColor(Color(white: 0.7)) // Light gray for ellipsis
                .frame(width: 30, height: 30) // Make it easier to tap
                .contentShape(Rectangle()) // Increase tappable area
                .onTapGesture {
                    // Action for this specific track's ellipsis
                    print("Ellipsis for \(track.title) tapped")
                }
        }
        .padding(.vertical, 6) // Add a little vertical padding to each row
    }
}
