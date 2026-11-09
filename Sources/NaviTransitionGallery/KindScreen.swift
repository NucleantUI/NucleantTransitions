//
//  KindScreen.swift
//  NaviTransitionGallery
//
//  The screen a transition plays in: full of colour and detail, so the
//  shader has something to work on, and a link on to the next transition.
//

import NucleantUI

@View
struct KindScreen {
    let kind: NaviKind

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                Text(kind.title)
                    .font(.system(size: 44, weight: .bold))
                Text("This screen came in through \(kind.code). Go back, and it leaves the same way, backwards.")
                    .font(.system(size: 16))
                    .foregroundStyle(Color.white.opacity(0.85))
                HStack(spacing: 12) {
                    ForEach(0..<4, id: \.self) { index in
                        Swatch(index: index)
                    }
                }
                NavigationLink(value: kind.next) {
                    HStack {
                        Text("Next: \(kind.next.title)")
                            .font(.system(size: 16, weight: .semibold))
                        Spacer()
                        Text("›")
                            .font(.system(size: 22))
                    }
                    .padding(16)
                    .background(Color.white.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .foregroundStyle(Color.white)
            .padding(32)
        }
        .background(kind.color)
        .navigationTitle(kind.title)
    }
}

/// A card of stripes in shades of white, for the shader to bend and break.
@View
private struct Swatch {
    let index: Int

    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<6, id: \.self) { row in
                Color.white.opacity(Double((row + index) % 3 + 1) * 0.12)
            }
        }
        .frame(height: 120)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
