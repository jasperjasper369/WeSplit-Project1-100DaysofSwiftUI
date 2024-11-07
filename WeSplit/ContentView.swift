//
//  ContentView.swift
//  WeSplit
//
//  Created by Jasper Tan on 11/5/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 20.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 18
    
    @FocusState private var amountIsFocused: Bool
    
    var totalPerPerson: Double {
        return ((checkAmount * (1 + Double(tipPercentage) / 100)) / Double(numberOfPeople + 2))
    }
    
    var totalBillWithTip: Double {
        return (checkAmount * (1 + Double(tipPercentage) / 100))
    }
    
    let tipPercentages = [0, 15, 18, 20, 25]
    
    var body: some View {
        
        NavigationStack {
            Form {
                Section("Bill Total") {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) { num in
                            Text("\(num) people")
                        }
                    }
                    .pickerStyle(.automatic)
                }
                
                // Segmented tip
//                Section("Tip Percentage") {
//                    Picker("Tip percentage", selection: $tipPercentage) {
//                        ForEach(tipPercentages, id: \.self) { tip in
//                            Text(tip, format: .percent)
//                        }
//                    }
//                    .pickerStyle(.segmented)
//                }
                
                Section("Tip Percentage") {
                    Picker("Tip percent", selection: $tipPercentage) {
                        ForEach(0..<101) { tipPercent in
                            Text("\(tipPercent) percent")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Bill total + tip") {
                    Text(totalBillWithTip, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
