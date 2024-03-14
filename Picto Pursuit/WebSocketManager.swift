import Combine
import Foundation

class WebSocketManager: ObservableObject {
    var webSocketTask: URLSessionWebSocketTask?
    
    // Published property to store received data
    @Published var receivedData: Data?
    
    init() {
        establishWebSocketConnection()
    }
    
    func establishWebSocketConnection() {
        guard let url = URL(string: "wss://free.blr2.piesocket.com/v3/1?api_key=XkJLUWd8cNLjXdIM8zng4scrdJi0DiT6Es3D3Rjb") else {
            print("Invalid WebSocket URL")
            return
        }
        
        let session = URLSession(configuration: .default)
        webSocketTask = session.webSocketTask(with: url)
        
        webSocketTask?.resume()
        

        receiveDrawingData()
    }
    
    // Method to send drawing data over WebSocket
    func sendDrawingData(data: Data) {
        guard let webSocketTask = webSocketTask else {
            print("WebSocket task is not initialized.")
            return
        }
        
        let base64String = data.base64EncodedString()
        let message = URLSessionWebSocketTask.Message.string(base64String)
        
        webSocketTask.send(message) { error in
            if let error = error {
                print("Error sending drawing data: \(error)")
            }
        }
    }
    
    // Method to receive drawing data over WebSocket
    func receiveDrawingData() {
        guard let webSocketTask = webSocketTask else {
            print("WebSocket task is not initialized.")
            return
        }
        
        webSocketTask.receive { [weak self] result in
            switch result {
            case .success(let message):
                DispatchQueue.main.async {
                    switch message {
                    case .string(let base64String):
                        // Convert Base64 string back to Data
                        if let data = Data(base64Encoded: base64String) {
                            // Store received data
                            self?.receivedData = data
                            // Print the received data
                            if let receivedString = String(data: data, encoding: .utf8) {
                                print("Received Drawing Data: \(receivedString)")
                            }
                        } else {
                            print("Error decoding Base64 string")
                        }
                    default:
                        print("Received unsupported message type.")
                    }
                }
                // Continue listening for drawing data
                self?.receiveDrawingData()
            case .failure(let error):
                // Handle error
                print("WebSocket error: \(error)")
            }
        }
    }
}
