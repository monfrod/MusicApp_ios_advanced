//
//  Track.swift
//  MusicApp(final_project)
//
//  Created by Диас Нургалиев on 10.05.2025.
//
import UIKit

struct Track: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let artist: String
    let imageName: String
}
