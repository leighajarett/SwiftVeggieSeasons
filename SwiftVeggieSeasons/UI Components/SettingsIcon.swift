//
//  SettingsIcon.swift
//  SwiftVeggieSeasons
//
//  Created by Leigha Jarett on 7/24/23.
//

import SwiftUI

struct SettingsIcon: View {
    let iconName: String
    let color: Color
        
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 5)
                .fill(color)
                .frame(width: 28, height: 28)
            Image(systemName: iconName)
                .foregroundColor(.white)
        }
    }
}

