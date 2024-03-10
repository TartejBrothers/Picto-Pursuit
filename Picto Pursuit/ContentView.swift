//
//  ContentView.swift
//  Picto Pursuit
//
//  Created by Taranjeet Singh Bedi on 09/03/24.
//
import SwiftUI

struct ContentView: View {
    @State private var roomCode = randomNumberWith(digits: 6)
    @State private var isJoinRoomActive = false
    @State private var isGameBoardDrawingActive = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("Picto Pursuit")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                
                NavigationLink(
                    destination: GameBoardDrawing(roomCode: .constant(roomCode)),
                    isActive: $isGameBoardDrawingActive) {
                    Text("Create Room")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .onAppear {
                    regenerateRoomCode()
                }
                
                NavigationLink(
                    destination: JoinRoom(),
                    isActive: $isJoinRoomActive) {
                    Text("Join Room")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
    
    private func regenerateRoomCode() {
        roomCode = randomNumberWith(digits: 6)
    }
}

func randomNumberWith(digits:Int) -> Int {
    let min = Int(pow(Double(10), Double(digits-1))) - 1
    let max = Int(pow(Double(10), Double(digits))) - 1
    return Int.random(in: min...max)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
