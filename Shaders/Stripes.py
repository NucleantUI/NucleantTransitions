"""Strips of the view sliding in from alternate sides, one after another.

`count` strips, level ones."""
from pyshader import *
from common import inside


def main(uv: float2, progress: float, count: float) -> float4:
    t = clamp(progress, 0.0, 1.0)
    n = max(count, 1.0)
    row = floor((1.0 - uv.y) * n)
    local = clamp(t * 1.6 - row / n * 0.6, 0.0, 1.0)
    away = 1.0 - local
    side = mod(row, 2.0) * 2.0 - 1.0
    p = uv + float2(side * away * away * (3.0 - 2.0 * away), 0.0)
    return layer(p) * inside(p)
