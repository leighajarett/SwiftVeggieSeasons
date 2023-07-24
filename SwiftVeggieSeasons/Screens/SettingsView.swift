//
//  SettingsView.swift
//  SwiftVeggieSeasons
//
//  Created by Leigha Jarett on 7/18/23.
//

import SwiftUI


struct SettingsView: View {
    @State private var calorieTarget: Double

    init() {
        self.calorieTarget = getCal()
    }
    
    var body: some View{
        NavigationStack {
            List{
                Section{HStack{
                    VStack{
                        HStack{
                            SettingsIcon(iconName: "figure.run", color: .green)
                            
                            VStack{
                                Text("Calorie Target").frame(maxWidth: .infinity, alignment: .topLeading)
                                Text("Set your daily calorie intake target").foregroundColor(Color.gray).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/).font(/*@START_MENU_TOKEN@*/.caption/*@END_MENU_TOKEN@*/)
                            }
                        }
                        HStack{
                            Slider(value: $calorieTarget, in: 1000...3000).controlSize(.large)
                            Text(String(format: "%.0f", calorieTarget))
                                .foregroundColor(Color.gray).font(.footnote)
                        }
                    }
                }}
                
                NavigationLink(
                    destination: PreferredCategoriesView()
                        .frame(maxHeight: .infinity, alignment: .topLeading)
                ){
                    HStack{
                        SettingsIcon(iconName: "person.crop.circle", color: .blue)
                        VStack{
                            Text("Preferred Categories").frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                            Text("Set your favorite fruit and veggie types").foregroundColor(Color.gray).frame(maxWidth: .infinity, alignment: .leading).multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/).font(/*@START_MENU_TOKEN@*/.caption/*@END_MENU_TOKEN@*/)
                        }
                    }
                }
            }.navigationTitle("Settings")}
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
