//
//  HomeView.swift
//  SwiftVeggieSeasons
//
//  Created by Leigha Jarett on 5/22/23.
//

import SwiftUI

struct HomeView: View {
    @State var preferredCategories: Set<String> = []
    
    var body: some View{
        NavigationStack {
            ScrollView {
                ForEach(veggies, id: \.id) {veggie in
                    if(preferredCategories.contains(veggie.categoryName)){
                        VeggieCard(veggie: veggie)
                            .padding(.bottom)
                            .padding(.horizontal)
                    }
                }
            }
            .navigationBarTitle("In season today")
            .refreshable {
                preferredCategories = getPreferredCategories()
            }
        }.onAppear{
            preferredCategories = getPreferredCategories()
        }
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
