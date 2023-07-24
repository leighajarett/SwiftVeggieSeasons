//
//  QuestionsView.swift
//  SwiftVeggieSeasons
//
//  Created by Leigha Jarett on 7/24/23.
//

import SwiftUI

struct QuestionView: View {
    let triviaQuestions: [Trivia]
    let namespace: Namespace.ID
    @State private var questionNumber: Int = 0
    @State private var isAnswered: Bool = false
    @State private var selectedAnswer: Int? = nil

    var body: some View{
        let trivia = triviaQuestions[questionNumber]
        VStack{
            Text(trivia.question)
                .font(.title3)
                .padding()
                .frame(maxWidth: .infinity, alignment: .topLeading)

            ForEach(0..<trivia.answers.count, id: \.self) { index in
                Button(
                    action: {
                        selectedAnswer = index
                        isAnswered = true
                    }) {
                        Text(trivia.answers[index])
                            .font(.headline)
                            .frame(maxWidth:.infinity)
                            .bold()
                    }
                    .disabled(isAnswered)
                    .buttonStyle(.borderedProminent)
                    .padding(.horizontal)
            }
            if isAnswered {
                Text(selectedAnswer == trivia.correctAnswerIndex
                     ? "Correct!" : "Incorrect!")
                .foregroundColor(selectedAnswer == trivia.correctAnswerIndex
                                 ? .green : .red)
                .padding(.top)
            }

            if(questionNumber + 1 < triviaQuestions.count){
                Button("Next Question"){
                    questionNumber = questionNumber + 1
                    isAnswered = false
                }.disabled(!isAnswered).padding()
            }
        }.frame(maxHeight: .infinity, alignment: .top)
            .transition(.opacity)
    }
}

