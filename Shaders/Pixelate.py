"""The view in blocks that shrink to its pixels as it comes in, and grow as
it goes out, fading at the coarse end.

`progress` is 0 with nothing shown and 1 with all of it; `block` is the
largest block, in pixels."""
from pyshader import *


def main(uv: float2, resolution: float2, progress: float, block: float) -> float4:
    t = clamp(progress, 0.0, 1.0)
    remaining = 1.0 - t
    size = max(1.0, 1.0 + remaining * remaining * block)
    cell = float2(size) / resolution
    p = (floor(uv / cell) + 0.5) * cell
    return layer(p) * smoothstep(0.0, 0.45, t)
