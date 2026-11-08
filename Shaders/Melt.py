"""The view dripping down into place, column by column."""
from pyshader import *
from noise import value_noise


def main(uv: float2, progress: float) -> float4:
    t = clamp(progress, 0.0, 1.0)
    late = value_noise(float2(uv.x * 14.0, 0.5)) * 0.5
    local = clamp((t - late) / (1.0 - late * 0.999), 0.0, 1.0)
    away = 1.0 - local
    drop = away * away * (3.0 - 2.0 * away)
    p = float2(uv.x, uv.y - drop)
    return layer(p) * step(0.0, p.y)
