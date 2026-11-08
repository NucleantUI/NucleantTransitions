"""The view sliding in from an edge, smeared along the way it moves.

`direction` is the way it travels, y down."""
from pyshader import *
from common import inside


def main(uv: float2, progress: float, direction: float2) -> float4:
    t = clamp(progress, 0.0, 1.0)
    away = 1.0 - t
    d = float2(direction.x, -direction.y)
    eased = away * away * (3.0 - 2.0 * away)
    base = uv + d * eased
    smear = d * 0.18 * sin(t * PI)
    total = float4(0.0)
    for i in range(10):
        p = base + smear * (float(i) / 9.0 - 0.5)
        total += layer(p) * inside(p)
    return total / 10.0
