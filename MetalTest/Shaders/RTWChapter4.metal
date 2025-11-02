//
//  RTWChapter4.metal
//  MetalTest
//
//  Created by Noah Albrock on 02/11/2025.
//

#include <metal_stdlib>
using namespace metal;

#include "Utility.metal"

// MARK: - rayColor
half4 rayColor(const thread Ray& r) {
    float3 unitDirection = normalize(r.direction());
    auto a = 0.5*(unitDirection.y + 1.0);
    auto color = (1.0-a)*float3(1) + a*float3(0.5, 0.7, 1.0);
    return half4(color.r, color.g, color.b, 1);
}

// MARK: - Shader
[[ stitchable ]] half4 RTW4_Rays(float2 position, half4 currentColor, float2 size) {
    Utility utilities = Utility(size);
    
    // --- Render --- //
    
    auto pixelCenter = utilities.pixel00Loc
                     + (position.x * utilities.pixelDeltaU)
                     + (position.y * utilities.pixelDeltaV);
    auto rayDirection = pixelCenter - utilities.cameraCenter;
    Ray r(utilities.cameraCenter, rayDirection);
    
    half4 pixelColor = rayColor(r);
    pixelColor.a = currentColor.a;
    return pixelColor;
}
