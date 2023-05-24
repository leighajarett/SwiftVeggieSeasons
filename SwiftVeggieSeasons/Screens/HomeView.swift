//
//  HomeView.swift
//  SwiftVeggieSeasons
//
//  Created by Leigha Jarett on 5/22/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View{
        NavigationStack {
            ScrollView {
                ForEach(veggies, id: \.id) { veggie in
                    NavigationLink(
                        destination: VeggieDetailsView(veggie: veggie)
                            .frame(maxHeight: .infinity, alignment: .topLeading)
//                            .navigationBarTitleDisplayMode(.inline)
                    ){
                        VeggieCard(veggie: veggie)
                        .padding(.bottom)
                        .padding(.horizontal)
                    }
                    
                }
            }
            .frame(maxHeight: .infinity)
            .navigationBarTitle("In season today")
            
        }
    }
}
