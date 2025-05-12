import SwiftUI


// MARK: - Основное View экрана
struct ExploreView: View {
    
    @StateObject var viewModel: ExploreViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                SearchBar(text: $viewModel.searchText, viewModel: viewModel)
                    .padding(.horizontal)
                
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
    let viewModel: ExploreViewModel
    
    var body: some View {
        HStack {
            TextField("Songs, Artists, Podcasts & More", text: $text)
                .padding(10)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
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
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
                .onSubmit {
                    guard !text.isEmpty else { return}
                    Task {
                        await viewModel.getSearchByTracks(text: text)
                    }
                    print("🔍 Поиск по: \(text)")
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
