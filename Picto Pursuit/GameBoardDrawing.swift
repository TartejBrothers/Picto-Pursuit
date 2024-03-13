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
    
    @StateObject private var webSocketManager = WebSocketManager()
    
    var body: some View {
        VStack {
            if let roomCode = roomCode {
                Text("Room Code: \(roomCode)")
                    .font(.title)
                    .padding(.bottom, 20)
            }
            Text("To Draw : Cat")
            ZStack {
                DrawingCanvas(isErasing: $isErasing)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.all, 20)

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
                Button(action: {
                    // Get drawing data from canvas and send it
                    guard let drawingData = webSocketManager.drawingCanvas?.canvasView.drawing.dataRepresentation() else {
                        print("Error getting drawing data: Canvas is empty")
                        return
                    }
                    webSocketManager.sendDrawingData(data: drawingData)
                }) {
                    Text("Send Drawing")
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

struct GameBoardDrawing_Previews: PreviewProvider {
    static var previews: some View {
        GameBoardDrawing(roomCode: .constant(200000))
    }
}
