//
//  ContentView.swift
//  Cat or Dog?
//
//  Created by Sam Grover on 2023-03-10.
//

import SwiftUI

struct ContentView: View {
    // whenever there is animal recieved then the UI will be updated
    @ObservedObject var model: AnimalModel
    
    var body: some View {
        VStack{
            GeometryReader {geo in
                Image(uiImage: UIImage(data: model.animal.imageData ?? Data()) ?? UIImage())
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height:geo.size.height)
                    .clipped()
                    .edgesIgnoringSafeArea(.all)
            }
            
            
            HStack{
                Text("What is it?")
                    .font(.title)
                    .bold()
                    
                
                Spacer()
                
                Button {
                    self.model.getAnimal()
                } label: {
                    Text("Next").bold()
                }

            }
            .padding(.horizontal, 20)
            
            if #available(iOS 14.0, *){
                ScrollView{
                    LazyVStack{
                        ForEach(model.animal.results){
                            result in
                            AnimalRow(imageLabel: result.imageLabel, confidence: result.confidence)
                        }.padding(.horizontal, 10)
                            .padding(.vertical, 5)
                    }
                }
            }else{
                List(model.animal.results) { result in
                    AnimalRow(imageLabel: result.imageLabel, confidence: result.confidence)
                }
            }
        }
        .onAppear(perform: model.getAnimal)
        .opacity(model.animal.imageData == nil ? 0 : 1)
        .animation(.easeIn)
        //when you appear, download get the animal
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: AnimalModel())
    }
}
