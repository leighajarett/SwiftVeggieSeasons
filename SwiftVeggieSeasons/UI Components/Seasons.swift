//
//  Seasons.swift
//  SwiftVeggieSeasons
//
//  Created by Leigha Jarett on 7/18/23.
//

import SwiftUI


struct Seasons: View {
    let veggie: Veggie

    var body: some View {
        HStack{
            if veggie.seasons.contains(Season.autumn){
                Image(systemName: "tree.fill").foregroundColor(Color("brown"))
            }
            if veggie.seasons.contains(Season.winter){
                Image(systemName: "snowflake").foregroundColor(.blue)
            }
            if veggie.seasons.contains(Season.spring){
                Image(systemName: "leaf.fill").foregroundColor(Color("green"))
            }
            if veggie.seasons.contains(Season.summer){
                Image(systemName: "sun.max.fill").foregroundColor(Color("orange"))
            }
        }.frame(maxWidth: .infinity, alignment:.trailing)
    }
}


