import SwiftUI

struct AppTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.grayPurple3F4273)
            )
            .foregroundStyle(.white)

    }
}
