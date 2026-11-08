"""Ink spreading from `center` with a ragged, soaking edge until it covers
the view."""
from pyshader import *
from common import unit_to_uv, aspect, reach
from noise import fbm


def main(uv: float2, resolution: float2, progress: float, center: float2) -> float4:
    t = clamp(progress, 0.0, 1.0)
    scale = aspect(resolution)
    c = unit_to_uv(center)
    d = (uv - c) * scale
    ragged = (fbm(d * 5.0 + c * 7.0) - 0.5) * 0.35
    edge = length(d) + ragged - t * (reach(c, scale) + 0.25)
    return layer(uv) * (1.0 - smoothstep(-0.03, 0.0, edge))
