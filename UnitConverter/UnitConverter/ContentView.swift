//
//  ContentView.swift
//  UnitConverter
//
//  Created by Leyla Mammadova on 6/17/22.
//

import SwiftUI

struct ContentView: View {
    @State private var inputNumber = 0.0
    @State private var inputUnit = "m"
    @State private var outputUnit = "mi"
    
    let lengthUnits = ["cm", "m", "km", "ft", "mi", "yd", "in"]
    
    var resultValue: Double {
        let conversion = ["cm": UnitLength.centimeters, "m": UnitLength.meters, "km": UnitLength.kilometers, "ft": UnitLength.feet, "mi": UnitLength.miles, "yd": UnitLength.yards, "in": UnitLength.inches]
        
        let input = Measurement(value: inputNumber, unit: conversion[inputUnit]!)
        
        let output = input.converted(to: conversion[outputUnit]!)
        return output.value
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Input unit", selection: $inputUnit){
                        ForEach(lengthUnits, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }header: {
                    Text("Select input unit")
                }
                Section{
                    TextField("Number", value: $inputNumber, format: .number)
                        .keyboardType(.decimalPad)
                }
                Section{
                    Picker("Output unit", selection: $outputUnit){
                        ForEach(lengthUnits, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }header: {
                    Text("Select output unit")
                }
                Section{
                    Text(resultValue, format: .number)
                }header: {
                    Text("Output")
                }
            }
            .navigationTitle("Unit Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
