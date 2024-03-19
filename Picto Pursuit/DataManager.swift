import Foundation
import FirebaseFirestore

class DataManager: ObservableObject {
    private let db = Firestore.firestore()
    
    @Published var receivedData: Data?
    let roomCode: Int
    
    init(roomCode: Int) {
        self.roomCode = roomCode
        listenForDataUpdates()
    }
    
    public func sendData(data: Data) {
        // Convert data to base64 string
        let base64String = data.base64EncodedString()
        
        // Save the base64 string in Firestore
        db.collection("drawings").document("\(roomCode)").setData(["data": base64String]) { error in
            if let error = error {
                print("Error sending data: \(error)")
            } else {
                print("Data sent successfully.")
            }
        }
    }
    
    private func listenForDataUpdates() {
        // Reference to the Firestore document
        let documentRef = db.collection("drawings").document("\(roomCode)")
        
        // Listen for changes to the Firestore document
        documentRef.addSnapshotListener { [weak self] snapshot, error in
            guard let snapshot = snapshot else {
                print("Error fetching snapshot: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if !snapshot.exists {
                // Create a new document if it doesn't exist
                documentRef.setData([:]) { error in
                    if let error = error {
                        print("Error creating document: \(error.localizedDescription)")
                    } else {
                        print("Document created successfully.")
                    }
                }
            } else if let base64String = snapshot.data()?["data"] as? String {
                // Convert base64 string to data
                if let decodedData = Data(base64Encoded: base64String) {
                    DispatchQueue.main.async {
                        self?.receivedData = decodedData
                        print("Received data size: \(decodedData.count) bytes")
                        // Print the received data
                        print("Received data: \(decodedData)")
                    }
                } else {
                    print("Error decoding base64 string")
                }
            } else {
                print("Document exists but does not contain any data.")
            }
        }
    }
}
