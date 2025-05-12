//
//  ChartItemData.swift
//  MusicApp(final_project)
//
//  Created by yunus on 11.05.2025.
//


import Foundation

// Структура для представления одного чарта
struct ChartItemData: Decodable{
    let chartTitle: String
    let chartCoverImageUrl: String? // Может быть плейсхолдером или отсутствовать
    let trackIds: [String]

    enum CodingKeys: String, CodingKey {
        case chartTitle = "chart_title"
        case chartCoverImageUrl = "chart_cover_image_url"
        case trackIds = "track_ids"
    }
}

// Корневая структура для всего JSON-ответа
struct ChartsApiResponse: Decodable {
    let charts: [ChartItemData]
    let errors: [String]? // Массив строк для ошибок, может быть null
}
