//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Leyla Mammadova on 7/25/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var endOfGame = false
    @State private var scoreTitle = ""
    @State private var alertMessage = ""
    @State private var score = 0
    @State private var rounds = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the Flag")
                        .font(.largeTitle.weight(.bold))
                        .foregroundColor(.white)
                VStack (spacing: 15){
                    VStack {
                            Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                            Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("\(alertMessage)Your score is \(score)")
        }
        .alert("End of Game", isPresented: $endOfGame){
            Button("Restart", action: reset)
        } message: {
            Text("Correct answers: \(score). Wrong answers \(8 - score).")
        }

    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            alertMessage = ""
            score = score + 1
        } else {
            scoreTitle = "Wrong"
            alertMessage = "You chose the flag of \(countries[number]). "
        }
        rounds = rounds + 1
        
        if rounds == 8 {
            endOfGame = true
        }else{
            showingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset(){
        rounds = 0
        score = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
