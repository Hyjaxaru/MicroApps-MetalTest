//
//  SidebarTabContentView.swift
//  MetalTest
//
//  Created by Noah Albrock on 03/11/2025.
//

import SwiftUI

struct SidebarTabContentView: View {
    var body: some View {
        TabView {
            // shader tests
            TabSection("Shader Tests") {
                ForEach(ShaderTestLibrary.shaderTests) { shader in
                    Tab {
                        ShaderView(
                            shader.shader,
                            effectType: shader.effectType,
                            canvasType: shader.canvasType
                        )
                    } label: {
                        shader.label
                    }
                }
            }
            
            // rtweekend
            TabSection("RTWeekend") {
                ForEach(ShaderTestLibrary.shaderTestsRTW) { shader in
                    Tab {
                        ShaderViewRTW(shader.shaderFunction)
                    } label: { shader.label }
                }
            }
            
            // my credit
            Tab("About", systemImage: "info.circle") {
                AboutAppView()
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    SidebarTabContentView()
}
