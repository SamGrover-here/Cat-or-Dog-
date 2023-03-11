//
//  ProgressBar.swift
//  Cat or Dog?
//
//  Created by Sam Grover on 2023-03-11.
//

import SwiftUI

struct ProgressBar: View {
    var value: Double
    var meterColour: Color{
        if value > 0.35{
            return .green
        }else if value > 0.2{
            return .yellow
        }else if value > 0.05 {
            return .orange
        }else{
            return .gray
        }
    }
    
    var body: some View {
        GeometryReader{geo in
            ZStack(alignment: .leading){
                //Background rectangle
                Rectangle()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .opacity(0.3)
                    .foregroundColor(.gray)
                
                Rectangle()
                    .frame(width: CGFloat(self.value) * geo.size.width, height: geo.size.height)
                    .foregroundColor(meterColour)
            }
        }
        .cornerRadius(45)
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(value: 0.7).previewLayout(.fixed(width: 300, height: 10))
    }
}
