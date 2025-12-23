import SwiftUI

struct TestScreen: View {
    @State var shouldPresentSheet = false

    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            
            VStack {
                Button("Present Sheet") {
                    shouldPresentSheet.toggle()
                }
                .foregroundStyle(.black)
                /// Present a sheet once `shouldPresentSheet` becomes `true`.
                .sheet(isPresented: $shouldPresentSheet) {
                    print("Sheet dismissed!")
                } content: {
                    addArticleView
                }
                
            }
            .padding()
        }
    }
    
    var addArticleView: some View {
        VStack {
            Text("Hello world")
        }
    }
}

#Preview {
    TestScreen()
}
