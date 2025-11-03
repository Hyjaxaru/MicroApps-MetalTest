//
//  ContentView.swift
//  MetalTest
//
//  Created by Noah Albrock on 01/11/2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        // MacOS always uses the sidebar version
        // so we can control it's UI through the compiler
        #if os(macOS)
        SidebarTabContentView()
        #else

        // both iOS and iPadOS fall under the os(iOS) compiler flag
        // so we need to decide their UI at runtime
        if horizontalSizeClass != .compact {
            // iPadOS should use the sidebar version
            SidebarTabContentView()
        } else {
            // iOS devices should use a better formatted TabView
            // that acts more like folders
            BottomTabContentView()
        }
        #endif
    }
}

#Preview {
    ContentView()
}
