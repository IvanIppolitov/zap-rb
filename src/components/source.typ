#import "/src/component.typ": component
#import "/src/interface.typ": interface
#import "/src/components/wire.typ": wire
#import "/src/dependencies.typ": cetz
#import "/src/mini.typ": ac-sign
#import cetz.draw: anchor, circle, content, line, mark, polygon, rect, move-to

#let isource-base(uid, name, node, dependent: false, current: "dc", ..params) = {
    assert(type(dependent) == bool, message: "dependent must be boolean")
    assert(current in ("dc", "ac"), message: "current must be ac or dc")

    // Drawing function
    let draw(ctx, position, style) = {
        let factor = if dependent { 1.1 } else { 1 }
        interface((-style.radius * factor, -style.radius * factor), (style.radius * factor, style.radius * factor))

        if position.len() == 1 {
            move-to("bounds.west")
            anchor("in", (rel: (-ctx.zap.style.pin.length, 0)))
            move-to("bounds.east")
            anchor("out", (rel: (+ctx.zap.style.pin.length, 0)))
        }
        
        wire("in", "bounds.west")
        wire("bounds.east", "out")

        if dependent {
            polygon((0, 0), 4, fill: white, ..style, radius: style.radius * factor)
        } else {
            circle((0, 0), radius: style.radius, fill: white, ..style)
        }
        if style.variant == "iec" {
            line((0, -style.radius * factor), (rel: (0, 2 * style.radius * factor)), ..style, fill: none)
        } else {
            line((-style.radius + style.padding, 0), (rel: (2 * style.radius - 1.85 * style.padding, 0)), mark: (end: ">"), fill: black)
        }
    }

    // Componant call
    component(uid, name, node, draw: draw, ..params)
}

#let isource(name, node, ..params) = isource-base("isource", name, node, dependent: true, ..params)
#let disource(name, node, ..params) = isource-base("disource", name, node, dependent: true, ..params)
#let acisource(name, node, ..params) = isource-base("acisource", name, node, current: "ac", ..params)

#let vsource-base(uid, name, node, dependent: false, current: "dc", ..params) = {
    assert(current in ("dc", "ac"), message: "current must be ac or dc")

    // Drawing function
    let draw(ctx, position, style) = {
        let factor = if dependent { 1.1 } else { 1 }
        interface((-style.radius * factor, -style.radius * factor), (style.radius * factor, style.radius * factor))

        if position.len() == 1 {
            move-to("bounds.west")
            anchor("in", (rel: (-ctx.zap.style.pin.length, 0)))
            move-to("bounds.east")
            anchor("out", (rel: (+ctx.zap.style.pin.length, 0)))
        }
        
        wire("in", "bounds.west")
        wire("bounds.east", "out")

        if dependent {
            polygon((0, 0), 4, fill: white, ..style, radius: style.radius * factor)
        } else {
            circle((0, 0), fill: white, ..style)
        }
        if style.variant == "iec" {
            if current == "ac" {
                content((0, 0), [#cetz.canvas({ ac-sign(size: 2) })])
            } else {
                line((-style.radius * factor, 0), (rel: (2 * style.radius * factor, 0)), ..style)
            }
        } else {
            line((rel: (-style.radius + style.padding, -style.sign-size)), (rel: (0, 2 * style.sign-size)), stroke: style.sign-stroke)
            line(
                (
                    style.radius - style.padding - style.sign-delta,
                    -style.sign-size,
                ),
                (rel: (0, 2 * style.sign-size)),
                stroke: style.sign-stroke,
            )
            line((rel: (style.sign-size, -style.sign-size)), (rel: (-2 * style.sign-size, 0)), stroke: style.sign-stroke)
        }
    }

    // Componant call
    component(uid, name, node, draw: draw, ..params)
}

#let vsource(name, node, ..params) = vsource-base("vsource", name, node, ..params)
#let dvsource(name, node, ..params) = vsource-base("dvsource", name, node, dependent: true, ..params)
#let acvsource(name, node, ..params) = vsource-base("acvsource", name, node, current: "ac", ..params)
