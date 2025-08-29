#import "dependencies.typ": cetz
#import "decorations.typ": current, flow, voltage
#import "components/node.typ": node
#import "components/wire.typ": wire
#import "utils.typ": get-style
#import "utils.typ": get-label-anchor

#let component(
    draw: none,
    label: none,
    i: none,
    f: none,
    u: none,
    n: none,
    position: 50%,
    rotate: 0deg,
    scale: 1.0,
    debug: none,
    ..params,
) = {
    let position-ratio = position
    let (uid, name, ..position) = params.pos()

    assert(position.len() in (1, 2),
        message: "accepts only 2 or 3 (for 2 nodes components only) positional arguments")
    assert(position.at(1, default: none) == none or rotate == 0deg,
        message: "cannot use rotate argument with 2 nodes")
    assert(type(name) == str,
        message: "component name must be a string")
    assert(type(scale) == float or (type(scale) == array and scale.len() == 2),
        message: "scale must be a float or an array of two floats")
    assert(type(rotate) == angle,
        message: "rotate must an angle")
    assert(label == none or type(label) in (content, str, dictionary),
        message: "label must content, dictionary or string")
    assert(params.at("variant", default: none) in (none, "ieee", "iec", "pretty"),
        message: "variant must be 'iec', 'ieee' or 'pretty'")
    assert(n in (none, "*-", "*-*", "-*", "o-*", "*-o", "o-", "-o", "o-o"))

    let p-rotate = rotate
    let p-scale = scale
    let p-draw = draw

    import cetz.draw: *

    group(name: name, ctx => {
        let zap-style = get-style(ctx)
        let style = zap-style.at(uid) + params.named()
        
        let p-rotate = p-rotate
        let (ctx, ..position) = cetz.coordinate.resolve(ctx, ..position)
        let p-origin = position.first()
        if position.len() == 2 {
            anchor("in", position.first())
            anchor("out", position.last())
            p-rotate = cetz.vector.angle2(..position)
            p-origin = (position.first(), position-ratio, position.last())
        }
        set-origin(p-origin)
        rotate(p-rotate)

        // Component
        on-layer(1, {
            group(name: "component", {
                //Scale
                if (type(p-scale) == float) {
                    scale(x: p-scale * style.scale.x,
                          y: p-scale * style.scale.y)
                } else {
                    scale(x: p-scale.at(0, default: 1.0) * style.scale.x,
                          y: p-scale.at(1, default: 1.0) * style.scale.y)
                }
                draw(ctx, position, style)
                copy-anchors("bounds")
            })
        })

        copy-anchors("component")

        // Label
        on-layer(2, {
            if label != none {
                if type(label) == dictionary and label.at("content", default: none) == none {
                  panic("Label dictionary needs at least content key")
                }
                let label-style = zap-style.label
                let (label, distance, width, height, anchor) = if type(label) == dictionary {(
                    label.at("content", default: label-style.content),
                    label.at("distance", default: label-style.distance),
                    ..cetz.util.measure(ctx, label.at("content", default: label-style.content)),
                    label.at("anchor", default: label-style.anchor)
                )} else {(
                    label,
                    label-style.distance,
                    ..cetz.util.measure(ctx, label),
                    label-style.anchor
                )}
                let reverse = "south" in anchor
                content("component." + anchor, anchor: get-label-anchor(p-rotate, zap-style.label.tolerance).at(if reverse { 1 } else { 0 }), label, padding: distance)
                // move-to("component.north")
                // cetz.draw.anchor("label", (rel: (0, -zap-style.label.distance)))
                // move-to("component.center")
                // cetz.draw.anchor("label", (rel: (0, -1)))
                // cetz.draw.anchor("label", "component")
                // circle("label", radius: distance, stroke: green + .1pt, name: "circ")
                // let pos = "circ.0%"
                // content(pos, label, anchor: "north")
                // circle(pos, radius: .4pt, fill: blue, stroke: none)
            }
        })

        // Decorations

        // Pins
        // wire("in", "component.west")
        // wire("component.east", "out")

        if i != none { current(ctx, i) }
        if f != none { flow(ctx, f) }
        if u != none { voltage(ctx, u, p-rotate) }
        if n != none {
            if "*-" in n { node("", "in") }
            if "-*" in n { node("", "out") }
            if "o-" in n { node("", "in", fill: false) }
            if "-o" in n { node("", "out", fill: false) }
        }
    })

    // Show anchors if debug
    on-layer(1, {
        get-ctx(ctx => {
            if debug == true or ctx.zap.params.debug {
                let style = ctx.zap.style.debug
                for-each-anchor(name, exclude: ("start", "end", "mid", "component", "line", "bounds", "gl", "0", "1"), name => {
                    circle((), radius: style.radius, stroke: style.stroke)
                    content((rel: (0, style.shift)), box(inset: 1pt, text(style.font, name, fill: style.fill)), angle: style.angle)
                })
            }
        })
    })
}
