import SwiftUI

struct ProgressRectangleView: View {
    
    let progressValue: CGFloat
    let cornerRadius: CGFloat
    let height: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(.appPurple4)
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(.appPurple0)
                .frame(width: geometry.size.width * progressValue)
        }
        .frame(height: height)
    }
}

#Preview {
    ZStack {
        Color.appPurple5.ignoresSafeArea()
        
        ProgressRectangleView(progressValue: 0.3, cornerRadius: 10, height: 13)
    }
}
