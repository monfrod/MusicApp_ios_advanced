//
//  AppTrack.swift
//  MusicApp(final_project)
//
//  Created by yunus on 13.05.2025.
//

import SwiftUI
import AVFoundation
import OSLog

struct AppTrack: Identifiable, Equatable {
    let id: String
    let title: String
    let artistNames: [String]
    let coverURL: URL?
    let durationMilliseconds: Int

    static func == (lhs: AppTrack, rhs: AppTrack) -> Bool {
        return lhs.id == rhs.id
    }

    init?(from trackDetails: Track?) {
        guard let trackDetails = trackDetails else { return nil }
        
        guard !trackDetails.id.isEmpty else {
            print("AppTrack init error: Track.id is empty.")
            return nil
        }
        self.id = trackDetails.id
        self.title = trackDetails.title
        self.artistNames = trackDetails.artists.map { $0.name }
        
        if let coverUriTemplate = trackDetails.coverUri {
            if coverUriTemplate.contains("%%") {
                let resolvedUrlString = coverUriTemplate.replacingOccurrences(of: "%%", with: "200x200")
                self.coverURL = URL(string: "https://\(resolvedUrlString)")
            } else if let url = URL(string: coverUriTemplate), url.scheme != nil {
                 self.coverURL = url
            } else if let url = URL(string: "https://\(coverUriTemplate)") {
                 self.coverURL = url
            }
            else {
                self.coverURL = nil
            }
        } else {
            self.coverURL = nil
        }
        self.durationMilliseconds = trackDetails.durationMs
    }

    init?(from searchResult: TrackSearchResult?) {
        guard let searchResult = searchResult else { return nil }

        let trackIdString: String
        if let realId = searchResult.realId, !realId.isEmpty {
            trackIdString = realId
        } else {
            trackIdString = String(searchResult.id)
        }
        guard !trackIdString.isEmpty else {
            print("AppTrack init error: Resulting track ID from TrackSearchResult is empty.")
            return nil
        }
        self.id = trackIdString
        
        self.title = searchResult.title ?? "Без названия"
        self.artistNames = searchResult.artists?.compactMap { $0.name } ?? ["Неизвестный исполнитель"]
        
        var tempCoverUrl: URL? = nil
        let sizesToTry = ["200x200", "100x100", "50x50"]

        if let coverUriTemplate = searchResult.coverUri, !coverUriTemplate.isEmpty {
            for size in sizesToTry {
                let resolvedUrlString = coverUriTemplate.replacingOccurrences(of: "%%", with: size)
                if let url = URL(string: "https://\(resolvedUrlString)") {
                    tempCoverUrl = url
                    break
                }
            }
        }
        if tempCoverUrl == nil, let ogImageTemplate = searchResult.ogImage, !ogImageTemplate.isEmpty {
            for size in sizesToTry {
                let resolvedUrlString = ogImageTemplate.replacingOccurrences(of: "%%", with: size)
                if let url = URL(string: "https://\(resolvedUrlString)") {
                    tempCoverUrl = url
                    break
                }
            }
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
