"""Squares growing out of a checkerboard: the dark squares first, then the
light ones.

`cells` squares along the shorter side."""
from pyshader import *
from common import aspect


def main(uv: float2, resolution: float2, progress: float, cells: float) -> float4:
    t = clamp(progress, 0.0, 1.0)
    p = uv * aspect(resolution) * max(cells, 1.0)
    cell = floor(p)
    parity = mod(cell.x + cell.y, 2.0)
    local = max(abs(fract(p.x) - 0.5), abs(fract(p.y) - 0.5)) * 2.0
    grown = clamp((t - parity * 0.45) / 0.55, 0.0, 1.0)
    shown = 1.0 - smoothstep(grown - 0.04, grown, local) if grown < 1.0 else 1.0
    return layer(uv) * shown
