"""A grid of dots swelling outward from `center` until they cover the view.

`size` is the dot pitch, in pixels."""
from pyshader import *
from common import unit_to_uv


def main(uv: float2, resolution: float2, progress: float, size: float, center: float2) -> float4:
    t = clamp(progress, 0.0, 1.0)
    pixel = uv * resolution
    pitch = max(size, 2.0)
    middle = (floor(pixel / pitch) + 0.5) * pitch
    c = unit_to_uv(center) * resolution
    far = length(max(c, resolution - c))
    late = distance(middle, c) / far * 0.6
    grown = clamp((t - late) / 0.4, 0.0, 1.0)
    radius = grown * 0.75 * pitch
    shown = 1.0 - smoothstep(radius - 1.0, radius, length(pixel - middle)) if grown < 1.0 else 1.0
    return layer(uv) * shown
