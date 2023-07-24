//
//  VeggieCard.swift
//  SwiftVeggieSeasons
//
//  Created by Leigha Jarett on 5/22/23.
//

import SwiftUI

struct VeggieCard: View {
    let veggie: Veggie
    @State var preferredCategories: Set<String> = []
    
    var body: some View {
        NavigationLink(
            destination: VeggieDetailsView(veggie: veggie)
                .frame(maxHeight: .infinity, alignment: .topLeading)
        ){
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
            .onAppear{
                preferredCategories = getPreferredCategories()
            }
            .contextMenu(ContextMenu(menuItems: {
                keyExists(key: veggie.name) ?
                    Button{
                        removeData(key: veggie.name)
                    } label: {
                        Label("Remove from garden", systemImage: "book")
                    }:
                    Button{
                        saveData(data: true, key: veggie.name)
                    } label: {
                        Label("Add to garden", systemImage: "book")
                    }
                
                Button{
                    preferredCategories.remove(veggie.categoryName)
                    saveData(data: Array(preferredCategories), key: "categories")
                } label: {
                    Label("Hide all \(veggie.categoryName.lowercased())s", systemImage: "person.crop.circle")
                }
            }))
        }
    }
}

