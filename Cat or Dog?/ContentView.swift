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
            Image(uiImage: UIImage(data: model.animal.imageData ?? Data()) ?? UIImage())
                .resizable()
                .scaledToFill()
                .clipped()
                .edgesIgnoringSafeArea(.all)
            
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
        }
        .onAppear(perform: model.getAnimal)
        .opacity(model.animal.imageData == nil ? 0 : 1)
        //when you appear, download get the animal
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: AnimalModel())
    }
}
