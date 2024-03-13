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

struct DrawingCanvas: UIViewRepresentable {
    @Binding var isErasing: Bool
    var canvasView = PKCanvasView()
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput
        canvasView.tool = PKInkingTool(.pen, color: .black, width: 5)
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        if isErasing {
            uiView.tool = PKEraserTool(.vector)
        } else {
            uiView.tool = PKInkingTool(.pen, color: .black, width: 5)
        }
    }
    
    // Method to update drawing with received data
    func updateDrawing(with data: Data) {
        do {
            let drawing = try PKDrawing(data: data)
            canvasView.drawing = drawing
        } catch {
            print("Error updating drawing: \(error)")
        }
    }
}


struct DrawingCanvas_Previews: PreviewProvider {
    static var previews: some View {
        DrawingCanvas(isErasing: .constant(false))
    }
}
