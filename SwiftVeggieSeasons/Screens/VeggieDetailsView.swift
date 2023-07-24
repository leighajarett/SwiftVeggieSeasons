//
//  VeggieDetailsView.swift
//  SwiftVeggieSeasons
//
//  Created by Leigha Jarett on 5/22/23.
//

import SwiftUI

struct VeggieDetailsView: View {
    let veggie: Veggie
    @State private var calorieTarget: Double = 2000.0
    @State private var addToFavorites: Bool = false
    @State var showTriviaPage: Bool = false
    @State var showActionSheet: Bool = false
    @State private var isAppeared = false
    @Namespace var animation
    
    
    var body: some View {
        ZStack{
            if !showTriviaPage{
                List{
                    Header().listSectionSeparator(.hidden)
                    Section{
                        VStack{
                            // Trivia Card button to show the trivia detail view
                            Button {
                                // When the button is clicked, show the trivia page
                                withAnimation(.spring(
                                    response:0.5,
                                    dampingFraction: 0.7
                                )){
                                    showTriviaPage = true
                                }
                            } label :{
                                TriviaCard(
                                    veggie:veggie,
                                    namespace: animation,
                                    showTriviaPage: $showTriviaPage,
                                    isAppeared: $isAppeared
                                )
                            }
                            .buttonStyle(ScaledButtonStyle())
                        }
                    }.listSectionSeparator(.hidden)
                    
                    GeneralInfo()
                    
                    ServingInfo()
                    
                }
                // Styles the list
                .listStyle(.inset)
                // Ensures there isn't a weird gap where the large title would be
                .navigationBarTitleDisplayMode(.inline)
                // Removes extra padding added by list
                .padding(.top,-20)
            } else {
                TriviaDetailView(
                    veggie: veggie,
                    namespace: animation,
                    showTriviaPage: $showTriviaPage,
                    isAppeared: $isAppeared
                )
            }
            
        }.onAppear{
            addToFavorites = keyExists(key: veggie.name)
            calorieTarget = getCal()
        }
    }
    
    func Header()-> some View{
        VStack{
            // I wanted to make this view into a navigation title but that can only be a string not a view itself.
            // This means you don't get the pull down effect.
            HStack(alignment: .bottom){
                Text("\(veggie.name)")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth:.infinity, alignment: .leading)
                Image(veggie.imageAssetPath)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .frame(width:50, height:50)
            }
            Divider()
            Text("\(veggie.shortDescription)")
                .font(.title3)
                .foregroundColor(.secondary)
                .frame(maxWidth:.infinity, alignment: .leading)
        }
    }
    
    func GeneralInfo()-> some View{
        Section("General info"){
            DetailLabel(label: "Category", value:veggie.categoryName)
            HStack{
                Text("Seasons")
                Seasons(veggie: veggie)
            }
            HStack{
                Toggle("Add to garden", isOn: $addToFavorites)
                    .onChange(of: addToFavorites){newState in
                        if newState{
                            saveData(data: true, key: veggie.name)
                        }else{
                            showActionSheet = true
                        }
                    }
                    .confirmationDialog("\(veggie.name) will be removed from your garden", isPresented: $showActionSheet, titleVisibility: .visible) {
                        Button("Remove \(veggie.name)", role: .destructive) {
                            removeData(key: veggie.name)
                        }
                        
                        Button("Cancel") {
                            addToFavorites = true
                            showActionSheet = false
                        }
                    }
            }
        }
    }
    
    func ServingInfo()-> some View{
        Section("Serving info"){
            DetailLabel(
                label: "Serving size",
                value:veggie.servingSize)
            DetailLabel(
                label: "Calories",
                value: String(veggie.caloriesPerServing) + " kCal")
            DetailLabel(
                label: "Vitamin A",
                value:String(format: "%.1f", Double(veggie.vitaminAPercentage) * (calorieTarget/1000.0)) + "% DV")
            DetailLabel(
                label: "Vitamin A",
                value:String(format: "%.1f", Double(veggie.vitaminCPercentage) * (calorieTarget/1000.0)) + "% DV")
            Text("Percent daily values based on a diet of \(String(format: "%.0f", calorieTarget)) calories")
                .font(.caption)
                .listSectionSeparator(.hidden)
        }
        
    }
}


struct VeggieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{VeggieDetailsView(veggie: veggies[0])}
    }
}


