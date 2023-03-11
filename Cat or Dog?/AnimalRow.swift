//
//  AnimalRow.swift
//  Cat or Dog?
//
//  Created by Sam Grover on 2023-03-11.
//

import SwiftUI

struct AnimalRow: View {
    var imageLabel: String
    var confidence: Double
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .cornerRadius(10)
                .shadow(color: .gray, radius: 5)
            
            VStack{
                HStack{
                    Text(imageLabel).bold()  // what classification thinks it is
                    Spacer()
                    Text(String(format: "%.2f%%", confidence * 100))
                        .bold()
                }
                ProgressBar(value: confidence).frame().frame(height: 10)
            }
            .padding(20)
        }
    }
}

struct AnimalRow_Previews: PreviewProvider {
    static var previews: some View {
        AnimalRow(imageLabel: "Husky", confidence: 0.4)
    }
}
