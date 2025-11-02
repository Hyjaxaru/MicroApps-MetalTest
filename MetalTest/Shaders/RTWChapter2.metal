//
//  RTWChapter2.metal
//  MetalTest
//
//  Created by Noah Albrock on 01/11/2025.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]] half4 RTW2_ColorTest(float2 position, half4 currentColor, float2 size) {
    auto r = float(position.x) / (size.x-1);
    auto g = float(position.y) / (size.y-1);
    auto b = 0.0;
    
    return half4(r, g, b, currentColor.a);
}


