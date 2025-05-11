//
//  HomeView.swift
//  MusicApp(final_project)
//
//  Created by yunus on 03.05.2025.
//
import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Приветствие
                    greetingSection
                    
                    // Продолжить прослушивание
                    continueListeningSection
                    
                    // Рекомендации
                    recommendationsSection(title: "Your Top Mixes", items: topMixes)
                    
                    // На основе вашего прослушивания
                    recommendationsSection(title: "Based on your recent listening", items: recentListening)
                }
                .padding()
            }
            .background(Color.black) // Fixed black background
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: TopTracksView()) {
                        Image(systemName: "music.note.list")
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
    
    // MARK: - Компоненты
    
    private var greetingSection: some View {
        VStack(alignment: .leading) {
            Text("Welcome back!")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("chandrama")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    }
    
    private var continueListeningSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Continue Listening")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(continueListeningItems, id: \.self) { item in
                        NavigationLink(destination: PlaylistView()) {
                            VStack(alignment: .leading) {
                                Image(item.lowercased().replacingOccurrences(of: " ", with: ""))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150)
                                    .cornerRadius(8)
                                
                                Text(item)
                                    .font(.subheadline)
                                    .lineLimit(1)
                                    .foregroundColor(.white)
                            }
                            .frame(width: 150)
                        }
                    }
                }
            }
        }
    }
    
    private func recommendationsSection(title: String, items: [String]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(continueListeningItems, id: \.self) { item in
                        NavigationLink(destination: PlaylistView()) {
                            VStack(alignment: .leading) {
                                Image(item.lowercased().replacingOccurrences(of: " ", with: ""))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150)
                                    .cornerRadius(8)
                                
                                Text(item)
                                    .font(.subheadline)
                                    .lineLimit(1)
                                    .foregroundColor(.white)
                            }
                            .frame(width: 150)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Данные
    
    private let continueListeningItems = [
        "Coffee & Jazz",
        "Anything Goes",
        "Harry's House",
        "Tom Now Songs",
        "Anime OSTs",
        "Lo-Fi Beats"
    ]
    
    private let topMixes = [
        "Pop Mix",
        "Chill Mix"
    ]
    
    private let recentListening = [
        "Rock Mix",
        "Workout Mix",
        "Focus Mix"
    ]
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
