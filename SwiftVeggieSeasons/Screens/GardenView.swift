//
//  GardenView.swift
//  SwiftVeggieSeasons
//
//  Created by Leigha Jarett on 7/18/23.
//

import SwiftUI


struct GardenView: View {
    @State var gardenVeggies: Array<Veggie> = []
    
    var body: some View {
        NavigationStack{
            List(gardenVeggies, id: \.name) { veggie in
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
                        Seasons(veggie: veggie)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("My Garden")
        }.onAppear{
            gardenVeggies = []
            for veggie in veggies {
                if(keyExists(key: veggie.name)){
                    gardenVeggies.append(veggie)
                }
            }
        }
    }
}


struct GardenView_Previews: PreviewProvider {
    static var previews: some View {
        GardenView()
    }
}


