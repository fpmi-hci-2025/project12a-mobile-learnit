import SwiftUI

struct QuizScreen: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var currentQuestionIndex: Int = 0
    @State private var isTransitioning: Bool = false
    @State private var wrongAnswersCount = 0
    @State private var showQuizResultsScreen = false
    
    let topic: Topic
    
    private var progressValue: CGFloat {
        CGFloat(currentQuestionIndex + 1) / CGFloat(topic.questions.count)
    }
    
    private var currentQuestion: Question {
        topic.questions[currentQuestionIndex]
    }
    
    private var isLastQuestion: Bool {
        currentQuestionIndex == topic.questions.count - 1
    }
    
    var body: some View {
        ZStack {
            Color.appPurple5.ignoresSafeArea()
            
            VStack {
                navigationBarView
                
                Group {
                    switch currentQuestion.type {
                        case .singleChoice:
                            SingleChoiceQuestionScreen(
                                question: currentQuestion, isLastQuestion: isLastQuestion,
                                wroundAnswersCount: $wrongAnswersCount,
                                buttonContinueAction: buttonContinueAction
                            )
                            .padding(.horizontal, 13)
                            
                        case .sequence:
                            SequenceQuestionScreen(
                                question: currentQuestion,
                                isLastQuestion: isLastQuestion,
                                wroundAnswersCount: $wrongAnswersCount,
                                buttonContinueAction: buttonContinueAction
                            )
                            
                        default:
                            Text("Not Implemented question type screen")
                    }
                }
                .padding(.top, 10)
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing),
                    removal: .move(edge: .leading)
                ))
                .id(currentQuestionIndex) // Важно: меняем id для анимации
            }
        }
        .animation(.easeInOut(duration: 0.3), value: currentQuestionIndex)
        .fullScreenCover(isPresented: $showQuizResultsScreen) {
            dismiss()
        } content: {
            QuizResultScreen(wrongAnswersCount: $wrongAnswersCount)
        }
    }
}

private extension QuizScreen {
    
    func buttonContinueAction() {
        guard !isLastQuestion else {
            showQuizResultsScreen = true
            return
        }
        
        withAnimation(.easeInOut(duration: 0.3)) {
            currentQuestionIndex += 1
        }
    }
    
    var navigationBarView: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                
                Text(topic.name)
                    .font(.system(size: 19, weight: .medium ))
                
                Spacer()
            }
            .padding()
            .overlay(
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "multiply")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                    }
                    
                    Spacer()
                }
                    .padding(.leading)
            )
            .foregroundStyle(.white)
            
            ProgressRectangleView(
                progressValue: progressValue,
                cornerRadius: 0,
                height: 8
            )
            
            Rectangle()
                .fill(.appPurple3)
                .frame(height: 2)
        }
        .background(.appPurple4)
    }
}

#Preview {
    CoordinatorView()
}
