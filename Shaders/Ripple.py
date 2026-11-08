"""A circle that grows from `center` until it covers the view, the view
shown inside it and rippling just behind its rim.

`progress` is 0 with nothing shown and 1 with all of it; `center` is a unit
point, y down, as a `UnitPoint` is."""
from pyshader import *


def main(uv: float2, resolution: float2, progress: float, center: float2) -> float4:
    t = clamp(progress, 0.0, 1.0)
    aspect = resolution.x / resolution.y
    scale = float2(aspect, 1.0)
    c = float2(center.x, 1.0 - center.y)

    # Far enough to clear the corner farthest from the centre.
    corner = max(abs(c), abs(float2(1.0) - c)) * scale
    reach = length(corner) + 0.08
    radius = t * reach

    d = (uv - c) * scale
    dist = length(d)
    edge = dist - radius

    # Rings travelling just inside the rim, settling as the circle grows.
    rings = sin(edge * 70.0) * exp(-abs(edge) * 14.0) * 0.025 * (1.0 - t)
    direction = d / max(dist, 0.0001)
    offset = direction * rings / scale

    inside = 1.0 - smoothstep(-0.006, 0.006, edge)
    return layer(uv + offset) * inside
