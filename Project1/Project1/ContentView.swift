//
//  ContentView.swift
//  Project1
//
//  Created by HTLILI on 06/06/2024.
//

import SwiftUI

struct ContentView: View {
    @State var checkAmount = 0.0
    @State var numberOfPeople = 2
    @State var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    let tipPercentages = [10, 15, 20, 25, 0]
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount * tipSelection / 100
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number Of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .navigationTitle("SplitNote")
                    .toolbar {
                        if amountIsFocused {
                            Button("Done") {
                                amountIsFocused = false
                            }
                        }
                    }
                    //Other Style
//                    .pickerStyle(.navigationLink)
                }
                
                Section("How much do you want to tip ?") {
                    Picker("Tip PerCentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
