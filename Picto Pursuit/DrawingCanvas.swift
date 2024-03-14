//
//  Drawing_Canvas.swift
//  Picto Pursuit
//
//  Created by Taranjeet Singh Bedi on 09/03/24.
//
//
//  Drawing_Canvas.swift
//  Picto Pursuit
//
//  Created by Taranjeet Singh Bedi on 09/03/24.
//
import SwiftUI
import PencilKit

// Custom delegate to observe drawing changes
class DrawingDelegate: NSObject, PKCanvasViewDelegate {
    var drawingChanged: ((PKDrawing) -> Void)?
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        drawingChanged?(canvasView.drawing)
    }
}

struct DrawingCanvas: UIViewRepresentable {
    @Binding var isErasing: Bool
    @Binding var drawingData: Data?
    var canvasView = PKCanvasView()
    
    // WebSocket connection
    var webSocketManager: WebSocketManager
    
    // Delegate to observe drawing changes
    private let delegate = DrawingDelegate()
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput
        canvasView.tool = PKInkingTool(.pen, color: .black, width: 5)
        
        // Set the delegate to observe drawing changes
        canvasView.delegate = delegate
        
        // Set up notifications for drawing changes
        delegate.drawingChanged = { drawing in
            DispatchQueue.main.async {
                // Get drawing data and update the binding
                self.drawingData = drawing.dataRepresentation()
            }
        }
        
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        if isErasing {
            uiView.tool = PKEraserTool(.vector)
        } else {
            uiView.tool = PKInkingTool(.pen, color: .black, width: 5)
        }
    }
    
    static func dismantleUIView(_ uiView: PKCanvasView, coordinator: ()) {
        uiView.drawing = PKDrawing()
    }
}






struct DrawingCanvas_Previews: PreviewProvider {
    static var previews: some View {
        let isErasing = Binding.constant(false)
        let drawingData = Binding.constant(Data())
        let webSocketManager = WebSocketManager()

        // Convert non-optional Binding<Data> to optional Binding<Data?>
        let optionalDrawingData = Binding<Data?>(
            get: { drawingData.wrappedValue },
            set: { newValue in
                // Implement set if needed
            }
        )

        return DrawingCanvas(isErasing: isErasing, drawingData: optionalDrawingData, webSocketManager: webSocketManager)
            .frame(width: 300, height: 300) // Adjust the frame size as needed
    }
}
