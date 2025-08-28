#import "/src/component.typ": component
#import "/src/interface.typ": interface
#import "/src/components/wire.typ": wire
#import "/src/dependencies.typ": cetz
#import cetz.draw: anchor, line, rect, move-to, circle, compound-path
#import "/src/mini.typ": variable-arrow


#let resistor(name, node, variable: false, heatable: false, adjustable: false, ..params) = {
    assert(type(variable) == bool, message: "variable must be of type bool")
    assert(type(adjustable) == bool, message: "adjustable must be of type bool")

    // Resistor style
    let style = (
        width: 1.41,
        height: .47,
        zigs: 3,
        shift: 0.22pt //improves joints
    )

    // Drawing function
    let draw(ctx, position, style) = {
        interface((-style.width / 2, -style.height / 2), (style.width / 2, style.height / 2))

        if position.len() == 1 {
            move-to("bounds.west")
            anchor("in", (rel: (-ctx.zap.style.pin.length, 0)))
            move-to("bounds.east")
            anchor("out", (rel: (+ctx.zap.style.pin.length, 0)))
        }
        
        move-to("bounds.west")
        wire((rel: (+style.shift,0)), "in")
        move-to("bounds.east")
        wire((rel: (-style.shift,0)), "out")

        if style.variant == "iec" {
            rect(
                (-style.width / 2, -style.height / 2),
                (
                    style.width / 2,
                    style.height / 2,
                ),
                fill: white,
                ..style,
            )
        } else {
            style.stroke.insert("join", "bevel")
            let step = style.width / (style.zigs * 2)
            let sign = -1
            let x = style.width / 2
            
            let p1 = ((+x, 0), style.stroke.thickness / 2, -90deg, (+x - step / 2, -style.height / 2))
            let p2 = ((+x, 0), style.stroke.thickness / 2, +90deg, (+x - step / 2, -style.height / 2))
            let p3 = (p1, "-|", p2)

            line(
                (-x, 0),
                (rel: (step / 2, style.height / 2)),
                ..for _ in range(style.zigs * 2 - 1) {
                    ((rel: (step, style.height * sign)),)
                    sign *= -1
                },
                (x, 0),
                ..style,
                fill: none,
                name: "zig-line"
            )
            // circle("zig-line.1", radius: 0.2pt, fill: green, stroke: none)
            // line((+x, 0), (rel: (-step / 2, 0)), stroke: 0.5pt + blue)
            // line(p1, p2, p3, p1, fill: red, stroke: none)
            // circle(p1, radius: 0.1pt, fill: blue, stroke: none)
            // circle(p2, radius: 0.1pt, fill: blue, stroke: none)
            // circle(p3, radius: 0.1pt, fill: blue, stroke: none)
            // circle((+x, 0), radius: 0.2pt, fill: green, stroke: none)
            // circle((-x, 0), radius: 0.2pt, fill: green, stroke: none)
        }
        if variable {
            variable-arrow()
        } else if adjustable {
            let arrow-length = .8
            anchor("a", (0, style.height / 2 + arrow-length))
            line("a", (0, style.height / 2), mark: (end: ">", fill: black), fill: none)
        }
        if heatable {
            for i in range(3) {
                let x = style.width / 4 * (i + 1) - style.width / 2
                line((x, -style.height / 2), (x, style.height / 2), ..style)
            }
        }
    }

    // Componant call
    component("resistor", name, node, draw: draw, style: style, ..params)
}

#let rheostat(name, node, ..params) = resistor(name, node, variable: true, ..params)
#let potentiometer(name, node, ..params) = resistor(name, node, adjustable: true, ..params)
#let heater(name, node, ..params) = resistor(name, node, heatable: true, ..params)
