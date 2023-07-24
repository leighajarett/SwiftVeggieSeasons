//
//  PreferredCategoriesView.swift
//  SwiftVeggieSeasons
//
//  Created by Leigha Jarett on 7/24/23.
//

import SwiftUI

struct PreferredCategoriesView: View {
    let categories: Set<String> = getCategories()
    @State var preferredCategories: Set<String> = []
    
    var body: some View {
        NavigationStack {
            VStack{
                List(categories.sorted(), id:\.self){ category in
                    HStack{
                        if(preferredCategories.contains(category)){
                            Image(systemName: "checkmark")
                                .foregroundColor(Color.blue)
                        }
                        else{
                            Image(systemName: "checkmark")
                                .foregroundColor(Color.white)
                        }
                        Text(category)
                    }.onTapGesture {
                        if(preferredCategories.contains(category)){
                            preferredCategories.remove(category)
                        }
                        else{
                            preferredCategories.insert(category)
                        }
                    }
                }
            }
        }
        .onDisappear{
            saveData(data: Array(preferredCategories), key: "categories")
        }
        .onAppear{
            preferredCategories = getPreferredCategories()
        }
        .navigationTitle("Preferred Categories")
    }
}

