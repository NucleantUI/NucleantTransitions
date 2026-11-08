"""A flash of `color` that fades to show the view."""
from pyshader import *


def main(uv: float2, progress: float, color: float4) -> float4:
    t = clamp(progress, 0.0, 1.0)
    flash = float4(color.xyz * color.w, color.w)
    content = layer(uv)
    seen = mix(flash, content, smoothstep(0.35, 1.0, t))
    return seen * smoothstep(0.0, 0.3, t)
