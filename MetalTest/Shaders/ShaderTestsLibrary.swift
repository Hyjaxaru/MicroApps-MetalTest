//
//  Shaders.swift
//  MetalTest
//
//  Created by Noah Albrock on 03/11/2025.
//

import Foundation
import SwiftUI

class ShaderTestLibrary {
    // MARK: - Shader Tests
    static let shaderTests: [ShaderTest] = [
        // Checkered
        ShaderTest(ShaderLibrary.checkerboard(.float(10), .color(Color.accentColor))) {
            Label("Checkered", systemImage: "rectangle.pattern.checkered")
        },
        
        // Noise
        ShaderTest(ShaderLibrary.noise()) {
            Label("Noise", systemImage: "mountain.2")
        },
        
        // Pixellate
        ShaderTest(ShaderLibrary.pixellate(.float(10)),
                   effectType: .layerEffect, canvasType: .circle) {
            Label("Pixellate", systemImage: "circle.bottomrighthalf.pattern.checkered")
        },
    ]
    
    // MARK: - RTWeekend Shader Tests
    static let shaderTestsRTW: [RTWShader] = [
        // Chapter 2
        RTWShader(
            ShaderLibrary.RTW2_ColorTest,
            title: "Chapter 2: Drawing to a Surface",
            systemImage: "rectangle.portrait"
        ),
        // Chapter 4: Rays
        RTWShader(
            ShaderLibrary.RTW4_Rays,
            title: "Chapter 4: Rays",
            systemImage: "rays"
        ),
        // Chapter 5: Adding a Sphere
        RTWShader(
            ShaderLibrary.RTW5_Sphere,
            title: "Chapter 5: Adding a Sphere",
            systemImage: "circle"
        ),
        // Chapter 6: Surface Normals & Multiple Objects
        RTWShader(
            ShaderLibrary.RTW6_Normals,
            title: "Chapter 6: Surface Normals & Multiple Objects",
            systemImage: "rectangle.3.group"
        )
    ]
}
