//
//  PlaylistData.swift
//  MusicApp(final_project)
//
//  Created by yunus on 11.05.2025.
//

struct PlaylistData: Codable {
    let playlist: [PlaylistResponse]
}

struct PlaylistResponse: Codable {
    let title: String
    let coverImageURL: String
    let tracks: [TrackItem]
    let trackCountFromData: Int
    let fetchedTrackCount: Int
    
    enum CodingKeys: String, CodingKey {
        case title
        case coverImageURL = "cover_image_url"
        case tracks
        case trackCountFromData = "track_count_from_data"
        case fetchedTrackCount = "fetched_track_count"
    }
}

struct TrackItem: Codable {
    let id: Int
    let timestamp: String
    let albumId: Int?
    let playCount: Int?
    let recent: Bool
    let chart: String?
    let track: Track
    let originalIndex: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case timestamp
        case albumId = "album_id"
        case playCount = "play_count"
        case recent
        case chart
        case track
        case originalIndex = "original_index"
    }
}

struct Artist: Codable {
    let id: Int
    let error: String?
    let reason: String?
    let name: String
    let cover: Cover
    let various: Bool
    let composer: Bool
    let genres: [String] // Assuming empty array type
    let ogImage: String?
    let opImage: String?
    let noPicturesFromSearch: String?
    let counts: String?
    let available: Bool
    let ratings: String?
    let links: [String] // Assuming empty array type
    let ticketsAvailable: String?
    let likesCount: String?
    let popularTracks: [String] // Assuming empty array type
    let regions: String?
    let decomposed: String?
    let fullNames: String?
    let handMadeDescription: String?
    let description: String?
    let countries: String?
    let enWikipediaLink: String?
    let dbAliases: String?
    let aliases: String?
    let initDate: String?
    let endDate: String?
    let yaMoneyId: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case error
        case reason
        case name
        case cover
        case various
        case composer
        case genres
        case ogImage = "og_image"
        case opImage = "op_image"
        case noPicturesFromSearch = "no_pictures_from_search"
        case counts
        case available
        case ratings
        case links
        case ticketsAvailable = "tickets_available"
        case likesCount = "likes_count"
        case popularTracks = "popular_tracks"
        case regions
        case decomposed
        case fullNames = "full_names"
        case handMadeDescription = "hand_made_description"
        case description
        case countries
        case enWikipediaLink = "en_wikipedia_link"
        case dbAliases = "db_aliases"
        case aliases
        case initDate = "init_date"
        case endDate = "end_date"
        case yaMoneyId = "ya_money_id"
    }
}


struct Album: Codable {
    let id: Int
    let error: String?
    let title: String
    let trackCount: Int
    let artists: [Artist]
    let labels: [Label]
    let available: Bool
    let availableForPremiumUsers: Bool
    let version: String?
    let coverUri: String
    let contentWarning: String?
    let originalReleaseYear: String?
    let genre: String
    let textColor: String?
    let shortDescription: String?
    let description: String?
    let isPremiere: String?
    let isBanner: String?
    let metaType: String
    let storageDir: String?
    let ogImage: String
    let buy: String?
    let recent: Bool
    let veryImportant: Bool
    let availableForMobile: Bool
    let availablePartially: Bool
    let bests: [Int]?
    let duplicates: [String] // Assuming empty array type
    let prerolls: String?
    let volumes: String?
    let year: Int
    let releaseDate: String
    let type: String?
    let trackPosition: TrackPosition
    let regions: String?
    let availableAsRbt: String?
    let lyricsAvailable: String?
    let rememberPosition: String?
    let albums: [String] // Assuming empty array type
    let durationMs: String?
    let explicit: String?
    let startDate: String?
    let likesCount: Int
    let deprecation: String?
    let availableRegions: String?
    let availableForOptions: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case error
        case title
        case trackCount = "track_count"
        case artists
        case labels
        case available
        case availableForPremiumUsers = "available_for_premium_users"
        case version
        case coverUri = "cover_uri"
        case contentWarning = "content_warning"
        case originalReleaseYear = "original_release_year"
        case genre
        case textColor = "text_color"
        case shortDescription = "short_description"
        case description
        case isPremiere = "is_premiere"
        case isBanner = "is_banner"
        case metaType = "meta_type"
        case storageDir = "storage_dir"
        case ogImage = "og_image"
        case buy
        case recent
        case veryImportant = "very_important"
        case availableForMobile = "available_for_mobile"
        case availablePartially = "available_partially"
        case bests
        case duplicates
        case prerolls
        case volumes
        case year
        case releaseDate = "release_date"
        case type
        case trackPosition = "track_position"
        case regions
        case availableAsRbt = "available_as_rbt"
        case lyricsAvailable = "lyrics_available"
        case rememberPosition = "remember_position"
        case albums
        case durationMs = "duration_ms"
        case explicit
        case startDate = "start_date"
        case likesCount = "likes_count"
        case deprecation
        case availableRegions = "available_regions"
        case availableForOptions = "available_for_options"
    }
}

