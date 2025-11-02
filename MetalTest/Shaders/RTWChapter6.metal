//
//  RTW_Chapter6.metal
//  MetalTest
//
//  Created by Noah Albrock on 02/11/2025.
//

#include <metal_stdlib>
using namespace metal;

#include "Utility.metal"

// MARK: - hitSphere
float RTW6_hitSphere(const thread float3& center, float radius, const thread Ray& r) {
    float3 oc = center - r.origin();
    auto a = length_squared(r.direction());
    auto h = dot(r.direction(), oc);
    auto c = length_squared(oc) - radius*radius;
    auto discriminant = h*h - a*c;
    
    if (discriminant < 0) {
        return -1.0;
    } else {
        return (h - sqrt(discriminant)) / a;
    }
}

// MARK: - rayColor
half4 RTW6_rayColor(const thread Ray& r) {
    auto t = RTW6_hitSphere(float3(0, 0, -1), 0.5, r);
    if (t > 0.0) {
        float3 N = normalize(r.at(t) - float3(0, 0, -1));
        auto color = 0.5*float3(N.x+1, N.y+1, N.x+1);
        return half4(color.r, color.g, color.b, 1);
    }
    
    float3 unitDirection = normalize(r.direction());
    auto a = 0.5*(unitDirection.y + 1.0);
    auto color = (1.0-a)*float3(1) + a*float3(0.5, 0.7, 1.0);
    return half4(color.r, color.g, color.b, 1);
}

// MARK: - Shader
[[ stitchable ]] half4 RTW6_Normals(float2 position, half4 currentColor, float2 size) {
    Utility utilities = Utility(size);
    
    // --- Render --- //
    
    auto pixelCenter = utilities.pixel00Loc
                     + (position.x * utilities.pixelDeltaU)
                     + (position.y * utilities.pixelDeltaV);
    auto rayDirection = pixelCenter - utilities.cameraCenter;
    Ray r(utilities.cameraCenter, rayDirection);
    
    half4 pixelColor = RTW6_rayColor(r);
    pixelColor.a = currentColor.a;
    return pixelColor;
}
