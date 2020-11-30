//
//  ContentView.swift
//  conversion
//
//  Created by jorgemhtdev on 30/11/20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedConverTemperature = 0
    @State private var selectedToTemperature = 0
    @State private var numberConvert = ""

    var calculateTemperature: Double {

        return 10;
    }
    
    let temperatureConversion = ["Celsius", "Fahrenheit", "Kelvin"]
    let lengthConversion = ["meters", "kilometers", "feet", "yards", "miles"]
    let timeConversion = ["seconds", "minutes", "hours", "days"]
    let volumeConversion = ["milliliters", "liters", "cups", "pints", "gallons"]

    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Convert")) {
                    Picker("Convert", selection: $selectedConverTemperature) {
                        ForEach(0 ..< temperatureConversion.count) {
                            Text("\(self.temperatureConversion[$0])")
                        }
                    }
                    
                    Picker("To", selection: $selectedToTemperature) {
                        ForEach(0 ..< temperatureConversion.count) {
                            Text("\(self.temperatureConversion[$0])")
                        }
                    }
                    
                    TextField("Unit", text: $numberConvert)
                        .keyboardType(.numberPad)
                    
                    Text("Convert \(temperatureConversion[selectedConverTemperature]) to \(temperatureConversion[selectedToTemperature]) is \(calculateTemperature,  specifier: "%.2f")")

                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
            ContentView()
        }
    }
}
