//
//  JoinRoom.swift
//  Picto Pursuit
//
//  Created by Taranjeet Singh Bedi on 09/03/24.
//

import SwiftUI

struct JoinRoom: View {
    @State private var code: String = ""
    
    
    var body: some View {
        VStack {
            TextField("Enter Room Code", text: $code)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                
                
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

