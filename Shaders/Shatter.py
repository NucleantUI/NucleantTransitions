"""Shards flying in from around the view and settling into it, each in its
own time.

`cells` shards along the shorter side, roughly."""
from pyshader import *
from common import aspect, inside
from noise import hash21, voronoi_seed


def main(uv: float2, resolution: float2, progress: float, cells: float) -> float4:
    t = clamp(progress, 0.0, 1.0)
    scale = aspect(resolution)
    p = uv * scale * max(cells, 1.0)
    seed = voronoi_seed(p)
    start = hash21(seed) * 0.5
    settled = smoothstep(start, start + 0.5, t)
    away = 1.0 - settled
    # Each shard comes from outward of the middle, and turns as it comes.
    centre = float2(0.5) * scale * max(cells, 1.0)
    outward = normalize(seed - centre + float2(0.0001))
    angle = away * (hash21(seed + 3.0) - 0.5) * 2.5
    local = p - seed
    s = sin(angle)
    k = cos(angle)
    turned = float2(local.x * k - local.y * s, local.x * s + local.y * k)
    source = (seed + turned - outward * away * 2.5) / (scale * max(cells, 1.0))
    return layer(source) * inside(source) * smoothstep(0.0, 0.6, settled)
