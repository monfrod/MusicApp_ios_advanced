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
    @Published var isLoading: Bool = false
    
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
    
    func createDownloadedTrack(title: String, artists: String, songData: Data, image: Data) {
        CoreDataManager.shared.createNewTrack(
            title: title,
            artists: artists,
            songData: songData,
            image: image
        )
    }
    func downloadAndSaveTrack(id: Int, title: String, artist: String, imageUrlString: String) async {
        do {
            // 1. Получаем аудиофайл по API (примерный endpoint)
            let endpoint = "/download/\(id)"
            let audioData: Data = try await services.fetchRawData(endpoint: endpoint)
            
            // 2. Загружаем изображение
            let resolvedUrlString = imageUrlString.replacingOccurrences(of: "%%", with: "200x200")
            let fullUrl = "https://\(resolvedUrlString)"
            
            guard let imageUrl = URL(string: fullUrl),
                  let (imageData, _) = try? await URLSession.shared.data(from: imageUrl) else {
                print("⚠️ Failed to load image from URL")
                return
            }
            
            // 4. Сохраняем в Core Data
            CoreDataManager.shared.createNewTrack(
                title: title,
                artists: artist,
                songData: audioData,
                image: imageData        
            )
            
            print("✅ Track saved: \(title) by \(artist)")
        } catch {
            print("❌ Failed to download track: \(error)")
        }
    }
    
}
