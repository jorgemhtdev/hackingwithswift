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
            .foregroundColor(.white)
            .padding()
    }
}

struct Bnt: ViewModifier {
    func body(content: Content) -> some View {
        content
            .aspectRatio(contentMode: .fit)
            .scaledToFit()
            .frame(width: 100, height: 100)
    }
}

extension View {
    func btnStyle() -> some View {
        self.modifier(Bnt())
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
    @State private var radius = 10
    @State private var randonOptions = Int.random(in: 0...2)
    
    var body: some View {
        VStack() {
            
            HStack(alignment: .center, spacing:25){
                Text("Win \(scoreWin)").titleStyle()
                Text("Lost \(scoreLost)").titleStyle()
            }.frame(minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: 200,
                    alignment: .center)
           
            //Text(playOptions[randonOptions]).blur(radius: CGFloat(radius))
            Image(playOptions[randonOptions]
                    .lowercased())
                    .colorMultiply(showingScore ? .white : .black)
                    .blur(radius: CGFloat(radius))
                    .frame(width: 100, height: 100)
            
            Spacer()
            
            HStack(alignment: .center, spacing:25){
                Button(action: {
                    playOptionsTapped(0)
                }) {
                    Image(playOptions[0].lowercased())
                        .btnStyle()
                    //Text(playOptions[0])
                }

                Button(action: {
                    playOptionsTapped(1)
                }) {
                    Image(playOptions[1].lowercased())
                        .btnStyle()
                    
                    //Text(playOptions[1])
                }
                
                Button(action: {
                    playOptionsTapped(2)
                }) {
                    Image(playOptions[2].lowercased())
                        .btnStyle()

                    //Text(playOptions[2])
                }
            }.alert(isPresented: $showingScore) {
                Alert(title: Text("Do you want to continue?"), message: Text("You can still win"), primaryButton: .default(Text("Continue")) {
                    self.continuePlaying()
                }, secondaryButton: .cancel(Text("Stop Playing"), action: {
                    self.cancelPlaying()
                }))
            }
            
            Spacer()
           
        }.frame(minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center)
        .background(LinearGradient(gradient: Gradient(colors: [Color("yellowColor"), Color("turquoiseColor")]), startPoint: .top, endPoint: .bottom))
        .ignoresSafeArea()
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
        radius = 10;
    }
    
    func cancelPlaying() {
        scoreWin = 0
        scoreLost = 0
        radius = 10;
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
