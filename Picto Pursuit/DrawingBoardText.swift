//
//  DrawingBoardText.swift
//  Picto Pursuit
//
//  Created by Taranjeet Singh Bedi on 09/03/24.
//
import SwiftUI
import Combine

struct DrawingBoardText: View {
    @State private var isErasing = false
    @State private var guess: String = ""
    @StateObject private var webSocketManager = WebSocketManager()
    var roomCode: Int
    
    var body: some View {
        VStack {
            Text("Room Code: \(roomCode)")
                .font(.title)
                .padding(.bottom, 20)
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
            
            if let receivedData = webSocketManager.receivedData{
                Text("Received Data: \(String(describing: webSocketManager.receivedData))")
            }
        }
    }
}

#if DEBUG
struct DrawingBoardText_Previews: PreviewProvider {
    static var previews: some View {
        DrawingBoardText(roomCode: 200000)
    }
}
#endif
