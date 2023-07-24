//
//  styles.swift
//  SwiftVeggieSeasons
//
//  Created by Leigha Jarett on 7/24/23.
//

import SwiftUI

struct ScaledButtonStyle: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
