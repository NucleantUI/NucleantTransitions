"""The view eaten away by noise, the edge of what is left glowing.

`progress` is 0 with nothing shown and 1 with all of it; `edge_color` is the
glow, and its alpha how strongly it shows."""
from pyshader import *
from noise import fbm

WIDTH = 0.08


def main(uv: float2, resolution: float2, progress: float, edge_color: float4) -> float4:
    t = clamp(progress, 0.0, 1.0)
    aspect = resolution.x / resolution.y
    n = fbm(uv * float2(aspect, 1.0) * 6.0)

    # The threshold sweeps from below every value to above every one.
    s = t * (1.0 + WIDTH) - WIDTH
    shown = 1.0 - smoothstep(s, s + WIDTH * 0.35, n)
    band = clamp((n - s) / WIDTH, 0.0, 1.0)
    glow = (1.0 - abs(band * 2.0 - 1.0)) * step(n, s + WIDTH) * step(s, n)

    color = layer(uv)
    rim = float4(edge_color.xyz, 1.0) * edge_color.w * glow * color.w
    return color * shown + rim * (1.0 - t)
