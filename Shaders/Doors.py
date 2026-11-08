"""Two halves of the view sliding in from either side and meeting in the
middle.

`vertical` 1 for halves meeting top and bottom, 0 for left and right."""
from pyshader import *


def main(uv: float2, progress: float, vertical: float) -> float4:
    t = clamp(progress, 0.0, 1.0)
    away = 1.0 - t
    shift = 0.5 * away * away * (3.0 - 2.0 * away)
    upright = step(0.5, vertical)
    along = mix(uv.x, uv.y, upright)
    side = step(0.5, along)
    source_along = along + shift * (side * 2.0 - 1.0)
    # Each half stays on its own side of the seam.
    on_side = mix(step(source_along, 0.5), step(0.5, source_along), side)
    p = float2(mix(source_along, uv.x, upright), mix(uv.y, source_along, upright))
    return layer(p) * on_side
