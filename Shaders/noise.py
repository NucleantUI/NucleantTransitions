"""Repeatable randomness for the transitions: the same point always gives
the same value, so a view dissolves the same way every time."""
from pyshader import *


def hash21(p: float2) -> float:
    """A value in 0...1 for each point, scattered."""
    q = fract(p * float2(123.34, 456.21))
    q += dot(q, q + 45.32)
    return fract(q.x * q.y)


def value_noise(p: float2) -> float:
    """Smooth noise in 0...1: hashes at the lattice corners, blended."""
    i = floor(p)
    f = fract(p)
    u = f * f * (3.0 - 2.0 * f)
    a = hash21(i)
    b = hash21(i + float2(1.0, 0.0))
    c = hash21(i + float2(0.0, 1.0))
    d = hash21(i + float2(1.0, 1.0))
    return mix(mix(a, b, u.x), mix(c, d, u.x), u.y)


def fbm(p: float2) -> float:
    """Four octaves of value noise, in 0...1."""
    total = 0.0
    amplitude = 0.5
    q = p
    for _ in range(4):
        total += amplitude * value_noise(q)
        q *= 2.0
        amplitude *= 0.5
    return total / 0.9375


def hash22(p: float2) -> float2:
    """Two values in 0...1 for each point, scattered."""
    return float2(hash21(p), hash21(p + float2(17.13, 3.71)))


def voronoi_seed(p: float2) -> float2:
    """The seed of the cell `p` falls in: one random point per unit square,
    the nearest of the nine around `p` winning."""
    cell = floor(p)
    best = float2(0.0)
    nearest = 100.0
    for j in range(-1, 2):
        for i in range(-1, 2):
            g = cell + float2(float(i), float(j))
            seed = g + hash22(g)
            d = distance(seed, p)
            if d < nearest:
                nearest = d
                best = seed
    return best
