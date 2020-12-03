//
//  ContentView.swift
//  ViewsModifiers
//
//  Created by jorgemhtdev on 3/12/20.
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

struct FlagImage: View
{
    var imgName: String

    var body: some View {
        Image(imgName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    
    @State private var tipPercentage = 2
    let tipPercentages = [10, 15, 20, 25, 0]

    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    var body: some View {
        VStack(alignment: .center, spacing:25){
            
            // Create a custom ViewModifier (and accompanying View extension) that makes a view have a large, blue font suitable for prominent titles in a view.

            Text("Hello World").titleStyle()
            
            
            //Go back to project 1 and use a conditional modifier to change the total amount text view to red if the user selects a 0% tip.

            Text("Project 1").titleStyle()
    
            Section(header: Text("How much tip do you want to leave?")) {
                Picker("Tip percentage", selection: $tipPercentage) {
                    ForEach(0 ..< tipPercentages.count) {
                        Text("\(self.tipPercentages[$0])%")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Text("Selected \(tipPercentages[tipPercentage]) % tips").foregroundColor(tipPercentages[tipPercentage] == 0 ? Color.red : Color.black)
            
            // Go back to project 2 and create a FlagImage() view that renders one flag image using the specific set of modifiers we had.
            
            Text("Project 2").titleStyle()

            ForEach(0 ..< 3) { number in
                FlagImage(imgName: self.countries[number].lowercased())
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
