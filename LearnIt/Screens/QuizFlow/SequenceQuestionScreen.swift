//
//  SingleChoiceQuestionScreen.swift
//  LearnIt
//
//  Created by Egor on 12.12.25.
//

import WebKit
import SwiftUI

struct SequenceQuestionScreen: View {
    @EnvironmentObject private var selectedLanguageViewModel: SelectedLanguageViewModel
    
    @State private var shakeWrongAnswer: Bool = false
    @Binding private var wrongAnswersCount: Int
    @State private var userSelectedAnswerSequence: [Answer] = []
    
    @State private var gridLayout: [GridItem] = []
    @State private var availableWidth: CGFloat = 0
    @State private var showWrongAnswer = false
    @State private var showCorrectAnswer = false
    
    private let question: Question
    private let answerSequenceToChoose: [SelectableAnswer]
    private var buttonContinueAction: ()->()
    private let isLastQuestion: Bool
    
    private var answerSequenece: [Answer] {
        question.answerSequence ?? []
    }
    
    private var buttonCheckAnswerDisabled: Bool {
        userSelectedAnswerSequence.count != answerSequenece.count
    }

    init(
        question: Question,
        isLastQuestion: Bool,
        wroundAnswersCount: Binding<Int>,
        buttonContinueAction: @escaping ()->()
    ) {
        self.question = question
        
        self.answerSequenceToChoose = (question.answerSequence ?? []).shuffled().map { SelectableAnswer(answer: $0, isSelected: false) }
        
        self.buttonContinueAction = buttonContinueAction
        self.isLastQuestion = isLastQuestion
        self._wrongAnswersCount = wroundAnswersCount
    }
    
    var body: some View {
        ZStack {
            Color.appPurple5.ignoresSafeArea()
            
            VStack {
                Text(question.text)
                    .font(.system(size: 24, weight: .regular))
                    .padding(.vertical, 10)
                
                codePageView
                
                Spacer()
                
                bottomView
            }
            .foregroundStyle(.white)
        }
    }
}

private extension SequenceQuestionScreen {
    func checkUserAnswer() {
        if isCorrectSequenece() {
            showCorrectAnswer = true
        } else {
            showWrongAnswer = true
        }
    }
    
    func isCorrectSequenece() -> Bool {
        for pair in zip(userSelectedAnswerSequence, answerSequenece) {
            if pair.0.id != pair.1.id {
                return false
            }
        }
        
        return true
    }
    
    var codePageView: some View {
        VStack(spacing: 0) {
            languageNameView
            codeView
            
            if showWrongAnswer || showCorrectAnswer {
                Rectangle()
                    .fill(showWrongAnswer ? .red : .green)
                    .frame(height: 2)
            }
        }
    }
    
    var languageNameView: some View {
        HStack {
            VStack {
                Text(selectedLanguageViewModel.selectedLanguage?.name ?? "nil")
                    .font(.system(size: 16, weight: .semibold))
                
                Rectangle()
                    .fill(.white)
                    .frame(height: 3)
            }
            .frame(width: 90)
            
            Spacer()
            
            if showWrongAnswer {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.red)
                    .font(.title2)
                    .frame(width: 30, height: 30)
            }
            
            if showCorrectAnswer {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.green)
                    .font(.title2)
                    .frame(width: 25, height: 25)
            }
        }
        .animation(.easeOut(duration: 0.3), value: showCorrectAnswer)
        .padding([.horizontal, .top])
        .background(.appPurple4)
    }
    
    var codeView: some View {
        HStack {
            ForEach(userSelectedAnswerSequence, id: \.id) { answer in
                Text(answer.text)
            }
            
            Spacer()
        }
        .frame(height: 20)
        .padding()
        .background(.appPurple6)
    }
    
    var bottomView: some View {
        VStack {
            HStack {
                Button {
                    userSelectedAnswerSequence = []
                } label: {
                    Image(systemName: "arrow.trianglehead.counterclockwise.rotate.90")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                }
                
                Spacer()
                
                Button {
                    checkUserAnswer()
                } label: {
                    Image(systemName: "checkmark")
                        .resizable()
                        .scaledToFit()
                    
                }
                .frame(width: 21, height: 21)
                .padding(13)
                .disabled(buttonCheckAnswerDisabled)
                .background(
                    RoundedRectangle(cornerRadius: 13)
                        .fill(.appPurple1)
                )
                .opacity(buttonCheckAnswerDisabled ? 0.6 : 1)
            }
            
            HStack {
                Spacer()
                
                VStack(spacing: 10) {
                    ForEach(answerSequenceToChoose, id: \.id) { selectableAnswer in
                        AnswerPartCode(selectableAnswer: selectableAnswer) {
                            userSelectedAnswerSequence.append(selectableAnswer.answer)
                        }
                    }
                }
                
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .background(.appPurple4)
    }
}

struct AnswerPartCode: View {
    private let selectableAnswer: SelectableAnswer
    var buttonAction: ()->()
    
    @State private var isSelected: Bool = false
    
    private let cornerRadius: CGFloat = 6
    private let height: CGFloat = 18
    
    private var answer: Answer {
        selectableAnswer.answer
    }
    
    init(selectableAnswer: SelectableAnswer, buttonAction: @escaping () -> Void) {
        self.selectableAnswer = selectableAnswer
        self.buttonAction = buttonAction
    }
    
    var body: some View {
        bottomView
            .overlay(topView)
    }
    
    var bottomView: some View {
        Button {
            if !isSelected {
                isSelected = true
                buttonAction()
            }
        } label: {
            Text("\(answer.text)  ")
                .font(.system(size: 23, weight: .medium))
                .foregroundStyle(.white)
                .padding(4)
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(.appPurple3)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(.appPurple3)
                        .opacity(isSelected ? 1 : 0)
                )
        }
    }
    
    var topView: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(.appPurple3)
            .opacity(isSelected ? 1 : 0)
    }
}

struct SelectableAnswer: Identifiable {
    var id: UUID {
        answer.id
    }
    
    let answer: Answer
    var isSelected: Bool
}

#Preview {
    CoordinatorView()
}
