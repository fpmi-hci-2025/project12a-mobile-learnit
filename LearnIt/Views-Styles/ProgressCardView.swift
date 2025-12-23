import SwiftUI

struct ProgressCardView: View {
    let title: String
    let progressPercent: Int
    let foregroundStyle: Color
    let backgroundColor: Color
    
    init(
        title: String,
        progressPercent: Int,
        foregroundStyle: Color = .white,
        backgroundColor: Color = .appPurple4
    ) {
        self.title = title
        self.progressPercent = progressPercent
        self.foregroundStyle = foregroundStyle
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .fill(backgroundColor)
                .frame(height: 20)
            
            HStack(spacing: 25) {
                Text(title)
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundStyle(foregroundStyle)
                
                AppProgressView(progressPercent: progressPercent)
            }
            .padding(.vertical)
            .padding(.horizontal, 20)
            .padding(.leading, 16)
            .background(
                RoundedRectangle(cornerRadius: 60)
                    .fill(backgroundColor)
            )
            .padding(.horizontal)
        }
    }
}

private extension ProgressCardView {
    static let example = ProgressCardView(
            title: "Intro to Web Development",
            progressPercent: 25
        )
}

#Preview {
//    ZStack {
//        Color.black.ignoresSafeArea()
//        
//        ProgressCardView.example
//    }
    
    CoordinatorView()
}
