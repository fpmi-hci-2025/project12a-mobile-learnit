import SwiftUI

struct SelectLanguageScreen: View {
    @EnvironmentObject private var selectedLanguageViewModel: SelectedLanguageViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            navigationBarView
            
            ScrollView  {
                languagesCells
                    .padding(.top)
            }
            .padding(.horizontal)
        }
        .background(.appPurple5)
    }
}

private extension SelectLanguageScreen {
    var navigationBarView: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                
                Text("Select Language")
                    .font(.system(size: 19, weight: .medium ))
                
                Spacer()
            }
            .padding()
            .background(.appPurple4)
            .overlay(
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "multiply")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                    }
                    
                    Spacer()
                }
                    .padding(.leading)
            )
            .foregroundStyle(.white)
            
            Rectangle()
                .fill(.appPurple3)
                .frame(height: 2)
        }
    }
    
    var languagesCells: some View {
        VStack(spacing: 16) {
            ForEach(selectedLanguageViewModel.languages, id: \.id) { language in
                Button {
                    selectedLanguageViewModel.setUpSelectedLanguage(language)
                    dismiss()
                } label: {
                    LanguageCellView(language: language)
                }
            }
        }
    }
}

extension SelectLanguageScreen {
    struct LanguageCellView: View {

        let language: Language
        
        var body: some View {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.appPurple3)
                
                HStack(spacing: 13) {
                    Image(systemName: "swift")
                    
                    Text("\(language.name)")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .medium))
                }
                .padding()
            }
        }
    }
}

#Preview {
    CoordinatorView()
}
