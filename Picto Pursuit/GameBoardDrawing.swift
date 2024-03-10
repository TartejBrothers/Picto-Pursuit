//
//  GameBoardDrawing.swift
//  Picto Pursuit
//
//  Created by Taranjeet Singh Bedi on 09/03/24.
//

import SwiftUI

struct GameBoardDrawing: View {
    @State private var isErasing = false
    @Binding var roomCode: Int?
    
    var body: some View {
        VStack {
            if let roomCode = roomCode {
                           Text("Room Code: \(roomCode)")
                               .font(.title)
                               .padding(.bottom, 20)
                       }
            ZStack {
                DrawingCanvas(isErasing: $isErasing)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.all,20)

                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.blue, lineWidth: 2)
                    .padding(.all, 20)
                    .opacity(0.5)
                    .allowsHitTesting(false)
            }
            
            HStack {

                
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
    GameBoardDrawing(roomCode: .constant(200000))

}
