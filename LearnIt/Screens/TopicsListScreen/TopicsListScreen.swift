import SwiftUI

struct TopicsListScreen: View {
    @EnvironmentObject private var selectedLanguageViewModel: SelectedLanguageViewModel
    
    @State private var showChangeLanguageScreen = false
    @State private var selectedTopic: Topic?
    
    var body: some View {
        VStack(spacing: 0) {
            changeLanguageTopButton
            
            ScrollView {
                if selectedLanguageViewModel.selectedLanguage != nil {
                    ProgressCardView(title: "Progress", progressPercent: selectedLanguageViewModel.progressTopicsPercent)
                        .padding(.top, 20)
                    
                    topicCells
                        .padding(.top, 10)
                        .padding(.horizontal, 22)
                }
            }
        }
        .background(.appPurple5)
        .sheet(isPresented: $showChangeLanguageScreen) {
            SelectLanguageScreen()
        }
        .fullScreenCover(item: $selectedTopic) { topic in
            QuizScreen(topic: topic)
        }
    }
}

private extension TopicsListScreen {
    var topicCells: some View {
        VStack(spacing: 22) {
            ForEach(selectedLanguageViewModel.selectedLanguage?.topics ?? [], id: \.id) { topic in
                Button {
                    goToTopic(topic)
                } label: {
                    TopicCellView(topic: topic)
                }
            }
        }
    }
    
    var changeLanguageTopButton: some View {
        Button {
           showChangeLanguageScreen = true
        } label: {
            HStack {
                Spacer()
                
                Text(selectedLanguageViewModel.selectedLanguage?.name ?? "Select language")
                    .font(.system(size: 19, weight: .semibold))
                
                Spacer()
                
                Image(systemName: "arrow.2.squarepath")
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 8)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.appPurple3)
            )
            .padding(.horizontal, 8)
            .foregroundStyle(.white)
            .padding(.bottom, 10)
        }
        .background(.appPurple4)
    }
    
    func goToTopic(_ topic: Topic) {
        selectedTopic = topic
    }
}

struct TopicCellView: View {
    let topic: Topic
    
    private let cornerRadius: CGFloat = 20
    private let backgroundColor: Color = .appPurple4
    private let borderColor: Color = .appPurple3
    
    init(topic: Topic) {
        self.topic = topic
    }
    
    var body: some View {
        HStack {
            Text(topic.name)
                .font(.system(size: 22, weight: .semibold))
            
            Spacer()
            
            Text("\(topic.questions.count)")
                .font(.system(size: 18, weight: .medium))
                .padding(12)
                .overlay(
                    Circle()
                        .stroke(borderColor, lineWidth: 3)
                )
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 22)
        .padding(.vertical, 22)
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(backgroundColor)
        )
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(borderColor, lineWidth: 3)
        )
        
    }
}

#Preview {
    CoordinatorView()
}
