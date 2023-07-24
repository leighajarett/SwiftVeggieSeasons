//
//  TimePickerView.swift
//  SwiftVeggieSeasons
//
//  Created by Leigha Jarett on 7/24/23.
//

import SwiftUI

struct TimePickerView: View {
    let title: String
    let range: ClosedRange<Int>
    let binding: Binding<Int>

    var body: some View {
        HStack(spacing: -4.0) {
            Picker(title, selection: binding) {
                ForEach(range, id: \.self) { timeIncrement in
                    HStack {
                        Spacer()
                        Text("\(timeIncrement)")
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            .pickerStyle(InlinePickerStyle())
            .labelsHidden()

            Text(title)
                .fontWeight(.bold)
        }
    }
}

