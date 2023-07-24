//
//  ContentView.swift
//  SwiftVeggieSeasons
//
//  Created by Leigha Jarett on 5/19/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 1
    
    let tabs: [(id: Int, title: String, systemName: String, view: AnyView)] = [
        (1, "Home", "house", AnyView(HomeView())),
        (2, "My Garden", "book", AnyView(GardenView())),
        (3, "Search", "magnifyingglass", AnyView(SearchView())),
        (4, "Settings", "gear", AnyView(SettingsView()))
    ]

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(tabs, id: \.id) { tab in
                tab.view
                    .tabItem {
                        Image(systemName: tab.systemName)
                        Text(tab.title)
                    }
                    .tag(tab.id)
            }
        }

    }
}


struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

