"""The view rushing in from far off, streaked towards `center`."""
from pyshader import *
from common import unit_to_uv, inside


def main(uv: float2, progress: float, center: float2) -> float4:
    t = clamp(progress, 0.0, 1.0)
    away = 1.0 - t
    c = unit_to_uv(center)
    zoom = mix(1.0, 3.0, away * away)
    base = c + (uv - c) * zoom
    streak = (uv - c) * 0.25 * away
    total = float4(0.0)
    for i in range(12):
        p = base - streak * (float(i) / 11.0)
        total += layer(p) * inside(p)
    return total / 12.0 * smoothstep(0.0, 0.5, t)
