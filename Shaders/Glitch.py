"""The view torn into horizontal slices that jump sideways with their colour
channels pulled apart, settling as it comes in.

`progress` is 0 with nothing shown and 1 with all of it; `strength` is how
far a slice can jump at the start, as a fraction of the width."""
from pyshader import *
from noise import hash21


def main(uv: float2, resolution: float2, progress: float, strength: float) -> float4:
    t = clamp(progress, 0.0, 1.0)
    remaining = 1.0 - t
    # The tear changes a dozen times along the way, not every frame.
    step_index = floor(t * 12.0)
    rows = 18.0 + 30.0 * hash21(float2(step_index, 7.0))
    row = floor(uv.y * rows)
    jitter = hash21(float2(row, step_index)) - 0.5
    torn = step(0.55, hash21(float2(row + 31.0, step_index)))
    shift = jitter * strength * remaining * remaining * torn

    split = 0.015 * remaining
    p = float2(uv.x + shift, uv.y)
    red = layer(p + float2(split, 0.0))
    green = layer(p)
    blue = layer(p - float2(split, 0.0))
    alpha = max(max(red.w, green.w), blue.w)
    color = float4(red.x, green.y, blue.z, alpha)
    return color * smoothstep(0.0, 0.5, t)
