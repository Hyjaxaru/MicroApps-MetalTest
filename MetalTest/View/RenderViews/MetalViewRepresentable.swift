//
//  MetalViewRepresentable.swift
//  MetalTest
//
//  Created by Noah Albrock on 03/11/2025.
//

import MetalKit
import SwiftUI

struct MetalViewRepresentable: UIViewRepresentable {
    func makeCoordinator() -> MetalRenderer {
        // We are going to create this class elsewhere, so don't be shocked if you're getting a few errors here
        MetalRenderer(self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<MetalViewRepresentable>) -> MTKView {
        let mtkView = MTKView()
        mtkView.delegate = context.coordinator
        mtkView.preferredFramesPerSecond = 60
        mtkView.enableSetNeedsDisplay = true
        
        
        if let metalDevice = MTLCreateSystemDefaultDevice() {
            mtkView.device = metalDevice
        }
        
        mtkView.framebufferOnly = false
        mtkView.drawableSize = mtkView.frame.size
        return mtkView
    }
        
    func updateUIView(_ uiView: MTKView, context: UIViewRepresentableContext<MetalViewRepresentable>) {
        // placeholder :)
    }
    
}

#Preview {
    MetalViewRepresentable()
}
