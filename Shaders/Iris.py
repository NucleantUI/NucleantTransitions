"""A circle opening from `center` until it covers the view."""
from pyshader import *
from common import unit_to_uv, aspect, reach


def main(uv: float2, resolution: float2, progress: float, center: float2) -> float4:
    t = clamp(progress, 0.0, 1.0)
    scale = aspect(resolution)
    c = unit_to_uv(center)
    edge = length((uv - c) * scale) - t * (reach(c, scale) + 0.01)
    return layer(uv) * (1.0 - smoothstep(-0.004, 0.004, edge))
