//
//  ExploreViewModel.swift
//  MusicApp(final_project)
//
//  Created by yunus on 12.05.2025.
//
import SwiftUI

// MARK: - ViewModel (заглушка для данных)
class ExploreViewModel: ObservableObject {
    
    let services: YandexApiServices
    
    init(services: YandexApiServices) {
        self.services = services
    }
    
    @Published var searchText: String = ""
    @Published var searchResults: [TrackSearchResult] = []
    
    func getSearchByTracks(text: String) async {
        do {
            let response: YandexMusicSearchResponse = try await services.fetchData(endpoint: "/search?query=\(text)")
            // Обнови опубликованное свойство с результатами, например:
            DispatchQueue.main.async {
                let result: [TrackSearchResult] = response.tracks?.results ?? []
                self.searchResults = result
                print("🔍 Найдено \(response.tracks?.total) треков")
            }
        } catch {
            print("❌ Ошибка поиска: \(error)")
        }
    }
    
}
