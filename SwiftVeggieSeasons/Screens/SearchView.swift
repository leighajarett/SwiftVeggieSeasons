//
//  SearchView.swift
//  SwiftVeggieSeasons
//
//  Created by Leigha Jarett on 7/18/23.
//

import SwiftUI


struct SearchView: View {
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.name){ veggie in
                    NavigationLink(
                        destination: VeggieDetailsView(veggie: veggie)
                            .frame(maxHeight: .infinity, alignment: .topLeading)
                    ){
                        HStack{
                            Image(veggie.imageAssetPath)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .frame(width:50, height:50)
                            Text(veggie.name).font(.title2)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Contacts")
        }
        .searchable(text: $searchText)
    }

    var searchResults: [Veggie] {
        if searchText.isEmpty {
            return veggies
        } else {
            return veggies.filter { $0.name.contains(searchText) }
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
