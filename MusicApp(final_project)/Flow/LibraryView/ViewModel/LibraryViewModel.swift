//
//  LibraryViewModel.swift
//  MusicApp(final_project)
//
//  Created by yunus on 13.05.2025.
//
import UIKit

class LibraryViewModel: ObservableObject {
    @Published var likedSongsCount: Int = 123
    @Published var downloadedTracks: [AppTrack] = []
    @Published var isLoading: Bool = false
    init() {
        fetchDownloadedTracks()
    }

    func fetchDownloadedTracks() {
        
    }
    
    func clearDownloads() {
        downloadedTracks = []
    }
}
