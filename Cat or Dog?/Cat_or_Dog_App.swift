//
//  Cat_or_Dog_App.swift
//  Cat or Dog?
//
//  Created by Sam Grover on 2023-03-10.
//

import SwiftUI

@main
struct Cat_or_Dog_App: App {
    var body: some Scene {
        WindowGroup {
            ContentView(model: AnimalModel())
        }
    }
}
