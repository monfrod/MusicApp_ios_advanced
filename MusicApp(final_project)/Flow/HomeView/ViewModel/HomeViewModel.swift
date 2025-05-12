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
    
    @Published var topMixes: [ForYouItem] = []
    
    @Published var recentListening: [RecentItem] = [
        RecentItem(title: nil, subtitle: "Artist Name 1", imageName: "photo.artframe", backgroundColor: Color.gray.opacity(0.3)),
        RecentItem(title: nil, subtitle: "Artist Name 2", imageName: "cassette.fill", backgroundColor: Color.gray.opacity(0.3)),
        RecentItem(title: "Album Title 3", subtitle: "Artist Name 3", imageName: "opticaldisc", backgroundColor: Color.gray.opacity(0.3))
    ]
    
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
