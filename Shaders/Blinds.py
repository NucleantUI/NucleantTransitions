"""Slats opening together, like a blind tilted open.

`count` slats; `vertical` 1 for upright slats, 0 for level ones."""
from pyshader import *


def main(uv: float2, progress: float, count: float, vertical: float) -> float4:
    t = clamp(progress, 0.0, 1.0)
    across = mix(1.0 - uv.y, uv.x, step(0.5, vertical))
    f = fract(across * max(count, 1.0))
    shown = 1.0 - smoothstep(t - 0.02, t, f) if t < 1.0 else 1.0
    return layer(uv) * shown
