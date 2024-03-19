import SwiftUI
import PencilKit

struct DrawingBoardText: View {
    @State private var isErasing = false
    @State private var guess: String = ""
    @ObservedObject private var dataManager = DataManager(roomCode: 200000) // Change webSocketManager to dataManager
    var roomCode: Int
    
    var body: some View {
        VStack {
            Text("Room Code: \(roomCode)")
                .font(.title)
                .padding(.bottom, 20)
            ZStack {
                DrawingCanvas(isErasing: $isErasing, drawingData: $dataManager.receivedData, dataManager: dataManager) // Change webSocketManager to dataManager
                    .frame(maxWidth: .infinity, maxHeight: .infinity
                    )
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
                                
                                if let receivedData = dataManager.receivedData {
                                    if let decodedData = UIImage(data: receivedData) {
                                        // Display the received PencilKit drawing
                                        Image(uiImage: decodedData)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .padding()
                                    } else {
                                        Text("Failed to decode received data")
                                    }
                                }
                            }
                            .onAppear {
                                // Subscribe to changes in receivedData
                                dataManager.$receivedData.sink { receivedData in
                                    print("Received data updated: \(receivedData)")
                                }
                            }
                        }
                    }

                    struct DrawingBoardText_Previews: PreviewProvider {
                        static var previews: some View {
                            DrawingBoardText(roomCode: 200000)
                        }
                    }
