//
//  Sidebar.swift
//  TransitionGallery
//
//  The transitions to pick from, in a list of their own that scrolls; below
//  it, staying in view, what the chosen one does, how long it takes, what
//  the card being replaced does, and the code for it all.
//

import Foundation
import NucleantUI

@View
struct Sidebar {
    @Bindable var slideshow: Slideshow

    var body: some View {
        let slideshow = self.slideshow
        VStack(alignment: .leading, spacing: 0) {
            Text("Transitions")
                .font(.system(size: 15, weight: .semibold))
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 6)

            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 2) {
                    ForEach(TransitionKind.Group.allCases) { group in
                        Text(group.rawValue.uppercased())
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(.secondary)
                            .padding(.horizontal, 18)
                            .padding(.top, 10)
                            .padding(.bottom, 4)
                        ForEach(TransitionKind.from(group)) { kind in
                            SidebarRow(kind: kind, isSelected: slideshow.kind == kind) {
                                slideshow.kind = kind
                                slideshow.next()
                            }
                        }
                    }
                }
                .padding(.bottom, 8)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            .frame(maxHeight: .infinity)

            Divider()
            VStack(alignment: .leading, spacing: 12) {
                Text(slideshow.kind.summary)
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)

                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("Duration")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(String(format: "%.1f s", slideshow.duration))
                            .font(.system(size: 12, design: .monospaced))
                            .foregroundStyle(.secondary)
                    }
                    Slider(value: $slideshow.duration, in: 0.3...3, step: 0.1, label: { Text("Duration") }, onEditingChanged: { _ in })
                        .labelsHidden()
                }
                Toggle("Fade out the old card", isOn: $slideshow.fadesOut)

                Text(slideshow.code)
                    .font(.system(size: 10, design: .monospaced))
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(RoundedRectangle(cornerRadius: 8).fill(.fill))
            }
            .padding(16)
        }
    }
}

@View
struct SidebarRow {
    let kind: TransitionKind
    let isSelected: Bool
    let choose: () -> Void
    @State private var isHovered = false

    var body: some View {
        Text(kind.name)
            .font(.system(size: 13, weight: isSelected ? .semibold : .regular))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 10)
            .padding(.vertical, 7)
            .background(
                RoundedRectangle(cornerRadius: 7)
                    .fill(isSelected ? .color(Theme.accent.opacity(0.18)) : (isHovered ? .fill : .color(.clear)))
            )
            .padding(.horizontal, 8)
            .onHover { isHovered = $0 }
            .onTapGesture { choose() }
    }
}
