#import "dependencies.typ": cetz
#import "utils.typ": get-style
#import cetz.draw: anchor, hobby, line, rotate, scope, group, set-origin, set-style, get-ctx, merge-path, bezier, bezier-through

#let center-mark(symbol: ">") = {
    (end: ((pos: 50%, symbol: symbol, fill: black, anchor: "center"), (pos: 0%, symbol: ">", scale: 0)))
}

#let variable-arrow(ratio: none) = {
    scope({
        get-ctx(ctx => {
            let style = get-style(ctx).arrow
            let ratio = ratio
            if ratio == none {
                ratio = style.ratio
            }
            let arrow-origin = (
                -ratio.at(0) * calc.cos(style.angle) * style.length,
                -ratio.at(1) * calc.sin(style.angle) * style.length,
            )
            anchor("adjust", arrow-origin)

            set-origin(arrow-origin)
            rotate(style.angle)

            if style.variant == "latex" {
                let height = 0.26
                line((0, 0), (style.length - height / 2, 0), stroke: style.stroke)
                group(name: "arrow", {
                    set-origin((style.length - height / 2, 0))
                    let width = height * 0.7
                    let tip = (height / 2, 0)
                    let side1 = (-height / 2, +width / 2)
                    let side2 = (-height / 2, -width / 2)

                    let k = (0.05, 0.14, 0.36)
                    merge-path(stroke: none, fill: style.stroke.paint, {
                        bezier(side1, tip, (-height * k.at(0), +width * k.at(1)))
                        bezier(tip, side2, (-height * k.at(0), -width * k.at(1)))
                        bezier-through(side2, (-height * k.at(2), 0), side1)
                    })
                })
            } else {
                line((0, 0), (style.length, 0), mark: ( end: ">", fill: style.stroke.paint), stroke: style.stroke)
            }
        })
    })
}

#let radiation-arrows(origin, angle: -120deg, reversed: false, length: 12pt) = {
    scope({
        let arrows-distance = 3pt
        let arrows-length = length
        let arrows-scale = 0.8

        set-origin(origin)
        set-style(stroke: 0.55pt)
        rotate(angle)
        if (reversed) {
            line((arrows-length, -arrows-distance), (0, -arrows-distance), mark: (
                start: ">",
                scale: arrows-scale,
                fill: black,
            ))
            line((arrows-length, arrows-distance), (0, arrows-distance), mark: (
                start: ">",
                scale: arrows-scale,
                fill: black,
            ))
        } else {
            line((arrows-length, -arrows-distance), (0, -arrows-distance), mark: (
                end: ">",
                scale: arrows-scale,
                fill: black,
            ))
            line((arrows-length, arrows-distance), (0, arrows-distance), mark: (
                end: ">",
                scale: arrows-scale,
                fill: black,
            ))
        }
    })
}

#let dc-sign() = {
    let width = 10pt
    let spacing = 1.5pt
    let vspace = 3pt
    let symbol-stroke = 0.55pt
    let tick-width = (width - 2 * spacing) / 3

    set-style(stroke: symbol-stroke)

    line((-width / 2, 0), (width / 2, 0))
    line((-width / 2, -vspace), (-width / 2 + tick-width, -vspace))
    line((-tick-width / 2, -vspace), (tick-width / 2, -vspace))
    line((width / 2, -vspace), (width / 2 - tick-width, -vspace))
}

#let ac-sign(size: 1) = {
    let width = 10pt * size
    let height = 4pt * size
    let symbol-stroke = 0.55pt

    set-style(stroke: symbol-stroke)

    hobby((-width / 2, 0), (-width / 4, height / 2), (width / 4, -height / 2), (width / 2, 0))
}
