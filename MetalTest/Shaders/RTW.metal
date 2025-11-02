//
//  RTW.metal
//  MetalTest
//
//  Created by Noah Albrock on 01/11/2025.
//

#include <metal_stdlib>
using namespace metal;


// MARK: - Classes

class Utility {
public:
    Utility(const thread float2& size) {
        _setup(size);
    }
    
    float focalLength;
    float2 viewportSize;
    float3 cameraCenter;
    
    float3 viewportU;
    float3 viewportV;
    
    float3 pixelDeltaU;
    float3 pixelDeltaV;
    
    float3 viewportUpperLeft;
    float3 pixel00Loc;
    
private:
    void _setup(const thread float2& size) {
        // --- Camera --- //
        
        focalLength = 1.0;
        viewportSize.y = 2.0;
        viewportSize.x = viewportSize.y * (float(size.x)/size.y);
        cameraCenter = float3(0);
    
        // calculate the vectors across the horizontal and down the viewport edges
        viewportU = float3(viewportSize.x, 0, 0);
        viewportV = float3(0, -viewportSize.y, 0);
    
        // calculate the horizontal and vertical delta vectors from pixel to pixel
        pixelDeltaU = viewportU / size.x;
        pixelDeltaV = viewportV / size.y;
    
        // calculate the location of the upper left pixel
        viewportUpperLeft = cameraCenter
                               - float3(0, 0, focalLength)
                               - viewportU/2
                               - viewportV/2;
        pixel00Loc = viewportUpperLeft + 0.5 * (pixelDeltaU + pixelDeltaV);
    }
};

class Ray {
public:
    Ray () {}
    
    Ray(const thread float3& origin, const thread float3& direction) : orig(origin), dir(direction) {}
    
    const thread float3& origin() const { return orig; }
    const thread float3& direction() const { return dir; }
    
    float3 at(float3 t) const {
        return orig + t*dir;
    }
    
private:
    float3 orig;
    float3 dir;
};


// MARK: - Helper Functions
half4 float3tohalf4(const thread float3& f, const thread float& a = 1) {
    return half4(f.x, f.y, f.z, a);
}

// MARK: - Week 2

[[ stitchable ]] half4 RTW2_ColorTest(float2 position, half4 currentColor, float2 size) {
    auto r = float(position.x) / (size.x-1);
    auto g = float(position.y) / (size.y-1);
    auto b = 0.0;
    
    return half4(r, g, b, currentColor.a);
}

// MARK: - Week 4: Rays

half4 RTW4_rayColor(const thread Ray& r) {
    float3 unitDirection = normalize(r.direction());
    auto a = 0.5*(unitDirection.y + 1.0);
    auto color = (1.0-a)*float3(1) + a*float3(0.5, 0.7, 1.0);
    return float3tohalf4(color, 1);
}

[[ stitchable ]] half4 RTW4_Rays(float2 position, half4 currentColor, float2 size) {
    Utility utilities = Utility(size);
    
    // --- Render --- //
    
    auto pixelCenter = utilities.pixel00Loc
                     + (position.x * utilities.pixelDeltaU)
                     + (position.y * utilities.pixelDeltaV);
    auto rayDirection = pixelCenter - utilities.cameraCenter;
    Ray r(utilities.cameraCenter, rayDirection);
    
    half4 pixelColor = RTW4_rayColor(r);
    pixelColor.a = currentColor.a;
    return pixelColor;
}

// MARK: - Week 5: Sphere

bool RTW5_hitSphere(const thread float3& center, float radius, const thread Ray& r) {
    float3 oc = center - r.origin();
    auto a = dot(r.direction(), r.direction());
    auto b = -2.0 * dot(r.direction(), oc);
    auto c = dot(oc, oc) - radius*radius;
    auto discriminant = b*b - 4*a*c;
    return (discriminant >= 0);
}

half4 RTW5_rayColor(const thread Ray& r) {
    if (RTW5_hitSphere(float3(0, 0, -2), 0.5, r))
        return half4(1, 0, 0, 1);
    
    float3 unitDirection = normalize(r.direction());
    auto a = 0.5*(unitDirection.y + 1.0);
    auto color = (1.0-a)*float3(1) + a*float3(0.5, 0.7, 1.0);
    return float3tohalf4(color, 1);
}

[[ stitchable ]] half4 RTW5_Sphere(float2 position, half4 currentColor, float2 size) {
    Utility utilities = Utility(size);
    
    // --- Render --- //
    
    auto pixelCenter = utilities.pixel00Loc
                     + (position.x * utilities.pixelDeltaU)
                     + (position.y * utilities.pixelDeltaV);
    auto rayDirection = pixelCenter - utilities.cameraCenter;
    Ray r(utilities.cameraCenter, rayDirection);
    
    half4 pixelColor = RTW5_rayColor(r);
    pixelColor.a = currentColor.a;
    return pixelColor;
}

// MARK: - Week 6: Normals & Objects

[[ stitchable ]] half4 RTW6_Normals(float2 position, half4 currentColor, float2 size) {
    Utility utilities = Utility(size);
    
    // --- Render --- //
    
    auto pixelCenter = utilities.pixel00Loc
                     + (position.x * utilities.pixelDeltaU)
                     + (position.y * utilities.pixelDeltaV);
    auto rayDirection = pixelCenter - utilities.cameraCenter;
    Ray r(utilities.cameraCenter, rayDirection);
    
    half4 pixelColor = RTW5_rayColor(r);
    pixelColor.a = currentColor.a;
    return pixelColor;
}
