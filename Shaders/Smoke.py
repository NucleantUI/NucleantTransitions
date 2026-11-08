"""The view gathering out of drifting smoke."""
from pyshader import *
from common import aspect
from noise import fbm


def main(uv: float2, resolution: float2, progress: float) -> float4:
    t = clamp(progress, 0.0, 1.0)
    away = 1.0 - t
    q = uv * aspect(resolution) * 3.0
    drift = float2(fbm(q + float2(0.0, t * 2.0)), fbm(q + float2(5.2, 1.3 - t * 2.0))) - float2(0.5)
    p = uv + drift * 0.25 * away
    n = fbm(q * 1.5 + drift * 2.0)
    shown = smoothstep(n - 0.3, n, t * 1.3)
    return layer(p) * shown
