//
//  AppTrack.swift
//  MusicApp(final_project)
//
//  Created by yunus on 13.05.2025.
//


import SwiftUI
import AVFoundation
import OSLog // Для логирования

// MARK: - Унифицированная модель трека для UI и плеера
struct AppTrack: Identifiable, Equatable { // Добавим Equatable для сравнения
    let id: String              // Уникальный строковый ID трека (для стриминга)
    let title: String
    let artistNames: [String]
    let coverURL: URL?
    let durationMilliseconds: Int
    // Добавьте другие общие поля, если нужны

    // Для Equatable
    static func == (lhs: AppTrack, rhs: AppTrack) -> Bool {
        return lhs.id == rhs.id // Сравниваем по ID
    }

    // MARK: - Инициализаторы для преобразования

    /// Инициализатор из `Track` (который находится внутри `TrackItem` из плейлиста)
    init?(from trackDetails: Track?) { // Сделаем инициализатор failable, если trackDetails может быть nil
        guard let trackDetails = trackDetails else { return nil }
        
        // Убедимся, что trackDetails.id не nil и не пустой, иначе трек невалиден для AppTrack
        // В вашей модели Track.id - это String, не опциональный, так что проверка на nil не нужна,
        // но на пустую строку может быть полезна, если API может вернуть пустой ID.
        guard !trackDetails.id.isEmpty else {
            print("AppTrack init error: Track.id is empty.")
            return nil
        }
        self.id = trackDetails.id
        self.title = trackDetails.title // В вашей модели Track.title не опциональный
        self.artistNames = trackDetails.artists.map { $0.name } // В вашей модели Artist.name не опциональный
        
        if let coverUriTemplate = trackDetails.coverUri { // coverUri в Track опциональный
            // Предполагаем, что coverUri может быть полным URL или шаблоном
            if coverUriTemplate.contains("%%") {
                let resolvedUrlString = coverUriTemplate.replacingOccurrences(of: "%%", with: "200x200")
                self.coverURL = URL(string: "https://\(resolvedUrlString)")
            } else if let url = URL(string: coverUriTemplate), url.scheme != nil { // Проверяем, является ли это уже полным URL
                 self.coverURL = url
            } else if let url = URL(string: "https://\(coverUriTemplate)") { // Пытаемся добавить https, если это не полный URL
                 self.coverURL = url
            }
            else {
                self.coverURL = nil
            }
        } else {
            self.coverURL = nil
        }
        self.durationMilliseconds = trackDetails.durationMs // В вашей модели Track.durationMs не опциональный
    }

    /// Инициализатор из `TrackSearchResult`
    init?(from searchResult: TrackSearchResult?) { // Сделаем инициализатор failable
        guard let searchResult = searchResult else { return nil }

        // Для ID используем realId если есть, иначе приводим Int ID к String
        // Убедимся, что итоговый ID не пустой
        let trackIdString: String
        if let realId = searchResult.realId, !realId.isEmpty {
            trackIdString = realId
        } else {
            trackIdString = String(searchResult.id) // searchResult.id это Int
        }
        guard !trackIdString.isEmpty else {
            print("AppTrack init error: Resulting track ID from TrackSearchResult is empty.")
            return nil
        }
        self.id = trackIdString
        
        self.title = searchResult.title ?? "Без названия"
        self.artistNames = searchResult.artists?.compactMap { $0.name } ?? ["Неизвестный исполнитель"]
        
        var tempCoverUrl: URL? = nil
        let sizesToTry = ["200x200", "100x100", "50x50"] // Размеры для попытки

        // Пробуем coverUri
        if let coverUriTemplate = searchResult.coverUri, !coverUriTemplate.isEmpty {
            for size in sizesToTry {
                let resolvedUrlString = coverUriTemplate.replacingOccurrences(of: "%%", with: size)
                if let url = URL(string: "https://\(resolvedUrlString)") {
                    tempCoverUrl = url
                    break
                }
            }
        }
        // Если coverUri не дал результата, пробуем ogImage
        if tempCoverUrl == nil, let ogImageTemplate = searchResult.ogImage, !ogImageTemplate.isEmpty {
            for size in sizesToTry {
                 // ogImage обычно не содержит '%%', а является прямым шаблоном URL
                 // или уже готовым URL. Если это шаблон типа avatars.yandex.net/.../%%, то замена нужна.
                 // Если это прямой URL, замена не нужна.
                 // Для примера, если ogImage может быть шаблоном:
                let resolvedUrlString = ogImageTemplate.replacingOccurrences(of: "%%", with: size)
                if let url = URL(string: "https://\(resolvedUrlString)") { // или просто URL(string: ogImageTemplate) если это полный URL
                    tempCoverUrl = url
                    break
                }
            }
             // Если ogImage - это уже готовый URL:
            if tempCoverUrl == nil, let url = URL(string: ogImageTemplate), url.scheme != nil {
                tempCoverUrl = url
            } else if tempCoverUrl == nil, let url = URL(string: "https://\(ogImageTemplate)") {
                 tempCoverUrl = url
            }
        }
        self.coverURL = tempCoverUrl
        
        self.durationMilliseconds = searchResult.durationMs ?? 0
    }
}
