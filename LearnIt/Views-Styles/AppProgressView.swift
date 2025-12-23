import SwiftUI

struct AppProgressView: View {
    let progressPercent: Int
    let foregroungStyle: Color
    let borderBackgroundStyle: Color
    let borderForegroundStyle: Color
    let lineWidth: CGFloat
    
    init(
        progressPercent: Int,
        foregroungStyle: Color = .white,
        borderBackgroundStyle: Color = .appPurple3,
        borderForegroundStyle: Color = .appPurple1,
        lineWidth: CGFloat = 6
    ) {
        self.progressPercent = progressPercent
        self.foregroungStyle = foregroungStyle
        self.borderBackgroundStyle = borderBackgroundStyle
        self.borderForegroundStyle = borderForegroundStyle
        self.lineWidth = lineWidth
    }
    
    private var progressString: String {
        String(describing: progressPercent)
    }
    
    var body: some View {
        Text("\(progressString)%")
            .foregroundStyle(foregroungStyle)
            .font(.system(size: 18, weight: .semibold))
            .padding(18)
            .overlay(
                Circle()
                    .stroke(borderBackgroundStyle, lineWidth: lineWidth)
            )
            .overlay(
                Circle()
                    .trim(from: 0, to: CGFloat(progressPercent) / 100)
                    .stroke(
                        borderForegroundStyle,
                        style: .init(
                            lineWidth: lineWidth,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.init(degrees: -90))
            )
    }
}

#Preview {
//    ZStack {
//        Color.black.ignoresSafeArea()
//        
//        AppProgressView(
//            progressPercent: 25
//        )
//    }
    
    CoordinatorView()
}
