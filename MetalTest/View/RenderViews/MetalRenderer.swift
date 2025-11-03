//
//  MetalRenderer.swift
//  MetalTest
//
//  Created by Noah Albrock on 03/11/2025.
//

import MetalKit

class MetalRenderer: NSObject, MTKViewDelegate {
    var parent: MetalViewRepresentable
    var device: MTLDevice!
    var commandQueue: MTLCommandQueue!
    
    init(_ parent: MetalViewRepresentable) {
        self.parent = parent
        
        if let device = MTLCreateSystemDefaultDevice() {
            self.device = device
        }
        
        self.commandQueue = device.makeCommandQueue()
        
        super.init()
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable else { return }
        
        let commandBuffer = commandQueue.makeCommandBuffer()!
        let renderPassDescriptor = view.currentRenderPassDescriptor!
        
        // render pass - clear - set clear colour
        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColor(red: 0.0, green: 0.5, blue: 0.5, alpha: 1.0)
        renderPassDescriptor.colorAttachments[0].loadAction = .clear
        renderPassDescriptor.colorAttachments[0].storeAction = .store
        
        let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)!
        renderEncoder.endEncoding()
        
        // commit and present the state of the buffer
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
