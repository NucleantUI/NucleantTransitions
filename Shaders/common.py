"""What the transitions share: unit points as NucleantUI spells them, the
view's own aspect, and whether a point is on the view at all."""
from pyshader import *


def unit_to_uv(point: float2) -> float2:
    """A `UnitPoint` (y down) in the shader's y-up uv space."""
    return float2(point.x, 1.0 - point.y)


def aspect(resolution: float2) -> float2:
    """Scales uv so a unit is the same length across and down."""
    return float2(resolution.x / resolution.y, 1.0)


def inside(p: float2) -> float:
    """1 for a point on the view, 0 off it."""
    return step(0.0, p.x) * step(p.x, 1.0) * step(0.0, p.y) * step(p.y, 1.0)


def reach(c: float2, scale: float2) -> float:
    """From `c` to the farthest corner, in aspect-corrected units."""
    corner = max(abs(c), abs(float2(1.0) - c)) * scale
    return length(corner)


def ease(t: float) -> float:
    """Smooth in and out."""
    return t * t * (3.0 - 2.0 * t)
