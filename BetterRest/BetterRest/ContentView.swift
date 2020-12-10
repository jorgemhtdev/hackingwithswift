//
//  ContentView.swift
//  BetterRest
//
//  Created by jorgemhtdev on 10/12/20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertTitle = "Error"
    @State private var alertMessage = "Sorry, there was a problem calculating your bedtime."
    @State private var showingAlert = false
    
    var body: some View {
        
        NavigationView {
            Form {
                Text("When do you want to wake up?")
                    .font(.headline)

                DatePicker("Please enter a time", selection: Binding(get: {
                        self.wakeUp
                    }, set: { newVal in
                        self.wakeUp = newVal
                        self.calculateBedtime()
                    }), displayedComponents: .hourAndMinute)
                .labelsHidden()
                .datePickerStyle(WheelDatePickerStyle())
            
                Section(header: Text("Desired amount of sleep")
                            .font(.headline))
                {
//                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
//                        Text("\(sleepAmount, specifier: "%g") hours")
//                    }
                    
                    Stepper("\(sleepAmount, specifier: "%g") hours", onIncrement: {
                        if(sleepAmount < 12){
                            self.calculateBedtime()
                            self.sleepAmount += 0.25
                        }
                    }, onDecrement: {
                        if(sleepAmount > 4){
                            self.calculateBedtime()
                            self.sleepAmount -= 0.25
                        }
                    })
                }
                
                Text("Daily coffee intake")
                    .font(.headline)

                // NEED IMPROVE THE FOREACH
                Picker(selection: $coffeeAmount, label: Text("Strength")) {
                    ForEach(0 ..< 20) {
                        if $0 != 0{
                            if $0 == 1 {
                                Text("\($0) cup")
                            } else {
                                Text("\($0) cups")
                            }
                        }
                    }
                }
                
                Section(header: Text("Your ideal bedtime is…")
                            .font(.headline))
                {
                    Text(alertMessage)
                }.onAppear { self.calculateBedtime() }
                
            }.navigationTitle("BetterRest").alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
//             .navigationBarItems(trailing:
//                 Button(action: calculateBedtime) {
//                    Text("Calculate")
//                }
//            ).alert(isPresented: $showingAlert) {
//                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
//            }
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    func calculateBedtime() {
        
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            alertMessage = formatter.string(from: sleepTime)
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
            showingAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
