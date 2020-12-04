//
//  ContentView.swift
//  challengeplay
//
//  Created by jorgemhtdev on 4/12/20.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
            .padding()
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

struct ContentView: View {
    
    @State private var playOptions = ["Rock", "Paper", "Scissors"].shuffled()
    @State private var win = false
    @State private var lose = false
    @State private var showingScore = false
    @State private var scoreWin = 0
    @State private var scoreLost = 0
    @State private var radius = 3
    @State private var randonOptions = Int.random(in: 0...2)
    
    var body: some View {
        VStack(alignment: .center, spacing:25){
            
            HStack(alignment: .center, spacing:25){
                Text("Win \(scoreWin)").titleStyle()
                Text("Lost \(scoreLost)").titleStyle()
            }
            
            Text(playOptions[randonOptions]).blur(radius: CGFloat(radius))
            Spacer()
            HStack(alignment: .center, spacing:25){
                Button(action: {
                    playOptionsTapped(0)
                }) {
                    Text(playOptions[0])
                }

                Button(action: {
                    playOptionsTapped(1)
                }) {
                    Text(playOptions[1])
                }
                
                Button(action: {
                    playOptionsTapped(2)
                }) {
                    Text(playOptions[2])
                }
            }.alert(isPresented: $showingScore) {
                Alert(title: Text("Do you want to continue?"), message: Text("You can still win"), primaryButton: .default(Text("Continue")) {
                    self.continuePlaying()
                }, secondaryButton: .cancel(Text("Stop Playing"), action: {
                    self.cancelPlaying()
                }))
            }
        }
    }
    
    func playOptionsTapped(_ number: Int) {
        
        if number == randonOptions {
            scoreWin -= 1
            scoreLost -= 1
        }else if randonOptions == 0 && number == 1 ||
                    randonOptions == 1 && number == 2 ||
                    randonOptions == 2 && number == 0{
            scoreWin += 1
        }else{
            scoreLost += 1
        }
        
        showingScore = true
        radius = 0
    }
        
    func continuePlaying() {
        randonOptions = Int.random(in: 0...2)
        radius = 3;
    }
    
    func cancelPlaying() {
        scoreWin = 0
        scoreLost = 0
        radius = 3;
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
