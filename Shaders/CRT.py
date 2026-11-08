"""An old television switching on: a bright line opens across, then out to
the whole picture, which settles from glare."""
from pyshader import *
from common import inside


def main(uv: float2, resolution: float2, progress: float) -> float4:
    t = clamp(progress, 0.0, 1.0)
    across = max(smoothstep(0.0, 0.35, t), 0.002)
    down = max(smoothstep(0.3, 0.85, t), 2.0 / resolution.y)
    p = float2(0.5 + (uv.x - 0.5) / across, 0.5 + (uv.y - 0.5) / down)
    color = layer(clamp(p, float2(0.0), float2(1.0))) * inside(p)
    glare = (1.0 - smoothstep(0.3, 1.0, t)) * 2.5
    lit = float4(min(color.xyz * (1.0 + glare) + float3(glare * 0.4) * color.w, float3(color.w)), color.w)
    line = (1.0 - smoothstep(0.25, 0.5, t)) * inside(p)
    return mix(lit, float4(1.0) * inside(p), line * (1.0 - down))
