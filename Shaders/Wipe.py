"""A soft edge sweeping across the view, showing it behind.

`angle` is the direction the edge travels, radians, clockwise from
trailing as the screen is seen; `feather` the edge's width, 0...1."""
from pyshader import *


def main(uv: float2, progress: float, angle: float, feather: float) -> float4:
    t = clamp(progress, 0.0, 1.0)
    direction = float2(cos(angle), -sin(angle))
    extent = 0.5 * (abs(direction.x) + abs(direction.y))
    v = dot(uv - float2(0.5), direction) / extent * 0.5 + 0.5
    f = max(feather, 0.001)
    front = t * (1.0 + f)
    shown = 1.0 - smoothstep(front - f, front, v)
    return layer(uv) * shown
