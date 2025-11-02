//
//  AboutAppView.swift
//  MetalTest
//
//  Created by Noah Albrock on 02/11/2025.
//

import SwiftUI

struct AboutAppView: View {
    var body: some View {
        NavigationStack {
            List {
                // MARK: - Heading
                Section {
                    HStack {
                        Image(.metalLogo)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 64, height: 64)
                            .foregroundStyle(.black.gradient)
                        
                        Spacer().frame(width: 16)
//                        
                        VStack(alignment: .leading) {
                            Text("MetalTest")
                                .font(.title)
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                            Text("Hyjaxaru's MicroApps")
                        }
                        .foregroundStyle(.white)
                    }
                }
                .listRowBackground(
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [.teal, .green],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                )
                
                // MARK: - Links
                Section {
                    Link(destination: URL(string: "https://github.com/Hyjaxaru/MicroApps-MetalTest")!) {
                        Text("Source").badge("github.com")
                    }
                    
                    Link(destination: URL(string: "microapps.hyjaxaru.dev")!) {
                        Text("MicroApps").badge("hyjaxaru.dev")
                    }
                    
                    Link(destination: URL(string: "www.hyjaxaru.dev")!) {
                        Text("My Portfolio").badge("hyjaxaru.dev")
                    }
                } header: {
                    Text("Links")
                }
                
                // MARK: - About
                Section {
                    HStack(spacing: 0) {
                        Text("Made with ")
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.pink.gradient)
                        Text(" by Hyjaxaru")
                    }
                } header: {
                    Text("About")
                } footer: {
                    let year = Calendar.current.component(.year, from: Date())
                    Text("Copyright © \(String(year)) Hyjaxaru")
                }
            }
            .navigationTitle("About")
        }
    }
}

#Preview {
    AboutAppView()
}
