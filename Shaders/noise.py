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
