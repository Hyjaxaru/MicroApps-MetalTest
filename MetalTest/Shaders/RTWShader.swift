//
//  RTWShader.swift
//  MetalTest
//
//  Created by Noah Albrock on 02/11/2025.
//

import Foundation
import SwiftUI

class RTWShader: Identifiable {
    var id: UUID
    var title: String
    var systemImage: String
    
    var shaderFunction: ShaderFunction
    
    var label: some View {
        Label(title, systemImage: systemImage)
    }
    
    init(
        _ shaderFunction: ShaderFunction,
        title: String = "Unnamed Shader",
        systemImage: String = "questionmark"
    ) {
        self.id = UUID()
        self.title = title
        self.systemImage = systemImage
        
        self.shaderFunction = shaderFunction
    }
}
