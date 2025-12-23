import SwiftUI

struct MainButtonStyle: ButtonStyle {
    let disabled: Bool
    let foregroundStyle: Color
    let backgroundColor: Color
    
    init(disabled: Bool, foregroundStyle: Color = .white, backgroundColor: Color = .appPurple4) {
        self.disabled = disabled
        self.foregroundStyle = foregroundStyle
        self.backgroundColor = backgroundColor
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(foregroundStyle)
            //.padding(.vertical, 16)
            .font(.system(size: 16, weight: .semibold))
            .frame(maxWidth: .infinity, minHeight: 56)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(backgroundColor)
            )
            .opacity(disabled ? 0.4 : 1)
    }
}
