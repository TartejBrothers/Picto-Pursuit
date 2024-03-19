import SwiftUI

struct GameBoardDrawing: View {
    @State private var isErasing = false
    @Binding var roomCode: Int?
    
    @ObservedObject var dataManager: DataManager // Change to DataManager
    
    // State variable to hold drawing data
    @State private var drawingData: Data?
    
    init(roomCode: Binding<Int?>, dataManager: DataManager) { // Change webSocketManager to dataManager
        self._roomCode = roomCode
        self.dataManager = dataManager // Change to dataManager
    }
    
    var body: some View {
        VStack {
            if let roomCode = roomCode {
                Text("Room Code: \(roomCode)")
                    .font(.title)
                    .padding(.bottom, 20)
            }
            Text("To Draw : Cat")
            ZStack {
                DrawingCanvas(isErasing: $isErasing, drawingData: $drawingData, dataManager: dataManager) // Change webSocketManager to dataManager
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
                    if let drawingData = self.drawingData {
                        self.dataManager.sendData(data: drawingData) // Fixed call to sendData
                        print("Sent Drawing Data: \(drawingData)")
                    } else {
                        print("Error: No drawing data available")
                    }
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
        .onReceive(dataManager.$receivedData) { data in
            // Handle received data
            if let receivedData = data {
                self.drawingData = receivedData
            }
        }
    }
}

struct GameBoardDrawing_Previews: PreviewProvider {
    static var previews: some View {
        GameBoardDrawing(roomCode: .constant(nil), dataManager: DataManager(roomCode: 200000))
    }
}