struct Track: Codable {
    let id: String
    let title: String
    let available: Bool
    let artists: [Artist]
    let albums: [Album]
    let availableForPremiumUsers: Bool
    let lyricsAvailable: Bool
    let poetryLoverMatches: [String] // Assuming empty array type
    let best: String?
    let realId: String
    let ogImage: String
    let type: String
    let coverUri: String
    let major: Major
    let durationMs: Int
    let storageDir: String
    let fileSize: Int
    let substituted: String?
    let matchedTrack: String?
    let normalization: String?
    let error: String?
    let canPublish: String?
    let state: String?
    let desiredVisibility: String?
    let filename: String?
    let userInfo: String?
    let metaData: String?
    let regions: String?
    let availableAsRbt: String?
    let contentWarning: String?
    let explicit: String?
    let previewDurationMs: Int
    let availableFullWithoutPermission: Bool
    let version: String?
    let rememberPosition: Bool
    let backgroundVideoUri: String?
    let shortDescription: String?
    let isSuitableForChildren: String?
    let trackSource: String
    let availableForOptions: [String]
    let r128: R128
    let lyricsInfo: LyricsInfo
    let trackSharingFlag: String
    let downloadInfo: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case available
        case artists
        case albums
        case availableForPremiumUsers = "available_for_premium_users"
        case lyricsAvailable = "lyrics_available"
        case poetryLoverMatches = "poetry_lover_matches"
        case best
        case realId = "real_id"
        case ogImage = "og_image"
        case type
        case coverUri = "cover_uri"
        case major
        case durationMs = "duration_ms"
        case storageDir = "storage_dir"
        case fileSize = "file_size"
        case substituted
        case matchedTrack = "matched_track"
        case normalization
        case error
        case canPublish = "can_publish"
        case state
        case desiredVisibility = "desired_visibility"
        case filename
        case userInfo = "user_info"
        case metaData = "meta_data"
        case regions
        case availableAsRbt = "available_as_rbt"
        case contentWarning = "content_warning"
        case explicit
        case previewDurationMs = "preview_duration_ms"
        case availableFullWithoutPermission = "available_full_without_permission"
        case version
        case rememberPosition = "remember_position"
        case backgroundVideoUri = "background_video_uri"
        case shortDescription = "short_description"
        case isSuitableForChildren = "is_suitable_for_children"
        case trackSource = "track_source"
        case availableForOptions = "available_for_options"
        case r128
        case lyricsInfo = "lyrics_info"
        case trackSharingFlag = "track_sharing_flag"
        case downloadInfo = "download_info"
    }
}

struct Label: Codable {
    let id: Int
    let name: String
}

struct TrackPosition: Codable {
    let volume: Int
    let index: Int
}

struct Major: Codable {
    let id: Int
    let name: String
}

struct R128: Codable {
    let i: Double
    let tp: Double
}

