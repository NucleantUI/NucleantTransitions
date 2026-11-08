"""The view developing like a photograph: dark and grey first, its colour
and light coming up."""
from pyshader import *


def main(uv: float2, progress: float) -> float4:
    t = clamp(progress, 0.0, 1.0)
    color = layer(uv)
    grey = float3(dot(color.xyz, float3(0.299, 0.587, 0.114)))
    tinted = mix(grey * float3(1.05, 0.95, 0.8), color.xyz, smoothstep(0.4, 1.0, t))
    light = smoothstep(0.0, 0.7, t)
    return float4(tinted * light, color.w) * smoothstep(0.0, 0.25, t)
