//
//  Edge+Travel.swift
//  NucleantTransitions
//
//  Which way something coming in through an edge travels, as the shaders
//  take it.
//

import NucleantUI

extension Edge {

    /// The way something entering through this edge travels, clockwise
    /// from trailing as the screen is seen.
    var inward: Angle {
        switch self {
        case .leading:  return .zero
        case .top:      return .degrees(90)
        case .trailing: return .degrees(180)
        case .bottom:   return .degrees(-90)
        }
    }

    /// The same as a unit vector, y down.
    var travel: Float2 {
        switch self {
        case .leading:  return Float2(1, 0)
        case .top:      return Float2(0, 1)
        case .trailing: return Float2(-1, 0)
        case .bottom:   return Float2(0, -1)
        }
    }
}
