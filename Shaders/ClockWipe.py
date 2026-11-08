"""A hand sweeping round the centre, showing the view behind it.

`start` is where the hand starts, radians clockwise from trailing as the
screen is seen."""
from pyshader import *
from common import aspect


def main(uv: float2, resolution: float2, progress: float, start: float) -> float4:
    t = clamp(progress, 0.0, 1.0)
    p = (float2(uv.x, 1.0 - uv.y) - float2(0.5)) * aspect(resolution)
    angle = atan(p.y, p.x)
    swept = fract((angle - start) / (2.0 * PI))
    shown = 1.0 - smoothstep(t - 0.004, t, swept)
    return layer(uv) * shown
