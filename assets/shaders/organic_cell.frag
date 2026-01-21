#include <flutter/runtime_effect.glsl>

uniform float uTime;
uniform vec2 uSize;
uniform vec3 uColor1; // Центр (Свет)
uniform vec3 uColor2; // Средний слой (Тепло)
uniform vec3 uColor3; // Края (Растворение)

out vec4 fragColor;

void main() {
    vec2 uv = FlutterFragCoord().xy / uSize;
    vec2 center = vec2(0.5, 0.5);

    if (uSize.x > uSize.y) {
        uv.x = (uv.x - 0.5) * (uSize.x / uSize.y) + 0.5;
    } else {
        uv.y = (uv.y - 0.5) * (uSize.y / uSize.x) + 0.5;
    }

    float dist = length(uv - center);
    float breathe = sin(uTime * 0.8) * 0.05 + 0.95;

    float coreRadius = 0.25 * breathe;
    float coreMask = smoothstep(coreRadius + 0.2, coreRadius - 0.1, dist);

    float auraRadius = 0.45 * breathe;
    float auraMask = smoothstep(auraRadius + 0.3, auraRadius - 0.1, dist);

    float rings = sin(dist * 20.0 - uTime * 0.5);
    rings = smoothstep(0.0, 1.0, rings) * 0.05;

    vec3 color = uColor3;
    color = mix(color, uColor2, auraMask);
    color = mix(color, uColor1, coreMask);
    color += rings * uColor1 * auraMask;

    float alpha = auraMask;

    fragColor = vec4(color * alpha, alpha);
}