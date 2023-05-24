//
//  VeggieDetailsView.swift
//  SwiftVeggieSeasons
//
//  Created by Leigha Jarett on 5/22/23.
//

import SwiftUI


struct VeggieDetailsView: View {
    let veggie: Veggie
    @State private var addToFavorites = true
    @State var showTriviaPage: Bool = false
    @Namespace var namespace
    
    var body: some View {
        List{
            Section{
                VStack{
                    Header()
                    
                    // Trivia Card button to show the trivia detail view
                    Button {
                        // When the button is clicked, show the trivia page
                        withAnimation(.interactiveSpring(response:0.6, dampingFraction: 0.7, blendDuration: 0.7)){
                            showTriviaPage = true
                        }
                    } label :{
                        TriviaCard(
                            veggie:veggie,
                            fullScreen: false
                        ).matchedGeometryEffect(id: "trivia", in: namespace)
                    }
                    .buttonStyle(ScaledButtonStyle())
                }
            }.listSectionSeparator(.hidden)
            
            GeneralInfo()
            
            ServingInfo()
            
        }
        .listStyle(.inset)
        .navigationBarTitleDisplayMode(.inline)
        .overlay{
            if showTriviaPage{
                TriviaDetailView(
                    veggie: veggie,
                    namespace: namespace,
                    showTriviaPage: $showTriviaPage
                )
            }
        }
    }
    
    func Header()-> some View{
        VStack{
            HStack(alignment: .bottom){
                Text("\(veggie.name)")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth:.infinity, alignment: .leading)
                Image(veggie.imageAssetPath)
                    .resizable()
                    .frame(width:50, height:50)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
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
            DetailLabelView(label: "Category", value:veggie.categoryName ?? "No category listed")
            HStack{
                Text("Seasons")
                HStack{
                    if veggie.seasons.contains(Season.autumn){
                        Image(systemName: "tree.fill").foregroundColor(Color("brown"))
                    }
                    if veggie.seasons.contains(Season.winter){
                        Image(systemName: "snowflake").foregroundColor(.blue)
                    }
                    if veggie.seasons.contains(Season.spring){
                        Image(systemName: "leaf.fill").foregroundColor(Color("green"))
                    }
                    if veggie.seasons.contains(Season.summer){
                        Image(systemName: "sun.max.fill").foregroundColor(Color("orange"))
                    }
                }.frame(maxWidth: .infinity, alignment:.trailing)
            }
            HStack{
                Toggle("Add to garden", isOn: $addToFavorites)
            }
        }
        
    }
    
    func ServingInfo()-> some View{
        Section("Serving info"){
            DetailLabelView(
                label: "Serving size",
                value:veggie.servingSize)
            DetailLabelView(
                label: "Calories",
                value:String(veggie.caloriesPerServing) + " kCal")
            DetailLabelView(
                label: "Vitamin A",
                value:String(veggie.vitaminAPercentage) + "% DV")
            DetailLabelView(
                label: "Vitamin C",
                value:String(veggie.vitaminCPercentage) + "% DV")
            Text("Percent daily values based on a diey of 1000 calories")
        }
        
    }
}

struct TriviaDetailView: View{
    let veggie: Veggie
    let namespace: Namespace.ID
    @Binding var showTriviaPage: Bool
    
    var body: some View {
        ScrollView{
            VStack{
                TriviaCard(
                    veggie: veggie,
                    fullScreen: true
                )
                .matchedGeometryEffect(id: "trivia", in: namespace)
            }
        }
        .frame(maxHeight: .infinity)
        .background(Color(UIColor.systemBackground))
        .toolbar{
            ToolbarItem(placement:.navigationBarTrailing){
                Button{
                    withAnimation(.interactiveSpring(response:0.6, dampingFraction: 0.7, blendDuration: 0.7)){
                        showTriviaPage = false
                    }
                }label:{
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.white)
                }
            }
        }
//        .navigationBarBackButtonHidden()
        .edgesIgnoringSafeArea(.top)
    }
    
}



struct TriviaCard: View {
    let veggie: Veggie
    var fullScreen: Bool
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    
    var body: some View {
        ZStack(alignment:.leading){
            Image(veggie.imageAssetPath)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 225)
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, veggie.accentColor]),
                        startPoint: .trailing,
                        endPoint: .bottom
                    ))
                .cornerRadius(fullScreen ? 0 : 10)
            VStack{
                Text("\(veggie.name) trivia".uppercased())
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .foregroundColor(.white)
                Text("Test how much you know about \(veggie.name)")
                    .padding(.top, 3)
                    .bold().font(.title2)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .foregroundColor(.white)
                if !fullScreen {
                    HStack {
                        Text("Start playing")
                            .font(.footnote)
                            .bold()
                            .foregroundColor(.white)
                        Image(systemName: "chevron.forward")
                    }
                    .frame(maxWidth:.infinity, alignment: .leading)
                    .padding(.top, 5).foregroundColor(.white)
                }
            }
            .padding(.horizontal)
            .padding(.trailing)
            .offset(y: fullScreen ? safeAreaInsets.top : 0)
        }
    }
}


