import SwiftUI
import PencilKit

struct DrawingBoardText: View {
    @ObservedObject private var dataManager = DataManager(roomCode: 200000)
    @State private var receivedData: Data? // Declare receivedData here
    var roomCode: Int
    
    var body: some View {
        VStack {
            Text("Room Code: \(roomCode)") // Show dynamic room code
                .font(.title)
                .padding(.bottom, 20)
            
            ZStack {
                DrawingCanvas(isErasing: .constant(false), drawingData: $dataManager.receivedData, dataManager: dataManager)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .disabled(true)
                
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.blue, lineWidth: 2)
                    .padding(20)
                    .opacity(0.5)
                    .allowsHitTesting(false)
            }
            
            TextField("Enter your guess", text: .constant(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                // Add action for submitting the guess
                print("Submit button tapped with guess: \(dataManager.roomCode)")
            }) {
                Text("Submit")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            
            if let receivedData = receivedData { // Use the locally declared receivedData
                Group {
                    // Print the size of the received data                    print("Received data size: \(receivedData.count) bytes")
                    
                    // Print the received data directly
                    
                    
                    // Display the received data view
                    ReceivedDataView(receivedData: receivedData)
                }
            } else {
                // Return a Text view indicating nil received data
                Text("Received data is nil")
            }
        }
        .onAppear {
            // Subscribe to changes in receivedData
            dataManager.$receivedData.sink { receivedData in
                if let receivedData = receivedData {
                    // Print the size of the received data
                    print("Received data size: \(receivedData.count) bytes")
                    
                    // Print the received data directly
                    print("Received data: \(receivedData)")
                    
                    // Update the local receivedData variable
                    self.receivedData = receivedData
                } else {
                    // Print a debug statement
                    print("Received data is nil")
                }
            }
        }
    }
}

struct ReceivedDataView: View {
    let receivedData: Data
    
    var body: some View {
        if let decodedData = UIImage(data: receivedData) {
            // Display the received PencilKit drawing
            return Image(uiImage: decodedData)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
                .eraseToAnyView()
        } else {
            // Return a Text view indicating failure to decode
            return Text("Failed to decode received data as UIImage")
                .eraseToAnyView()
        }
    }
}

extension View {
    func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
}

struct DrawingBoardText_Previews: PreviewProvider {
    static var previews: some View {
        DrawingBoardText(roomCode: 200000)
    }
}
