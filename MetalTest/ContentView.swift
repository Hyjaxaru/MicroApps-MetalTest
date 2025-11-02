//
//  ContentView.swift
//  MetalTest
//
//  Created by Noah Albrock on 01/11/2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @AppStorage("lastTabID") var lastTabID: String?
    
    @State var searchText: String = ""
    
    let shaderTests: [ShaderTest] = [
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
    
    let shaderTestsRTW: [RTWShader] = [
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
    
    var body: some View {
        TabView {
            if horizontalSizeClass != .compact {
                // shader tests
                TabSection("Shader Tests") {
                    ForEach(shaderTests) { shader in
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
                    ForEach(shaderTestsRTW) { shader in
                        Tab {
                            ShaderViewRTW(shader.shaderFunction)
                        } label: { shader.label }
                    }
                }
                
                // my credit
                Tab("About", systemImage: "info.circle") {
                    AboutAppView()
                }
            } else {
                // shader tests
                Tab("Shader Tests", systemImage: "square") {
                    NavigationStack {
                        List {
                            Section {
                                TabView {
                                    ForEach(shaderTests) { shader in
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
                                ForEach(shaderTests) { shader in
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
                                    ForEach(shaderTestsRTW) { shader in
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
                                ForEach(shaderTestsRTW) { shader in
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
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    ContentView()
}
