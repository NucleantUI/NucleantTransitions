//
//  Stage.swift
//  TransitionGallery
//
//  The card showing, and the buttons that step through the deck. Each card
//  arrives with the slideshow's transition; a click on it brings on the
//  next from the point clicked.
//

import NucleantUI

@View
struct Stage {
    let slideshow: Slideshow

    var body: some View {
        let slideshow = self.slideshow
        VStack(spacing: 18) {
            GeometryReader { proxy in
                ZStack {
                    ForEach([slideshow.slide]) { slide in
                        Card(slide: slide)
                            .transition(slideshow.transition)
                    }
                }
                .frame(width: proxy.size.width, height: proxy.size.height)
                .onTapGesture { location in
                    let size = proxy.size
                    guard size.width > 0, size.height > 0 else { return }
                    slideshow.next(from: UnitPoint(x: location.x / size.width, y: location.y / size.height))
                }
            }
            .frame(maxWidth: 820, maxHeight: 520)

            HStack(spacing: 14) {
                Button("Previous") { slideshow.previous() }
                Text("\(slideshow.index + 1) of \(slideshow.slides.count)")
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundStyle(.secondary)
                Button("Next") { slideshow.next() }
            }
        }
        .padding(32)
        .onKeyPress(.rightArrow) {
            slideshow.next()
            return .handled
        }
        .onKeyPress(.leftArrow) {
            slideshow.previous()
            return .handled
        }
    }
}

/// A card: a gradient with rings of light, under its title.
@View
struct Card {
    let slide: Slide

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 22)
                .fill(.linearGradient(colors: slide.colors, startPoint: .bottomLeading, endPoint: .topTrailing))
            ZStack {
                Circle()
                    .stroke(Color.white.opacity(0.18), lineWidth: 2)
                    .frame(width: 340, height: 340)
                Circle()
                    .stroke(Color.white.opacity(0.12), lineWidth: 2)
                    .frame(width: 220, height: 220)
                Circle()
                    .fill(slide.colors[2].opacity(0.55))
                    .frame(width: 110, height: 110)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(28)
            VStack(alignment: .leading, spacing: 6) {
                Text(slide.title)
                    .font(.system(size: 54, weight: .bold))
                    .foregroundStyle(.white)
                Text(slide.caption)
                    .font(.system(size: 18))
                    .foregroundStyle(Color.white.opacity(0.8))
            }
            .padding(36)
        }
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }
}
