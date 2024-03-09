//
//  GameBoardDrawing.swift
//  Picto Pursuit
//
//  Created by Taranjeet Singh Bedi on 09/03/24.
//

import SwiftUI

struct GameBoardDrawing: View {
    @State private var isErasing = false
    
    var body: some View {
        VStack {
            ZStack {
                DrawingCanvas(isErasing: $isErasing)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.blue, lineWidth: 2)
                    .padding(20)
                    .opacity(0.5)
                    .allowsHitTesting(false)
            }
            
            HStack {
                Spacer()
                
                Button(action: {
                    isErasing.toggle()
                }) {
                    Text(isErasing ? "Drawing" : "Erasing")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }
}

#Preview {
    GameBoardDrawing()
}
