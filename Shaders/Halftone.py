"""Halftone dots swelling until they merge into the view.

`size` is the dot pitch, in pixels."""
from pyshader import *


def main(uv: float2, resolution: float2, progress: float, size: float) -> float4:
    t = clamp(progress, 0.0, 1.0)
    pixel = uv * resolution
    pitch = max(size, 2.0)
    cell = floor(pixel / pitch)
    middle = (cell + 0.5) * pitch
    color = layer(middle / resolution)
    radius = t * 0.75 * pitch * (0.4 + 0.6 * dot(color.xyz, float3(0.299, 0.587, 0.114)) + 0.6 * t)
    dot_mask = 1.0 - smoothstep(radius - 1.0, radius, length(pixel - middle))
    return mix(color * dot_mask, layer(uv), smoothstep(0.75, 1.0, t))
