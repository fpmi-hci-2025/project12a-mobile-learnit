//
//  SingleChoiceQuestionScreen.swift
//  LearnIt
//
//  Created by Egor on 12.12.25.
//

import SwiftUI

struct SingleChoiceQuestionScreen: View {
    @State private var selectedAnswerId: UUID?
    @State private var shakeWrongAnswer: Bool = false
    @Binding private var wrongAnswersCount: Int
    
    private let question: Question
    private let answers: [Answer]
    private var correctAnswerId: UUID?
    private var buttonContinueAction: ()->()
    private let isLastQuestion: Bool

    init(
        question: Question,
        isLastQuestion: Bool,
        wroundAnswersCount: Binding<Int>,
        buttonContinueAction: @escaping ()->()
    ) {
        self.question = question
        self.answers = (question.answers ?? []).shuffled()
        self.buttonContinueAction = buttonContinueAction
        self.isLastQuestion = isLastQuestion
        self._wrongAnswersCount = wroundAnswersCount
        
        for answer in self.answers {
            if let isCorrect = answer.isCorrect, isCorrect {
                correctAnswerId = answer.id
                break
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(question.text)
                .font(.system(size: 24, weight: .regular))
                .padding(.vertical, 10)
            
            VStack(spacing: 16) {
                ForEach(answers, id: \.id) { answer in
                    Button {
                        handleAnswerSelection(answer.id)
                    } label: {
                        AnswerCell(
                            answer: answer,
                            isSelected: answer.id == selectedAnswerId,
                            shouldShake: shakeWrongAnswer && answer.id == selectedAnswerId
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            
            Spacer()
            
            MainButton(
                text: isLastQuestion ? "End quiz" : "Continue",
                disabled: selectedAnswerId != correctAnswerId,
                foregroundStyle: .white,
                backgroundColor: .appPurple1,
                action: buttonContinueAction
            )
        }
        .foregroundStyle(.white)
    }
    
    func handleAnswerSelection(_ answerId: UUID) {
        selectedAnswerId = answerId
        
        if answerId != correctAnswerId {
            wrongAnswersCount += 1
            
            withAnimation(.spring(response: 0.2, dampingFraction: 0.2, blendDuration: 0.2)) {
                shakeWrongAnswer = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                shakeWrongAnswer = false
            }
        }
    }
}

struct AnswerCell: View {
    let answer: Answer
    let isSelected: Bool
    let shouldShake: Bool
    
    var isCorrect: Bool {
        answer.isCorrect ?? false
    }
    
    var body: some View {
        HStack {
            Text(answer.text)
                .font(.system(size: 20, weight: .medium))
                .padding()
            
            Spacer()
            
            if isSelected {
                if answer.isCorrect ?? false {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.title2)
                        .frame(width: 30, height: 30)
                        .padding(.trailing)
                } else if isSelected && !isCorrect {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                        .font(.title2)
                        .frame(width: 30, height: 30)
                        .padding(.trailing)
                }
            }
        }
        .foregroundStyle(.white)
        .background(
            RoundedRectangle(cornerRadius: 13)
                .fill(.appPurple4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 13)
                .stroke(getBorderColor(), lineWidth: 2.5)
                .opacity(isSelected ? 1 : 0)
        )
        .modifier(ShakeEffect(animatableData: shouldShake ? 1 : 0))
        .animation(.easeOut(duration: 0.3), value: isSelected)
    }
    
    func getBorderColor() -> Color {
        if isSelected, isCorrect {
            return .green
        } else if isSelected, !isCorrect {
            return .red
        } else {
            return .clear
        }
    }
    
    func shouldShowBorder() -> Bool {
        return isSelected
    }
}

#Preview {
    CoordinatorView()
}
