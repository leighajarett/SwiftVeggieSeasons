//
//  TriviaDetailsView.swift
//  SwiftVeggieSeasons
//
//  Created by Leigha Jarett on 7/18/23.
//
import SwiftUI

struct TriviaDetailView: View{
    let veggie: Veggie
    let namespace: Namespace.ID
    @Binding var showTriviaPage: Bool
    @Binding var isAppeared: Bool
    
    
    var body: some View {
        ScrollView{
            VStack{
                ZStack{
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
                        .frame(height: 300)
                        .transition(.scale)
                        .clipped()
                    
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
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom)
                }
                .frame(maxHeight: .infinity)
                
                QuestionView(triviaQuestions: veggie.trivia, namespace: namespace)
            }
            
        }
        .mask {
            RoundedRectangle(cornerRadius: 0)
                .matchedGeometryEffect(id: "shape", in: namespace)
            }
        .background(Color(UIColor.systemBackground))
        .onAppear {
            withAnimation(.linear) {
                isAppeared = showTriviaPage
            }}
        .overlay(
            Button{
                withAnimation(.spring(response: 0.6, dampingFraction: 0.85)){
                    showTriviaPage = false
                }
            }label:{
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.white)
            }
            .opacity(isAppeared ? 1 : 0)
            .padding(),
            alignment: .topTrailing
        )
        .statusBar(hidden:true)
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .tabBar)
        .ignoresSafeArea()
        
    }
}


struct TriviaDetailView_Previews: PreviewProvider {
    
    struct TestDetailView: View {
        @Namespace var animation
        var body: some View {
            TriviaDetailView(
                veggie: veggies[0],
                namespace: animation,
                showTriviaPage: .constant(true),
                isAppeared: .constant(true)
            )
        }
    }
    static var previews: some View {
        TestDetailView()
    }
}
