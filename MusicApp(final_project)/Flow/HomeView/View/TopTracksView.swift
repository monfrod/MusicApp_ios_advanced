////
////  TopTracksView.swift
////  MusicApp(final_project)
////
////  Created by Диас Нургалиев on 10.05.2025.
////
//
//import SwiftUI
//
//struct TopTracksView: View {
//    @State private var selectedCategory = "Tracks"
//    @State private var selectedRange = "30 days"
//    @State private var selectedTrack: Track? = nil
//
//    let categories = ["Tracks", "Artists", "Albums"]
//    let timeRanges = ["30 days", "6 Months", "1 Year", "Lifetime"]
//
//
//    var body: some View {
//        VStack(alignment: .center) {
//            Text("Past 30 Days")
//                .font(.caption)
//                .foregroundColor(.gray)
//                .padding(.horizontal)
//
//            tabSection
//
//            trackList
//
//            timeFilterBar
//        }
//        .background(Color.black.edgesIgnoringSafeArea(.all))
//        .navigationTitle("Top")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                HStack(spacing: 20) {
//                    Image(systemName: "square.grid.2x2").foregroundColor(.white)
//                    Image(systemName: "plus").foregroundColor(.white)
//                }
//            }
//        }
//        .toolbar(.hidden, for: .tabBar)
//        .sheet(item: $selectedTrack) { track in
//            PlayerDetailView(track: track)
//        }
//    }
//
//    private var tabSection: some View {
//        HStack {
//            ForEach(categories, id: \.self) { category in
//                VStack {
//                    Text(category)
//                        .foregroundColor(selectedCategory == category ? .white : .gray)
//                        .bold()
//                    Capsule()
//                        .fill(selectedCategory == category ? Color.cyan : Color.clear)
//                        .frame(height: 3)
//                }
//                .onTapGesture {
//                    selectedCategory = category
//                }
//                Spacer()
//            }
//        }
//        .padding(.horizontal)
//    }
//
//    private var trackList: some View {
//        ScrollView {
//            VStack(spacing: 12) {
//                ForEach(Array(tracks.enumerated()), id: \.1.id) { index, track in
//                    Button(action: {
//                        selectedTrack = track
//                    }) {
//                        trackRow(rank: index + 1, track: track)
//                    }
//                }
//            }
//            .padding()
//        }
//    }
//
//    private func trackRow(rank: Int, track: Track) -> some View {
//        HStack(spacing: 12) {
//            Text("#\(rank)")
//                .font(.headline)
//                .foregroundColor(.white)
//                .frame(width: 30)
//
//            RoundedRectangle(cornerRadius: 8)
//                .fill(Color.gray.opacity(0.3))
//                .frame(width: 50, height: 50)
//                .overlay(Text("🎵"))
//
//            VStack(alignment: .leading) {
//                Text(track.title)
//                    .foregroundColor(.white)
//                Text(track.artist)
//                    .font(.caption)
//                    .foregroundColor(.gray)
//            }
//            Spacer()
//        }
//        .padding()
//        .background(Color.black.opacity(0.4))
//        .cornerRadius(12)
//    }
//
//    private var timeFilterBar: some View {
//        HStack {
//            ForEach(timeRanges, id: \.self) { range in
//                Text(range)
//                    .foregroundColor(selectedRange == range ? .cyan : .gray)
//                    .onTapGesture {
//                        selectedRange = range
//                    }
//                    .frame(maxWidth: .infinity)
//            }
//        }
//        .padding(.horizontal)
//        .padding(.bottom, 10)
//    }
//}
