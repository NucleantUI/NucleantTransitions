"""The view coming into focus.

`radius` is how blurred it starts, in pixels."""
from pyshader import *


def main(uv: float2, resolution: float2, progress: float, radius: float) -> float4:
    t = clamp(progress, 0.0, 1.0)
    away = 1.0 - t
    r = radius * away * away / resolution
    total = float4(0.0)
    weight = 0.0
    for j in range(-3, 4):
        for i in range(-3, 4):
            o = float2(float(i), float(j)) / 3.0
            w = exp(-dot(o, o) * 2.0)
            total += layer(uv + o * r) * w
            weight += w
    return total / weight * smoothstep(0.0, 0.5, t)
