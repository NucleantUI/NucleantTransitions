//
//  TransitionGrid.swift
//  NaviTransitionGallery
//
//  The front screen: a tile for every transition, each a link that pushes
//  that transition's screen.
//

import NucleantUI

@View
struct TransitionGrid {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Navigation transitions")
                        .font(.system(size: 30, weight: .bold))
                    Text("\(NaviKind.allCases.count) shaders, each playing a screen in and, popped, back out.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 200), spacing: 12)], spacing: 12) {
                    ForEach(NaviKind.allCases) { kind in
                        NavigationLink(value: kind) {
                            KindTile(kind: kind)
                        }
                    }
                }
            }
            .padding(24)
        }
        .navigationTitle("Gallery")
    }
}

@View
private struct KindTile {
    let kind: NaviKind

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(kind.title)
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(Color.white)
            Text(".\(kind.rawValue)")
                .font(.system(size: 11, design: .monospaced))
                .foregroundStyle(Color.white.opacity(0.75))
        }
        .padding(14)
        .frame(maxWidth: .infinity, minHeight: 84, alignment: .topLeading)
        .background(kind.color)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
