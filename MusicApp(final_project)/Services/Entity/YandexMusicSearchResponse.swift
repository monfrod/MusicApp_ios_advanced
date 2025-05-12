//
//  YandexMusicSearchResponse.swift
//  MusicApp(final_project)
//
//  Created by yunus on 11.05.2025.
//


import Foundation

// MARK: - Root Search Response
struct YandexMusicSearchResponse: Codable {
    let searchRequestId: String?
    let text: String?
    let best: BestMatch?
    let albums: AlbumsSearchSection?
    let artists: ArtistsSearchSection? // Добавлено для полноты, структура аналогична другим секциям
    let playlists: PlaylistsSearchSection? // Добавлено для полноты
    let tracks: TracksSearchSection?
    let videos: GenericSearchSection? // Общая структура для секций с неизвестным содержимым
    let users: GenericSearchSection?
    let podcasts: GenericSearchSection?
    let podcastEpisodes: PodcastEpisodesSearchSection?

    enum CodingKeys: String, CodingKey {
        case searchRequestId = "search_request_id"
        case text, best, albums, artists, playlists, tracks, videos, users, podcasts
        case podcastEpisodes = "podcast_episodes"
    }
}

// MARK: - Best Match
struct BestMatch: Codable {
    let type: String?
    let result: ArtistResult? // В вашем примере это Artist, может потребоваться обобщение
    let text: String?
}

// MARK: - Artist
struct ArtistResult: Codable, Identifiable {
    let id: Int
    let name: String?
    let cover: Cover?
    let various: Bool?
    let composer: Bool?
    let genres: [String]?
    let ogImage: String?
    let counts: ArtistCounts?
    let available: Bool?
    let ratings: ArtistRatings?
    let links: [ArtistLink]?
    let ticketsAvailable: Bool?
    let popularTracks: [TrackSearchResult]? // Обычно это TrackShort или Track
    let regions: [String]?
    let description: String? // В примере null, но может быть

    enum CodingKeys: String, CodingKey {
        case id, name, cover, various, composer, genres, counts, available, ratings, links, regions, description
        case ogImage = "og_image"
        case ticketsAvailable = "tickets_available"
        case popularTracks = "popular_tracks"
    }
}

struct Cover: Codable {
    let type: String?
    let uri: String?
    let prefix: String?
}

struct ArtistCounts: Codable {
    let tracks: Int?
    let directAlbums: Int?
    let alsoAlbums: Int?
    let alsoTracks: Int?

    enum CodingKeys: String, CodingKey {
        case tracks
        case directAlbums = "direct_albums"
        case alsoAlbums = "also_albums"
        case alsoTracks = "also_tracks"
    }
}

struct ArtistRatings: Codable {
    let month: Int?
    let week: Int?
    let day: Int?
}

struct ArtistLink: Codable {
    let title: String?
    let href: String?
    let type: String?
    let socialNetwork: String?

    enum CodingKeys: String, CodingKey {
        case title, href, type
        case socialNetwork = "social_network"
    }
}

// MARK: - Albums Section
struct AlbumsSearchSection: Codable {
    let type: String?
    let total: Int?
    let perPage: Int?
    let order: Int?
    let results: [AlbumSearchResult]?

    enum CodingKeys: String, CodingKey {
        case type, total, order, results
        case perPage = "per_page"
    }
}

struct AlbumSearchResult: Codable, Identifiable {
    let id: Int
    let title: String?
    let trackCount: Int?
    let artists: [ArtistInAlbum]? // Может быть упрощенная структура Artist
    let labels: [String]?
    let available: Bool?
    let availableForPremiumUsers: Bool?
    let version: String?
    let coverUri: String?
    let genre: String?
    let year: Int?
    let releaseDate: String? // Можно декодировать в Date с кастомной стратегией
    let type: String? // "single", "compilation", "album"
    let ogImage: String?
    let likesCount: Int?
    let regions: [String]?
    let availableRegions: [String]?

    enum CodingKeys: String, CodingKey {
        case id, title, artists, labels, available, version, genre, year, type, regions
        case trackCount = "track_count"
        case availableForPremiumUsers = "available_for_premium_users"
        case coverUri = "cover_uri"
        case releaseDate = "release_date"
        case ogImage = "og_image"
        case likesCount = "likes_count"
        case availableRegions = "available_regions"
    }
}

// Упрощенная структура для артиста в альбоме/треке
struct ArtistInAlbum: Codable, Identifiable {
    let id: Int
    let name: String?
    let cover: Cover?
    // Можно добавить другие поля, если они есть и нужны
}


// MARK: - Artists Section (Примерная структура)
struct ArtistsSearchSection: Codable {
    let type: String?
    let total: Int?
    let perPage: Int?
    let order: Int?
    let results: [ArtistResult]? // Используем полную структуру ArtistResult

    enum CodingKeys: String, CodingKey {
        case type, total, order, results
        case perPage = "per_page"
    }
}

// MARK: - Playlists Section (Примерная структура)
struct PlaylistsSearchSection: Codable {
    let type: String?
    let total: Int?
    let perPage: Int?
    let order: Int?
    let results: [PlaylistSearchResult]?

    enum CodingKeys: String, CodingKey {
        case type, total, order, results
        case perPage = "per_page"
    }
}

