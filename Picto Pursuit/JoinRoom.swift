//
//  JoinRoom.swift
//  Picto Pursuit
//
//  Created by Taranjeet Singh Bedi on 09/03/24.
//

import SwiftUI

struct JoinRoom: View {
    @State private var code: Int?
    @State private var inputCode: String = ""
    @State private var isDrawingBoardActive = false
    
    var body: some View {
        VStack {
            TextField("Enter Room Code", text: $inputCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            NavigationLink(
                destination: DrawingBoardText(roomCode: code ?? 0),
                isActive: $isDrawingBoardActive) {
                EmptyView()
            }
            
            Button(action: {
                
                if let roomCode = Int(inputCode) {
                    code = roomCode
                    isDrawingBoardActive = true
                }
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

struct JoinRoom_Previews: PreviewProvider {
    static var previews: some View {
        JoinRoom()
    }
}

