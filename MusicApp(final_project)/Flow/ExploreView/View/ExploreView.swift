import SwiftUI


// MARK: - Основное View экрана
struct ExploreView: View {
    
    let playerManager: MusicPlayerManager
    @StateObject var viewModel: ExploreViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    SearchBar(text: $viewModel.searchText, viewModel: viewModel)
                        .padding(.horizontal)
                    
                    if viewModel.isLoading {
                        HStack {
                            Spacer()
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            Spacer()
                        }
                        .padding(.top, 20)
                    } else if viewModel.searchResults.isEmpty && !viewModel.searchText.isEmpty && !viewModel.isLoading {
                        Text("No results found for \"\(viewModel.searchText)\".")
                            .foregroundColor(.gray)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                    } else if !viewModel.searchResults.isEmpty {
                        Text("Search Results:")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        LazyVStack(spacing: 0) {
                            ForEach(viewModel.searchResults) { trackItem in
                                TrackRowView(trackItem: trackItem, playerManager: playerManager, viewModel: viewModel)
                                    .padding(.horizontal)
                                    .padding(.vertical, 4)
                            }
                        }
                    }
                    
                    Spacer().frame(height: 50)
                }
                .padding(.top)
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.gradient, Color.black]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
            )
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.large)
            // Скрытие клавиатуры при скролле (iOS 16+)
            .scrollDismissesKeyboard(.interactively)
        }
        .accentColor(.white)
    }
}

// MARK: - Компоненты View

struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing = false
    @ObservedObject var viewModel: ExploreViewModel
    
    var body: some View {
        HStack {
            TextField("Songs, artists, podcasts, etc.", text: $text)
                .padding(10)
                .padding(.leading, 25)
                .background(Color(.systemGray6))
                .foregroundColor(Color.primary)
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image("search")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if isEditing && !text.isEmpty {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .onTapGesture {
                    withAnimation {
                        self.isEditing = true
                    }
                }
                .onSubmit {
                    guard !text.isEmpty else {
                        return
                    }
                    Task {
                        await viewModel.getSearchByTracks(text: text)
                    }
                    print("🔍 Поиск по: \(text)")
                }
            
            if isEditing {
                Button(action: {
                    withAnimation {
                        self.isEditing = false
                    }
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Cancel")
                        .foregroundColor(.white)
                }
                .padding(.leading, 5)
                .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
    }
}

// MARK: - Строка для отображения трека в списке результатов
struct TrackRowView: View {
    let trackItem: TrackSearchResult
    let playerManager: MusicPlayerManager
    let viewModel: ExploreViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            if let imageUrlString = trackItem.coverUri,
               let resolvedUrlString = imageUrlString.replacingOccurrences(of: "%%", with: "200x200") as String?,
               let url = URL(string: "https://\(resolvedUrlString)") {

                AsyncImage(url: url) { phase in
                    if let image = phase.image {
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .cornerRadius(4)
                            .clipped()
                    } else if phase.error != nil {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(4)
                            .foregroundColor(.gray)
                    } else {
                        ProgressView()
                            .frame(width: 50, height: 50)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(4)
                    }
                }
            } else {
                Image(systemName: "music.note")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .padding(10)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(4)
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading) {
                Text(trackItem.title ?? "Untitled")
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(1)
                if let artists = trackItem.artists, !artists.isEmpty {
                    Text(artists.compactMap { $0.name }.joined(separator: ", "))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                } else {
                    Text("Unknown Artist")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
            }
            
            Spacer()
            
            HStack(spacing: 16) {
                Button(action: {
                    let artistNames = trackItem.artists?.compactMap { $0.name }.joined(separator: ", ") ?? "Unknown Artist"
                    Task {
                        await viewModel.downloadAndSaveTrack(id: trackItem.id,
                                                             title: trackItem.title ?? "Untitled",
                                                             artist: artistNames,
                                                             imageUrlString: trackItem.coverUri ?? "")
                    }
                }) {
                    Image(systemName: "arrow.down.circle")
                        .foregroundColor(.white)
                }

                Image(systemName: "ellipsis")
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
        // Для срабатывания onTapGesture по всей строке
        .background(Color.black.opacity(0.001))
        .onTapGesture {
            print("Нажат трек: \(trackItem.title ?? "")")
            if let appTrack = AppTrack(from: trackItem) {
                Task {
                    await playerManager.playTrack(appTrack)
                }
            } else {
                print("Error: Could not convert track \(trackItem.title) to AppTrack.")
            }
        }
    }
}
