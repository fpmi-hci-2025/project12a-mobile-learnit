import SwiftUI

struct SignUpScreen: View {
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    @State private var confirmPassword = ""
    @State private var selectedCountry = "United States"
    @State private var agreeToTerms = false
    
    private var isContinueButtonDisabled: Bool {
        email.isEmpty ||
        password.isEmpty ||
        username.isEmpty ||
        confirmPassword.isEmpty ||
        !agreeToTerms ||
        password != confirmPassword
    }
    
    private let textFieldHeight: CGFloat = 45
    
    let countries = ["United States", "United Kingdom", "Canada", "Australia", "Germany", "France", "Japan"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                
                Spacer().frame(height: 40)
                
                // Header with Logo
                headerSection
                
                // Form Fields
                formSection
                
                // Terms and Conditions
                termsSection
                
                // Action Buttons
                actionButtonsSection
                
                // Social Login
                socialLoginSection
                
                // Already have account
                loginPromptSection
                
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [.darkPurple252746, .appPurple4.opacity(0.8)]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .scrollIndicators(.hidden)
    }
}

// MARK: - Subviews
private extension SignUpScreen {
    
    var headerSection: some View {
        VStack(spacing: 16) {
            // Logo/Icon
            Image(systemName: "graduationcap.fill")
                .font(.system(size: 60))
                .foregroundColor(.white)
                .padding()
                .background(
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [.appPurple4, .appPurple4.opacity(0.7)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 100, height: 100)
                        .shadow(color: .appPurple4.opacity(0.5), radius: 20)
                )
            
            // Title
            Text("Start Your Coding Journey")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            // Subtitle
            Text("Learn to code. Build a portfolio. Get hired.")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
    
    var formSection: some View {
        VStack(spacing: 20) {
            // Username Field
            HStack(spacing: 12) {
                Image(systemName: "person.fill")
                    .foregroundColor(.appPurple4)
                    .frame(width: 20)
                
                TextField("Username", text: $username)
                    .foregroundColor(.white)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.black.opacity(0.3))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.appPurple4.opacity(0.3), lineWidth: 1)
                    )
            )
            
            // Email Field
            HStack(spacing: 12) {
                Image(systemName: "envelope.fill")
                    .foregroundColor(.appPurple4)
                    .frame(width: 20)
                
                TextField("Email address", text: $email)
                    .foregroundColor(.white)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.black.opacity(0.3))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.appPurple4.opacity(0.3), lineWidth: 1)
                    )
            )
            
            // Password Field
            HStack(spacing: 12) {
                Image(systemName: "lock.fill")
                    .foregroundColor(.appPurple4)
                    .frame(width: 20)
                
                SecureField("Password", text: $password)
                    .foregroundColor(.white)
                
                if !password.isEmpty {
                    Button(action: { password = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.black.opacity(0.3))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.appPurple4.opacity(0.3), lineWidth: 1)
                    )
            )
            
            // Confirm Password Field
            HStack(spacing: 12) {
                Image(systemName: "lock.rotation")
                    .foregroundColor(.appPurple4)
                    .frame(width: 20)
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .foregroundColor(.white)
                
                if !confirmPassword.isEmpty {
                    Image(systemName: password == confirmPassword ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundColor(password == confirmPassword ? .green : .red)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.black.opacity(0.3))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                password == confirmPassword ?
                                Color.green.opacity(0.3) : Color.appPurple4.opacity(0.3),
                                lineWidth: 1
                            )
                    )
            )
            
            // Country Picker
            HStack(spacing: 12) {
                Image(systemName: "globe")
                    .foregroundColor(.appPurple4)
                    .frame(width: 20)
                
                Menu {
                    ForEach(countries, id: \.self) { country in
                        Button(country) {
                            selectedCountry = country
                        }
                    }
                } label: {
                    HStack {
                        Text(selectedCountry)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.down")
                            .foregroundColor(.appPurple4)
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.black.opacity(0.3))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.appPurple4.opacity(0.3), lineWidth: 1)
                    )
            )
        }
    }
    
    var termsSection: some View {
        HStack(spacing: 12) {
            Button(action: { agreeToTerms.toggle() }) {
                Image(systemName: agreeToTerms ? "checkmark.square.fill" : "square")
                    .foregroundColor(agreeToTerms ? .appPurple4 : .gray)
                    .font(.system(size: 20))
            }
            
            Text("I agree to the Terms & Conditions and Privacy Policy")
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
    }
    
    var actionButtonsSection: some View {
        VStack(spacing: 16) {
            Button(action: handleSignUp) {
                HStack {
                    Text("Create Account")
                        .font(.system(size: 18, weight: .semibold))
                    
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(
                            LinearGradient(
                                colors: [.appPurple4, .appPurple4.opacity(0.8)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                )
            }
            .disabled(isContinueButtonDisabled)
            
            Button(action: handleLogIn) {
                Text("Already have an account? Log In")
                    .font(.system(size: 16))
                    .foregroundColor(.appPurple4)
                    .underline()
            }
        }
    }
    
    var socialLoginSection: some View {
        VStack(spacing: 20) {
            HStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 1)
                
                Text("Or continue with")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 1)
            }
            
            HStack(spacing: 20) {
                socialButton(icon: "apple.logo", text: "Apple")
                socialButton(icon: "g.circle.fill", text: "Google")
                socialButton(icon: "f.circle.fill", text: "Facebook")
            }
        }
    }
    
    var loginPromptSection: some View {
        HStack {
            Text("By signing up, you agree to our")
                .font(.system(size: 14))
                .foregroundColor(.gray)
            
            Button("Terms") {
                // Show terms
            }
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(.appPurple4)
            
            Text("and")
                .font(.system(size: 14))
                .foregroundColor(.gray)
            
            Button("Privacy Policy") {
                // Show privacy policy
            }
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(.appPurple4)
        }
        .multilineTextAlignment(.center)
    }
    
    func socialButton(icon: String, text: String) -> some View {
        Button(action: {}) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                
                Text(text)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
            .frame(width: 80, height: 80)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.black.opacity(0.3))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
            )
        }
    }
}

// MARK: - Actions
private extension SignUpScreen {
    func handleLogIn() {
        print("Log In tapped")
        // Handle login logic
    }
    
    func handleSignUp() {
        print("Sign Up tapped with:")
        print("Username: \(username)")
        print("Email: \(email)")
        print("Country: \(selectedCountry)")
        // Handle sign up logic
    }
}

// MARK: - Preview
#Preview {
    SignUpScreen()
}
