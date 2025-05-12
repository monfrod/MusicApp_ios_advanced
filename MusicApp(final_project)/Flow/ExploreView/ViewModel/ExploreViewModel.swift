//
//  ExploreViewModel.swift
//  MusicApp(final_project)
//
//  Created by yunus on 12.05.2025.
//
import SwiftUI

// MARK: - ViewModel (заглушка для данных)
class ExploreViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var topGenres: [GenreItem] = [
        GenreItem(name: "Kpop", imageName: "music.mic.circle", backgroundColor: .green.opacity(0.7)),
        GenreItem(name: "Indie", imageName: "guitars", backgroundColor: .pink.opacity(0.7)),
        GenreItem(name: "R&B", imageName: "music.note.list", backgroundColor: .blue.opacity(0.6)),
        GenreItem(name: "Pop", imageName: "star.fill", backgroundColor: .orange.opacity(0.7))
    ]
    @Published var browseAllCategories: [GenreItem] = [
        GenreItem(name: "Made for You", imageName: "person.crop.square.fill", backgroundColor: .cyan.opacity(0.7)),
        GenreItem(name: "RELEASED", imageName: "flame.fill", backgroundColor: .purple.opacity(0.7)),
        GenreItem(name: "Music Charts", imageName: "chart.bar.fill", backgroundColor: .indigo.opacity(0.7)),
        GenreItem(name: "Podcasts", imageName: "mic.fill", backgroundColor: .red.opacity(0.6)),
        GenreItem(name: "Bollywood", imageName: "film.fill", backgroundColor: .yellow.opacity(0.6)),
        GenreItem(name: "Pop Fusion", imageName: "music.quarternote.3", backgroundColor: .teal.opacity(0.7))
    ]
}
