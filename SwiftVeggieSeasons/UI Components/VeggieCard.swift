//
//  VeggieCard.swift
//  SwiftVeggieSeasons
//
//  Created by Leigha Jarett on 5/22/23.
//

import SwiftUI

struct VeggieCard: View {
    let veggie: Veggie
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(veggie.imageAssetPath)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 300)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, veggie.accentColor]),
                        startPoint: UnitPoint(x: 0.5, y: 0.2),
                        endPoint: .bottom
                    ))
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(veggie.name)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                Text(veggie.shortDescription)
                    .font(.body)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
            }.padding()
        }
    }
}

