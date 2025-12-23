import SwiftUI

struct AppSecureField: View {
    
    @Binding private var text: String
    @State private var isSecured: Bool = true
    private let title: String
    private let foregroundColor: Color
    
    init(
        _ title: String,
        text: Binding<String>,
        foregroundColor: Color
    ) {
        self.foregroundColor = foregroundColor
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField(
                        title,
                        text: $text,
                        prompt: Text(title).foregroundColor(foregroundColor)
                    )
                } else {
                    TextField(
                        title,
                        text: $text,
                        prompt: Text(title).foregroundColor(foregroundColor)
                        
                    )
                }
            }
            .padding(.trailing, 32)
            .frame(height: 25)

            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(.gray)
            }
        }
    }
}
