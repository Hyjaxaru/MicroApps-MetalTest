//
//  BottomTabContentView.swift
//  MetalTest
//
//  Created by Noah Albrock on 03/11/2025.
//

import SwiftUI

struct BottomTabContentView: View {
    var body: some View {
        TabView {
            // shader tests
            Tab("Shader Tests", systemImage: "square") {
                NavigationStack {
                    List {
                        Section {
                            TabView {
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
                            .tabViewStyle(.page)
                        }
                        .listRowInsets(EdgeInsets())
                        .frame(height: 200)
                        
                        Section {
                            ForEach(ShaderTestLibrary.shaderTests) { shader in
                                NavigationLink {
                                    ShaderView(
                                        shader.shader,
                                        effectType: shader.effectType,
                                        canvasType: shader.canvasType
                                    )
                                } label: { shader.label }
                            }
                        }
                    }
                    .navigationTitle("Shader Tests")
                }
            }
            
            // rt weekend
            Tab("RTWeekend", systemImage: "circle") {
                NavigationStack {
                    List {
                        Section {
                            TabView {
                                ForEach(ShaderTestLibrary.shaderTestsRTW) { shader in
                                    Tab(shader.title, systemImage: shader.systemImage) {
                                        ShaderViewRTW(shader.shaderFunction)
                                    }
                                }
                            }
                            .tabViewStyle(.page)
                        }
                        .listRowInsets(EdgeInsets())
                        .frame(height: 200)
                        
                        Section {
                            ForEach(ShaderTestLibrary.shaderTestsRTW) { shader in
                                NavigationLink {
                                    ShaderViewRTW(shader.shaderFunction)
                                } label: { shader.label }
                            }
                        }
                    }
                    .navigationTitle("RTWeekend")
                }
            }
            
            // my credit
            Tab("About", systemImage: "info.circle") {
                AboutAppView()
            }
        }
    }
}

#Preview {
    BottomTabContentView()
}
