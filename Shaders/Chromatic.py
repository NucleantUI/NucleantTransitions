"""The view's colour channels flying apart from the centre and coming back
together.

`strength` is how far they spread at the start, as a fraction of the
view's size."""
from pyshader import *
from common import inside


def main(uv: float2, progress: float, strength: float) -> float4:
    t = clamp(progress, 0.0, 1.0)
    away = 1.0 - t
    d = (uv - float2(0.5)) * strength * away * away * 2.0
    red = layer(uv + d)
    green = layer(uv)
    blue = layer(uv - d)
    color = float4(red.x * inside(uv + d), green.y, blue.z * inside(uv - d), max(max(red.w * inside(uv + d), green.w), blue.w * inside(uv - d)))
    return color * smoothstep(0.0, 0.6, t)
