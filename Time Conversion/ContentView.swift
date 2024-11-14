//
//  ContentView.swift
//  Time Conversion
//
//  Created by Thierno Diallo on 11/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var value: Double = 0.0
    @State private var timeChosen = UnitDuration.seconds
    
    @State private var timeConverted = UnitDuration.seconds
    
    @FocusState private var valueIsFocused: Bool
    
    let units: [UnitDuration] = [UnitDuration.hours, UnitDuration.seconds, UnitDuration.minutes]
    
    /*
     
     
     Able to access many different apis using UnitDuration, UnitLength, UnitMass, UnitTemperature...
     
     
     */
    
    var result: String {
        let inputfromSeconds: Double
        let outfromSeconds: Double
        
        switch timeChosen {
        case "Minutes":
            inputfromSeconds = 60.0
        case "Hours":
            inputfromSeconds = 3600.0
        case "Days":
            inputfromSeconds = 86400.0
        default:
            inputfromSeconds = 1.0 // seconds
        }
        
        switch timeConverted {
        case "Minutes":
            outfromSeconds = 0.0167
        case "Hours":
            outfromSeconds = 0.000277
        case "Days":
            outfromSeconds = 0.00001157
        default:
            outfromSeconds = 1.0 // seconds
        }
        
        let inputinSeconds = value * inputfromSeconds
        let output = inputinSeconds * outfromSeconds
        
        let outputString = output.formatted()
        
        
        return "\(outputString) \(timeConverted.lowercased())"
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Input Value") {
                    TextField("Value", value: $value, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($valueIsFocused)
                }
                
                Section("Time Chosen...") {
                    Picker("Time Conversion", selection: $timeChosen) {
                        ForEach(timeConversions, id: \.self) {
                            Text($0)
                        }
                    }
                }.pickerStyle(.segmented)
                
                Section("Time Converting to...") {
                    Picker("Conversion", selection: $timeConverted) {
                        ForEach(timeConversions, id: \.self) {
                            Text($0)
                        }
                    }
                }.pickerStyle(.segmented)
                
                Section("Result") {
                    Text(result)
                    
                }
            }
            .navigationTitle("Time Conversion App")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if valueIsFocused {
                    Button("Done")  {
                        valueIsFocused = false
                    }
                }
            }
        }
    }
        
}

#Preview {
    ContentView()
}
