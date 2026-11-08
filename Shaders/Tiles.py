"""Square tiles fading in one by one, in no order.

`cells` tiles along the shorter side."""
from pyshader import *
from common import aspect
from noise import hash21


def main(uv: float2, resolution: float2, progress: float, cells: float) -> float4:
    t = clamp(progress, 0.0, 1.0)
    cell = floor(uv * aspect(resolution) * max(cells, 1.0))
    start = hash21(cell) * 0.7
    shown = smoothstep(start, start + 0.3, t)
    return layer(uv) * shown
