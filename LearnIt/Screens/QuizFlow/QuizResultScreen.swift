import SwiftUI

struct QuizResultScreen: View {
    @EnvironmentObject private var selectedLanguageViewModel: SelectedLanguageViewModel
    @Environment(\.dismiss) var dismiss
    
    @Binding private var wrongAnswersCount: Int
    private let imageSize: CGFloat = 140
    
    init(wrongAnswersCount: Binding<Int>) {
        self._wrongAnswersCount = wrongAnswersCount
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("appIcon")
                .resizable()
                .frame(width: imageSize, height: imageSize)
            
            Text("Topic complete!")
                .font(.system(size: 30, weight: .bold))
            
            Spacer()
            
            HStack {
                Text("Wrong answers - ")
                
                Text("\(wrongAnswersCount)")
                    .foregroundStyle(.red)
                
                Spacer()
            }
            .font(.system(size: 24, weight: .medium))
            .padding(.bottom, 20)
            
            VStack(alignment: .leading, spacing: 10) {
                
                ProgressRectangleView(
                    progressValue: selectedLanguageViewModel.progressTopicsPercentCGFloat,
                    cornerRadius: 10,
                    height: 13
                )
                
                HStack {
                    Text("Language progerss")
                    
                    Spacer()
                    
                    Text("\(selectedLanguageViewModel.progressTopicsPercent)%")
                }
                .font(.system(size: 18, weight: .medium))
            }
            
            MainButton(text: "Continue", disabled: false, backgroundColor: .appPurple1) {
                dismiss()
            }
            .padding(.top, 20)
        }
        .padding(.horizontal)
        .foregroundStyle(.white)
        .background(
            Color.appPurple5
        )
    }
}

#Preview {
    CoordinatorView()
}
