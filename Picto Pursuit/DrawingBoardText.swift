//
//  DrawingBoardText.swift
//  Picto Pursuit
//
//  Created by Taranjeet Singh Bedi on 09/03/24.
//

import SwiftUI

struct DrawingBoardText: View {
    @State private var isErasing = false
    @State private var guess: String = ""
    
    
    var body: some View {
        VStack {
            ZStack {
                DrawingCanvas(isErasing: $isErasing)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .disabled(true) // Disable DrawingCanvas
                
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.blue, lineWidth: 2)
                    .padding(20)
                    .opacity(0.5)
                    .allowsHitTesting(false)
            }
            
            TextField("Enter your guess", text: $guess)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                // Add action for submitting the guess
                print("Submit button tapped with guess: \(guess)")
            }) {
                Text("Submit")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
    }
}

#if DEBUG
struct DrawingBoardText_Previews: PreviewProvider {
    static var previews: some View {
        DrawingBoardText()
    }
}
#endif