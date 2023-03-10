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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
