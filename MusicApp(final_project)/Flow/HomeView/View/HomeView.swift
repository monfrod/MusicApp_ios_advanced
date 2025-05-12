import SwiftUI

// MARK: - Основное View экрана Home
struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    
    // Колонки для секций с большими карточками
    let twoColumnGrid: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 30) {
                
                // 1. Приветствие и иконки действий
                HomeHeaderView(userName: viewModel.userName)
                    .padding(.horizontal)
                
                // 2. Секция "Continue Listening"
                ContinueListeningSectionView(items: viewModel.continueListeningItems)
                
                // 3. Секция "Your Top Mixes"
                HorizontalImageCardsSectionView(
                    title: "For You",
                    items: viewModel.topMixes,
                    cardViewBuilder: { mixItem in
                        MixCardView(item: mixItem)
                    }
                )
                
                // 4. Секция "Based on your recent listening"
                HorizontalImageCardsSectionView(
                    title: "Based on your recent listening",
                    items: viewModel.recentListening,
                    cardViewBuilder: { recentItem in
                        RecentItemCardView(item: recentItem)
                    }
                )
                
                Spacer() // Чтобы контент прижимался к верху, если его мало
            }
            .padding(.top, 10) // Небольшой отступ сверху для всего ScrollView
            .padding(.bottom, 30) // Отступ снизу
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.gradient, Color.black]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
        )
        .foregroundColor(.white) // Основной цвет текста белый
        .task {
            await viewModel.getForYou()
        }
    }
}

// MARK: - Компоненты View

struct HomeHeaderView: View {
    let userName: String
    
    var body: some View {
        HStack {
            // Аватарка пользователя (заглушка)
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 44, height: 44)
                .foregroundColor(.gray)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text("Welcome back!")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Text(userName)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            
            Spacer()
            
            // Иконки действий
            HStack(spacing: 20) {
                Button(action: { /* Действие для уведомлений */ }) {
                    Image("bell")
                        .font(.title3)
                }
                Button(action: { /* Действие для недавних */ }) {
                    Image("Vector") // Пример иконки, похожей на "недавние" или "фильтры"
                        .font(.title3)
                }
                Button(action: { /* Действие для настроек */ }) {
                    Image("settings")
                        .font(.title3)
                }
            }
            .foregroundColor(.gray) // Цвет иконок
        }
    }
}

struct ContinueListeningSectionView: View {
    let items: [ListeningItem]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Continue Listening")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(items) { item in
                        NavigationLink(destination: Text("Экран для \(item.title)").navigationTitle(item.title)) {
                            ContinueListeningCard(item: item)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 4) // Небольшой вертикальный отступ для тени карточки
            }
        }
    }
}

struct ContinueListeningCard: View {
    let item: ListeningItem
    
    var body: some View {
        HStack(spacing: 0) {
            // Изображение или иконка
            // В реальном приложении здесь будет AsyncImage или Image
            Image(systemName: item.imageName)
                .font(.title3)
                .foregroundColor(.white)
                .frame(width: 60, height: 60)
                .background(item.backgroundColor)
            
            // Текст
            Text(item.title)
                .font(.caption)
                .fontWeight(.medium)
                .lineLimit(2)
                .padding(.horizontal, 8)
                .frame(width: 90, height: 60, alignment: .leading) // Фиксированная ширина для текста
                .background(Color(.systemGray5).opacity(0.7)) // Чуть темнее фон для текста
        }
        .frame(width: 150, height: 60) // Общий размер карточки
        .cornerRadius(6)
        .clipped() // Чтобы фон не выходил за скругленные углы
    }
}


// Общая секция для горизонтально прокручиваемых карточек с изображениями
struct HorizontalImageCardsSectionView<Item: Identifiable & Hashable, CardContent: View>: View {
    let title: String
    let items: [Item]
    @ViewBuilder let cardViewBuilder: (Item) -> CardContent
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(items) { item in
                        viewModel.
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 4)
            }
        }
    }
    
    // Вспомогательная функция для извлечения заголовка, если он есть
    private func extractTitle(from item: Item) -> String? {
        if let mixItem = item as? ForYouItem {
            return mixItem.title
        } else if let recentItem = item as? RecentItem {
            return recentItem.title ?? recentItem.subtitle
        }
        return nil
    }
}

struct MixCardView: View {
    let item: ForYouItem
    let cardWidth: CGFloat = 200
    let cardHeight: CGFloat = 240 // Увеличил высоту для заголовка под картинкой

    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                item.backgroundColor // Фон на случай отсутствия изображения
                AsyncImage(url: URL(string: item.imageName))
                    .aspectRatio(contentMode: .fit)
                    .frame(width: cardWidth, height: cardWidth) // Квадратное изображение
                    .clipped()
            }
            .frame(width: cardWidth, height: cardWidth)
            .cornerRadius(8)
            
            Text(item.title)
                .font(.subheadline)
                .fontWeight(.medium)
                .lineLimit(1)
                .padding(.top, 4)
        }
        .frame(width: cardWidth)
    }
}

struct RecentItemCardView: View {
    let item: RecentItem
    let cardWidth: CGFloat = 150
    let cardHeight: CGFloat = 190 // Увеличил высоту для заголовка/подзаголовка

    var body: some View {
         VStack(alignment: .leading) {
            ZStack {
                item.backgroundColor
                Image(systemName: item.imageName) // Заглушка
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: cardWidth, height: cardWidth)
                    .clipped()
            }
            .frame(width: cardWidth, height: cardWidth)
            .cornerRadius(8)
            
            if let title = item.title, !title.isEmpty {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .lineLimit(1)
                    .padding(.top, 4)
            }
            if let subtitle = item.subtitle, !subtitle.isEmpty {
                 Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
        }
        .frame(width: cardWidth)
    }
}


