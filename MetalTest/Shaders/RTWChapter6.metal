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
bool hitSphere(const thread float3& center, float radius, const thread Ray& r) {
    float3 oc = center - r.origin();
    auto a = dot(r.direction(), r.direction());
    auto b = -2.0 * dot(r.direction(), oc);
    auto c = dot(oc, oc) - radius*radius;
    auto discriminant = b*b - 4*a*c;
    return (discriminant >= 0);
}

// MARK: - rayColor
half4 rayColor(const thread Ray& r) {
    if (hitSphere(float3(0, 0, -2), 0.5, r))
        return half4(1, 0, 0, 1);
    
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
    
    half4 pixelColor = rayColor(r);
    pixelColor.a = currentColor.a;
    return pixelColor;
}
