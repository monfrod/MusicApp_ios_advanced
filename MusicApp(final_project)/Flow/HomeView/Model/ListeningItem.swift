//
//  ListeningItem.swift
//  MusicApp(final_project)
//
//  Created by yunus on 12.05.2025.
//
import UIKit
import SwiftUI

struct ListeningItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String? // Например, "Top New Songs" или "RELEASED"
    let imageName: String // Имя системного изображения-заглушки или URL для реальных данных
    let backgroundColor: Color
}

struct ForYouItem: Identifiable {
    let id = UUID()
    let title: String // Например, "Pop Mix", "Chill Mix"
    let imageName: String // Имя системного изображения-заглушки или URL
    let backgroundColor: Color
    let tracks: [TrackItem]// Может быть использован как фон, если изображение не загрузилось
}

struct RecentItem: Identifiable, Hashable {
    let id = UUID()
    let title: String? // Может не быть явного заголовка на карточке
    let subtitle: String? // Например, исполнитель
    let imageName: String
    let backgroundColor: Color
}
