import SwiftUI


// MARK: - Основное View экрана
struct ExploreView: View {
    @StateObject private var viewModel = ExploreViewModel()
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                SearchBar(text: $viewModel.searchText)
                    .padding(.horizontal)
                
                SectionView(title: "Your Top Genres", items: viewModel.topGenres, columns: columns)
                
                SectionView(title: "Browse All", items: viewModel.browseAllCategories, columns: columns)
                
                Spacer()
            }
            .padding(.vertical)
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.gradient, Color.black]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
        )
    }
}

// MARK: - Компоненты View (SearchBar, SectionView, GenreCardView)


struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing = false
    
    var body: some View {
        HStack {
            TextField("Songs, Artists, Podcasts & More", text: $text)
                .padding(10)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
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
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
            
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Cancel") // Локализация может потребоваться
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
            }
        }
    }
}

struct SectionView: View {
    let title: String
    let items: [GenreItem]
    let columns: [GridItem]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(items) { item in
                    // Теперь NavigationLink должен работать с родительским UINavigationController
                    // Для этого UIHostingController, содержащий ExploreView, должен быть
                    // частью стека UINavigationController. В вашем TabController это так,
                    // так как сам TabController помещен в rootVC (UINavigationController).
                    NavigationLink(destination: Text("Детальный экран для: \(item.name)").navigationTitle(item.name) ) {
                         GenreCardView(item: item)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct GenreCardView: View {
    let item: GenreItem
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let imageName = item.imageName {
                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
                    .overlay(
                        LinearGradient(gradient: Gradient(colors: [.black.opacity(0.0), .black.opacity(0.4)]),
                                       startPoint: .center, endPoint: .bottom)
                    )
            } else {
                item.backgroundColor
            }
            
            Text(item.name)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(12)
        }
        .frame(height: 100)
        .background(item.backgroundColor.opacity(item.imageName != nil ? 0.3 : 1.0))
        .cornerRadius(12)
    }
}

