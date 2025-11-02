//
//  ShaderTests.swift
//  MetalTest
//
//  Created by Noah Albrock on 01/11/2025.
//

import Foundation
import SwiftUI

enum ShaderTestCanvasType {
    case rectangle
    case circle
}

class ShaderTest<Label: View>: Identifiable {
    var id: UUID
    var shader: Shader
    var effectType: Shader.UsageType
    var canvasType: ShaderTestCanvasType
    var label: Label
    
    init(
        _ shader: Shader,
        effectType: Shader.UsageType = .colorEffect,
        canvasType: ShaderTestCanvasType = .rectangle,
        @ViewBuilder _ label: () -> Label,
        
    ) {
        self.id = UUID()
        self.shader = shader
        self.effectType = effectType
        self.canvasType = canvasType
        self.label = label()
        
        // pre compile the shaders in the background, if we can
        if #available(iOS 18, *) {
            Task {
                try? await self.shader.compile(as: self.effectType)
            }
        }
    }
}
