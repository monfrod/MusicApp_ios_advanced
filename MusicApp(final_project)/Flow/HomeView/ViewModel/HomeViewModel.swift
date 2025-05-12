//
//  HomeViewModel.swift
//  MusicApp(final_project)
//
//  Created by yunus on 12.05.2025.
//
import UIKit
import SwiftUI

class HomeViewModel: ObservableObject {
    
    let service: YandexApiServices
    let router: MainRouter
    init(service: YandexApiServices, router: MainRouter) {
        self.service = service
        self.router = router
    }
    
    @Published var userName: String = "chandrama" // Имя пользователя
    
    @Published var continueListeningItems: [ListeningItem] = [
        ListeningItem(title: "Coffee & Jazz", subtitle: nil, imageName: "cup.and.saucer.fill", backgroundColor: .brown.opacity(0.7)),
        ListeningItem(title: "Top New Songs", subtitle: "RELEASED", imageName: "music.note.tv.fill", backgroundColor: .green.opacity(0.7)),
        ListeningItem(title: "Anything Goes", subtitle: nil, imageName: "shuffle.circle.fill", backgroundColor: .blue.opacity(0.7)),
        ListeningItem(title: "Anime OSTs", subtitle: nil, imageName: "film.stack.fill", backgroundColor: .purple.opacity(0.7)),
        ListeningItem(title: "Harry's House", subtitle: nil, imageName: "house.fill", backgroundColor: .orange.opacity(0.7)),
        ListeningItem(title: "Lo-Fi Beats", subtitle: nil, imageName: "headphones.circle.fill", backgroundColor: .teal.opacity(0.7))
    ]
    
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
    
    @Published var topMixes: [ForYouItem] = []
    
    func getForYou() async {
        do {
            let playlistData: [PlaylistResponse] = try await service.fetchData(endpoint: "/mixes")
            
            let mappedMixes = playlistData.map { item in
                ForYouItem(
                    title: item.title,
                    imageName: item.coverImageURL,
                    backgroundColor: Color.gray.opacity(0.3),
                    tracks: item.tracks
                )
            }
            
            DispatchQueue.main.async {
                self.topMixes = mappedMixes
            }
            
        } catch {
            print("Ошибка при загрузке плейлистов: \(error)")
        }
    }
}
