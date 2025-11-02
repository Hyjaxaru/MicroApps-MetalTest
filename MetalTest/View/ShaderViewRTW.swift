//
//  ShaderViewRTW.swift
//  MetalTest
//
//  Created by Noah Albrock on 01/11/2025.
//

import SwiftUI

struct ShaderViewRTW: View {
    var shaderFunction: ShaderFunction
    
    init(_ shaderFunction: ShaderFunction) {
        self.shaderFunction = shaderFunction
    }
    
    init(_ shader: Shader) {
        self.shaderFunction = shader.function
    }
    
    var body: some View {
        GeometryReader { geometry in
            let size = CGPoint(x: geometry.size.width, y: geometry.size.height)
            Rectangle()
                .colorEffect(shaderFunction(.float2(size)))
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ShaderViewRTW(ShaderLibrary.RTW6_Normals())
}
