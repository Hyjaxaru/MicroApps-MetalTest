//
//  Utility.metal
//  MetalTest
//
//  Created by Noah Albrock on 02/11/2025.
//

#include <metal_stdlib>
using namespace metal;

// MARK: - Utility
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

// MARK: - Ray
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
