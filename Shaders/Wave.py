"""The view rolling in on waves that flatten as it settles.

`amplitude` is how far the waves push the view at the start, as a fraction
of its size."""
from pyshader import *
from common import inside


def main(uv: float2, progress: float, amplitude: float) -> float4:
    t = clamp(progress, 0.0, 1.0)
    away = 1.0 - t
    a = amplitude * away * away
    p = uv + float2(sin(uv.y * 14.0 + t * 9.0) * a, sin(uv.x * 11.0 + t * 7.0) * a * 0.6)
    return layer(p) * inside(p) * smoothstep(0.0, 0.5, t)
