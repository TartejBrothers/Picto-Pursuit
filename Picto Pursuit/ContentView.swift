//
//  ContentView.swift
//  Picto Pursuit
//
//  Created by Taranjeet Singh Bedi on 09/03/24.
//

import SwiftUI

struct ContentView: View {
    @State private var roomCode = randomNumberWith(digits:6)
    @State private var isActive: Bool = false
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
                    isActive: $isActive) {
                    Text("Create Room")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Button(action: {
                   
                }) {
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
}

func randomNumberWith(digits:Int) -> Int {
    let min = Int(pow(Double(10), Double(digits-1))) - 1
    let max = Int(pow(Double(10), Double(digits))) - 1
    return Int(Range(uncheckedBounds: (min, max)))
}

extension Int {
init(_ range: Range<Int> ) {
    let delta = range.lowerBound < 0 ? abs(range.lowerBound) : 0
    let min = UInt32(range.lowerBound + delta)
    let max = UInt32(range.upperBound   + delta)
    self.init(Int(min + arc4random_uniform(max - min)) - delta)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
