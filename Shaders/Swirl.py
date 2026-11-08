"""The view wound round its centre and shrunk away into it.

`progress` is 0 with nothing shown and 1 with all of it; `turns` is how far
the middle is wound at the start, in whole turns."""
from pyshader import *


def main(uv: float2, resolution: float2, progress: float, turns: float) -> float4:
    t = clamp(progress, 0.0, 1.0)
    aspect = resolution.x / resolution.y
    scale = float2(aspect, 1.0)
    remaining = 1.0 - t

    d = (uv - float2(0.5)) * scale
    dist = length(d)
    radius = length(scale) * 0.5
    falloff = max(0.0, 1.0 - dist / radius)
    angle = remaining * turns * 6.2831853 * falloff * falloff
    s = sin(angle)
    k = cos(angle)
    turned = float2(d.x * k - d.y * s, d.x * s + d.y * k)

    # Shrink towards the centre as it winds.
    zoom = mix(1.0, 0.15, remaining * remaining)
    p = turned / zoom / scale + float2(0.5)
    outside = step(0.0, p.x) * step(p.x, 1.0) * step(0.0, p.y) * step(p.y, 1.0)
    return layer(p) * outside * smoothstep(0.0, 0.6, t)
