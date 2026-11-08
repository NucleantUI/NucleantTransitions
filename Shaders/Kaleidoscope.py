"""The view folded into a turning kaleidoscope that opens out into it.

`segments` mirrored wedges round the centre."""
from pyshader import *
from common import aspect


def main(uv: float2, resolution: float2, progress: float, segments: float) -> float4:
    t = clamp(progress, 0.0, 1.0)
    away = 1.0 - t
    scale = aspect(resolution)
    p = (uv - float2(0.5)) * scale
    radius = length(p)
    angle = atan(p.y, p.x) + away * 2.0
    wedge = 2.0 * PI / max(segments, 2.0)
    folded = abs(mod(angle, wedge) - wedge * 0.5)
    q = float2(cos(folded), sin(folded)) * radius / scale + float2(0.5)
    mixed = mix(layer(q), layer(uv), smoothstep(0.35, 1.0, t))
    return mixed * smoothstep(0.0, 0.4, t)
