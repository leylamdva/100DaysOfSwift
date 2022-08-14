//
//  ContentView.swift
//  BrainGame
//
//  Created by Leyla Mammadova on 8/13/22.
//

import SwiftUI

struct ContentView: View {
    let options = ["Rock", "Paper", "Scissors"]
    let winningOptions = ["Paper", "Scissors", "Rock"]
    
    @State private var appTurn = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var rounds = 1
    @State private var endOfGame = false
    @State private var score = 0
    @State private var resultTitle = ""
    @State private var showResult = false
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: .yellow, location: 0.5),
                .init(color: .cyan, location: 0.5),
            ], center: .center, startRadius: 100, endRadius: 300)
                            .ignoresSafeArea()
            VStack{
                Text("Round \(rounds) :")
                    .font(.largeTitle)
                    .foregroundColor(.primary)
                Spacer()
                VStack (spacing: 15){
                    Text("\(options[appTurn])")
                        .font(.subheadline.weight(.heavy))
                    Text("You have to \(shouldWin ? "win" : "lose")")
                    ForEach(options, id: \.self){ option in
                        Button{
                            optionSelected(option)
                        } label: {
                            Text(option)
                        }
                    }
                }
                Spacer()
                Text("Score: \(score)")
            }
            .padding()
        }
        .alert(resultTitle, isPresented: $showResult){
            Button("Continue", action: newRound)
        }message: {
            Text("Your score is \(score)")
        }
        .alert("End of Game", isPresented: $endOfGame){
            Button("Restart", action: reset)
        }message: {
            Text("Your final score: \(score)")
        }
        
    }
    
    func optionSelected(_ option: String){
        if shouldWin && option == winningOptions[appTurn]{
            resultTitle = "Correct"
            score = score + 1
        }else if !shouldWin{
            let i = winningOptions.firstIndex(where: { $0 == options[appTurn] })
            if options[i!] == option{
                resultTitle = "Correct"
                score = score + 1
            }else{
                resultTitle = "Wrong"
                score = score - 1
            }
        }else{
            resultTitle = "Wrong"
            score = score - 1
        }
        rounds = rounds + 1
        if rounds == 10{
            endOfGame = true
        }else{
            showResult = true
        }
    }
    
    func newRound(){
        appTurn = Int.random(in: 0...2)
        shouldWin.toggle()
    }
    
    func reset(){
        rounds = 0
        score = 0
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
