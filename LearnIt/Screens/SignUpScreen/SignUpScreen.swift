import SwiftUI

struct SignUpScreen: View {
    @State private var email = ""
    @State private var password = ""
    
    private var isContinueButtonDisabled: Bool {
        email.isEmpty || password.isEmpty
    }
    
    private let textFieldHeight: CGFloat = 25
    
    var body: some View {
        VStack(spacing: 24) {
            
            Spacer()
            
            titleLabel
            
            VStack(spacing: 15) {
                emailTextField
                    .frame(height: textFieldHeight)
                    .modifier(AppTextFieldModifier())
                
                AppSecureField(
                    "Password",
                    text: $password,
                    foregroundColor: .gray
                )
                    .frame(height: textFieldHeight)
                    .modifier(AppTextFieldModifier())
            }
            
            Spacer()
            
            HStack(spacing: 16) {
                MainButton(
                    text: "Log In".uppercased(),
                    disabled: isContinueButtonDisabled,
                    action: handleLogIn
                )
                
                MainButton(
                    text: "Sign In".uppercased(),
                    disabled: isContinueButtonDisabled,
                    foregroundStyle: .appPurple4,
                    backgroundColor: .white,
                    action: handleSignUp
                )
            }
        }
        .padding()
        .background(.darkPurple252746)
    }
}

private extension SignUpScreen {
    var titleLabel: some View {
        Text("Learn to code. Build a portfolio. Get hired.")
            .foregroundStyle(.white)
            .font(.system(size: 50, weight: .bold))
            .minimumScaleFactor(0.5)
            .lineLimit(3)
            .padding(.bottom, 10)
            .padding(.horizontal)
    }
    
    var emailTextField: some View {
        TextField(
            "Your e-mail",
            text: $email,
            prompt: Text("Your e-mail").foregroundColor(.gray)
        )
    }
    
    func handleLogIn() {
        
    }
    
    func handleSignUp() {
        
    }
}

#Preview {
    CoordinatorView()
}
