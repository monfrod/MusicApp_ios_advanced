//
//  GenreItem.swift
//  MusicApp(final_project)
//
//  Created by yunus on 12.05.2025.
//
import SwiftUI

struct GenreItem: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let imageName: String?
    let backgroundColor: Color
}
