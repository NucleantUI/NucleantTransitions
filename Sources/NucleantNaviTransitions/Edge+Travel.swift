//
//  Edge+Travel.swift
//  NucleantNaviTransitions
//
//  Which way a screen coming in through an edge travels, as the shaders
//  take it.
//

import NucleantUI

extension Edge {

    /// The way something entering through this edge travels, as a unit
    /// vector, y down.
    var travel: Float2 {
        switch self {
        case .leading:  return Float2(1, 0)
        case .top:      return Float2(0, 1)
        case .trailing: return Float2(-1, 0)
        case .bottom:   return Float2(0, -1)
        }
    }
}
