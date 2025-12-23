import SwiftUI

struct TabContainerView: View {
    @EnvironmentObject private var selectedLanguageViewModel: SelectedLanguageViewModel
    
    var body: some View {
        TabView {
            Tab("Learn", systemImage: "graduationcap.fill") {
                TopicsListScreen()
            }
            
            Tab("Profile", systemImage: "person.crop.circle.fill") {
                Text("3")
            }
        }
    }
}

#Preview {
    CoordinatorView()
}
