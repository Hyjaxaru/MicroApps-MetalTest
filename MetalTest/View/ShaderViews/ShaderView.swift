//
//  ShaderView.swift
//  MetalTest
//
//  Created by Noah Albrock on 01/11/2025.
//

import SwiftUI

struct ShaderView: View {
    var shader: Shader
    var effectType: Shader.UsageType
    var shaderCanvasType: ShaderTestCanvasType
    
    var shaderCanvas: some View {
        ZStack {
            switch shaderCanvasType {
            case .rectangle: Rectangle()
            case .circle: Circle()
            }
        }
    }
    
    init(
        _ shader: Shader,
        effectType: Shader.UsageType = .colorEffect,
        canvasType: ShaderTestCanvasType = .rectangle
    ) {
        self.shader = shader
        self.effectType = effectType
        self.shaderCanvasType = canvasType
    }
    
    var body: some View {
        switch effectType {
        case .layerEffect:
            shaderCanvas
                .layerEffect(shader, maxSampleOffset: .zero)
                .ignoresSafeArea()
        case .distortionEffect:
            shaderCanvas
                .distortionEffect(shader, maxSampleOffset: .zero)
                .ignoresSafeArea()
        default: // .colorEffect
            shaderCanvas
                .colorEffect(shader)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    ShaderView(ShaderLibrary.checkerboard(.float(10), .color(.blue)))
}
