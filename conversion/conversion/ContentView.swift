//
//  ContentView.swift
//  conversion
//
//  Created by jorgemhtdev on 30/11/20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedFromTemperature = 0
    @State private var selectedToTemperature = 0
    @State private var numberConvert = "0"

    var calculateTemperature: String {
        let value: Double = Double(numberConvert) ?? 0.0
        let result = convertTemp(temp: value, from: temperatureConversionUnit[selectedFromTemperature], to: temperatureConversionUnit[selectedToTemperature])
        return result
    }
    
    let mf = MeasurementFormatter()

    func convertTemp(temp: Double, from inputTempType: UnitTemperature, to outputTempType: UnitTemperature) -> String {
          mf.numberFormatter.maximumFractionDigits = 2
          mf.unitOptions = .providedUnit
          let input = Measurement(value: temp, unit: inputTempType)
          let output = input.converted(to: outputTempType)
        return mf.string(from: output)
    }
    
    let temperatureConversion = ["Celsius", "Fahrenheit", "Kelvin"]
    let temperatureConversionUnit = [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin]
    
    let lengthConversion = ["meters", "kilometers", "feet", "yards", "miles"]
    let timeConversion = ["seconds", "minutes", "hours", "days"]
    let volumeConversion = ["milliliters", "liters", "cups", "pints", "gallons"]

    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Convert")) {
                    Picker("Convert", selection: $selectedFromTemperature) {
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
                    
                    Text("Convert \(temperatureConversion[selectedFromTemperature]) to \(temperatureConversion[selectedToTemperature]) is \(calculateTemperature)")

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