struct QuestionView: View {
    let triviaQuestions: [Trivia]
    let questionNumber: Int
    @State private var isAnswered: Bool = false
    @State private var selectedAnswer: Int? = nil

    var body: some View{
        let trivia = triviaQuestions[questionNumber]
        VStack{
            Text(trivia.question)
                .padding()
                .frame(maxWidth: .infinity, alignment: .topLeading)

            ForEach(0..<trivia.answers.count) { index in
                Button(
                    action: {
                        selectedAnswer = index
                        isAnswered = true
                    }) {
                        Text(trivia.answers[index])
                            .frame(maxWidth:.infinity)
                            .bold()
                    }
                    .disabled(isAnswered)
                    .buttonStyle(.borderedProminent)
                    .padding(.horizontal)
            }

            if isAnswered {
                Text(selectedAnswer == trivia.correctAnswerIndex
                     ? "Correct!" : "Incorrect!")
                .foregroundColor(selectedAnswer == trivia.correctAnswerIndex
                                 ? .green : .red)
                .padding()
            }

            if(questionNumber + 1 < triviaQuestions.count){
                NavigationLink(destination: QuestionView(triviaQuestions: triviaQuestions, questionNumber:  questionNumber+1).navigationBarTitleDisplayMode(.inline)){
                    Text("Next Question")
                }
            }
        }.frame(maxHeight: .infinity, alignment: .top)
    }
}
 
struct DetailLabelView: View {
    let label: String
    let value: String

    var body: some View{
        HStack{
            Text(label)
            Text(value)
                .frame(maxWidth: .infinity,
                       alignment:.trailing)
                .foregroundColor(Color.secondary)
        }
    }

}



struct VeggieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{VeggieDetailsView(veggie: veggies[0])}
    }
}

//struct TriviaView_Previews: PreviewProvider {
//    static var previews: some View {
//        TriviaView(veggie:veggies[0], isShowingSheet: .constant(true))
//    }
//}




//
//struct TriviaView: View {
//    let veggie: Veggie
//    let headerHeight = 200.0
//    @State private var questionNum: Int = 0
//    @Binding var isShowingSheet: Bool
//    @Environment(\.safeAreaInsets) private var safeAreaInsets
//
//
//    var body: some View {
//        VStack {
//            ZStack(alignment: .topTrailing){
//                Image(veggie.imageAssetPath)
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(height: headerHeight, alignment: .center)
//                    .clipped()
//                    .overlay(veggie.accentColor.opacity(0.7))
//
//                VStack(alignment: .leading){
//                    Text("Let's Play".uppercased()).foregroundColor(.white.opacity(0.7))
//                    Text("How well do you know \(veggie.name)?")
//                        .font(.largeTitle)
//                        .bold()
//                        .foregroundColor(.white)
//                }
//                .padding()
//                .frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .bottomLeading)
//
//                Button(action: {isShowingSheet = false}){
//                    Image(systemName: "multiply.circle.fill")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(height:30)
//                        .foregroundColor(.white.opacity(0.8))
//                }.padding(20)
//            }
//            .frame(height:headerHeight)
//            .edgesIgnoringSafeArea(.top)
//
//            VStack{
//                Text("Question \(questionNum + 1) of \(veggie.trivia.count)".uppercased())
//                    .foregroundColor(.secondary)
//                    .frame(maxWidth: .infinity, alignment: .topLeading)
//                    .padding(.top)
//
//                ProgressView(value: Double(questionNum) / Double(veggie.trivia.count))
//                    .progressViewStyle(.linear)
//
//                NavigationStack {
//                    QuestionView(triviaQuestions: veggie.trivia, questionNumber:questionNum).navigationBarTitleDisplayMode(.inline).navigationBarBackButtonHidden()
//                }
//
//
//            }.frame(maxHeight:.infinity, alignment: .top)
//            // Can't figure out how to get bounds of Zstack to respect the ignore safe area
//            // it's applied to the content but not the frame itself. So, just using padding.
//                .padding(.top, -safeAreaInsets.top).padding(.horizontal)
//        }
//    }
//
////    func nextQuestion(selectedIndex: Int){
////        questionNum += 1
////    }
//
//}
//

private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        (UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets ?? .zero).insets
    }
}

extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

private extension UIEdgeInsets {

    var insets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}

struct ScaledButtonStyle: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}