struct PlaylistSearchResult: Codable, Identifiable {
    // Поля плейлиста из вашего JSON (owner, cover, title, trackCount, kind, uid и т.д.)
    let kind: Int // В вашем JSON 'kind' у плейлиста - это ID исполнителя/плейлиста
    let uid: Int // UID владельца
    let title: String?
    let trackCount: Int?
    let cover: Cover?
    let owner: PlaylistOwner?
    let ogImage: String?
    // ... и другие поля плейлиста

    var id: Int { kind } // Используем kind как Identifiable ID, т.к. он уникален для плейлиста в контексте владельца

    enum CodingKeys: String, CodingKey {
        case kind, uid, title, cover, owner
        case trackCount = "track_count"
        case ogImage = "og_image"
    }
}

struct PlaylistOwner: Codable {
    let uid: Int
    let login: String?
    let name: String?
}


// MARK: - Tracks Section
struct TracksSearchSection: Codable {
    let type: String?
    let total: Int?
    let perPage: Int?
    let order: Int?
    let results: [TrackSearchResult]?

    enum CodingKeys: String, CodingKey {
        case type, total, order, results
        case perPage = "per_page"
    }
}

struct TrackSearchResult: Codable, Identifiable {
    let id: Int // В вашем JSON это Int
    let realId: String? // В вашем JSON это String
    let title: String?
    let available: Bool?
    let artists: [ArtistInAlbum]? // Переиспользуем ArtistInAlbum
    let albums: [AlbumInTrack]?
    let ogImage: String?
    let type: String? // "music", "podcast-episode"
    let coverUri: String?
    let durationMs: Int?
    let explicit: Bool?
    let lyricsInfo: LyricsInfo?
    let r128: NormalizationData?
    let regions: [String]?
    // ... другие поля трека

    enum CodingKeys: String, CodingKey {
        case id, title, available, artists, albums, type, regions
        case realId = "real_id"
        case ogImage = "og_image"
        case coverUri = "cover_uri"
        case durationMs = "duration_ms"
        case explicit
        case lyricsInfo = "lyrics_info"
        case r128
    }
}

struct AlbumInTrack: Codable, Identifiable {
    let id: Int
    let title: String?
    let trackCount: Int?
    let artists: [ArtistInAlbum]?
    let coverUri: String?
    let year: Int?
    let genre: String?
    let trackPosition: TrackPosition?
    // ... другие поля альбома в треке

    enum CodingKeys: String, CodingKey {
        case id, title, artists, year, genre
        case trackCount = "track_count"
        case coverUri = "cover_uri"
        case trackPosition = "track_position"
    }
}

struct LyricsInfo: Codable {
    let hasAvailableSyncLyrics: Bool?
    let hasAvailableTextLyrics: Bool?

    enum CodingKeys: String, CodingKey {
        case hasAvailableSyncLyrics = "has_available_sync_lyrics"
        case hasAvailableTextLyrics = "has_available_text_lyrics"
    }
}

struct NormalizationData: Codable { // Для r128
    let i: Double?
    let tp: Double?
}

// MARK: - Podcast Episodes Section
struct PodcastEpisodesSearchSection: Codable {
    let type: String?
    let total: Int?
    let perPage: Int?
    let order: Int?
    let results: [PodcastEpisodeResult]?

    enum CodingKeys: String, CodingKey {
        case type, total, order, results
        case perPage = "per_page"
    }
}

struct PodcastEpisodeResult: Codable, Identifiable {
    let id: Int
    let title: String?
    let available: Bool?
    let albums: [AlbumInTrack]? // Альбом здесь - это сам подкаст
    let durationMs: Int?
    let shortDescription: String?
    let coverUri: String?
    let type: String? // "podcast-episode"
    // ... другие поля эпизода подкаста

    enum CodingKeys: String, CodingKey {
        case id, title, available, albums, type
        case durationMs = "duration_ms"
        case shortDescription = "short_description"
        case coverUri = "cover_uri"
    }
}

// MARK: - Generic Section (для videos, users, podcasts, если их структура неизвестна или проста)
struct GenericSearchSection: Codable {
    let type: String?
    let total: Int?
    let perPage: Int?
    // Могут быть и другие общие поля, или results: [AnyDecodable]?
    
    enum CodingKeys: String, CodingKey {
        case type, total
        case perPage = "per_page"
    }
}


// MARK: - Пример декодирования
/*
func decodeSearchResponse(jsonData: Data) {
    let decoder = JSONDecoder()
    do {
        let searchResponse = try decoder.decode(YandexMusicSearchResponse.self, from: jsonData)
        
        // Пример доступа к данным:
        if let bestArtistName = searchResponse.best?.result?.name {
            print("Лучшее совпадение (артист): \(bestArtistName)")
        }
        
        if let firstAlbumTitle = searchResponse.albums?.results?.first?.title {
            print("Первый альбом в результатах: \(firstAlbumTitle)")
        }

        if let firstTrackTitle = searchResponse.tracks?.results?.first?.title {
            print("Первый трек в результатах: \(firstTrackTitle)")
            if let firstTrackArtist = searchResponse.tracks?.results?.first?.artists?.first?.name {
                print("Исполнитель первого трека: \(firstTrackArtist)")
            }
        }
        
    } catch {
        print("Ошибка декодирования JSON: \(error)")
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            print("Проблемный JSON: \(jsonString)")
        }
    }
}

// Предположим, у вас есть jsonData с ответом API
// decodeSearchResponse(jsonData: yourJSONData)
*/
