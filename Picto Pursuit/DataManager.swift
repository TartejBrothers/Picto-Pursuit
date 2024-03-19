import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class DataManager: ObservableObject {
    private let db = Firestore.firestore()
    
    @Published var receivedData: Data?
    let roomCode: Int
    
    init(roomCode: Int) {
        self.roomCode = roomCode
        listenForDataUpdates()
    }
    
    public func sendData(data: Data) {
        // Save the data in Firestore
        db.collection("drawings").document("\(roomCode)").setData(["data": data]) { error in
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
            } else {
                // Print the entire snapshot data
                print("Snapshot data: \(snapshot.data() ?? [:])")
                
                // Check if data field is present
                if let drawingData = snapshot.data()?["data"] as? Data {
                    // Update receivedData
                    DispatchQueue.main.async {
                        self?.receivedData = drawingData
                    }
                    print("Received drawing data: \(drawingData)")
                } else {
                    print("No drawing data found.")
                }
            }
        }
    }
}
