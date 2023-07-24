//
//  TriviaCard.swift
//  SwiftVeggieSeasons
//
//  Created by Leigha Jarett on 7/18/23.
//
import SwiftUI

struct TriviaCard: View {
    let veggie: Veggie
    let namespace: Namespace.ID
    @Binding var showTriviaPage: Bool
    @Binding var isAppeared: Bool
    
    var body: some View {
        ZStack(alignment:.leading){
            Image(veggie.imageAssetPath)
                .resizable()
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, veggie.accentColor]),
                        startPoint: .trailing,
                        endPoint: .bottom
                    ))
                .matchedGeometryEffect(id: "img", in: namespace, anchor: .top)
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .transition(.scale)
                .onAppear {
                    withAnimation(.linear) {
                        isAppeared = showTriviaPage
                    }
                }
                .mask {
                    RoundedRectangle(cornerRadius:10)
                        .matchedGeometryEffect(id: "shape", in: namespace)
                }
        
            VStack{
                Text("\(veggie.name) trivia".uppercased())
                    .font(.subheadline).bold()
                    .foregroundColor(.white).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal)
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .matchedGeometryEffect(id: "trivia-text", in: namespace)
                VStack{
                    Text("Test how much you")
                        .frame(maxWidth:.infinity, alignment: .leading)
                    Text("know about \(veggie.name)")
                        .frame(maxWidth:.infinity, alignment: .leading)
                }
                .matchedGeometryEffect(id: "title-text", in: namespace)
                .padding(.top, 1)
                .padding(.leading)
                .bold().font(.title)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)

                HStack {
                    Text("Start playing")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.white).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                    Image(systemName: "chevron.forward")
                }
                .frame(maxWidth:.infinity, alignment: .leading)
                .padding(.top, 5).foregroundColor(.white)
                .padding(.leading)
            }
        }
    }
}
