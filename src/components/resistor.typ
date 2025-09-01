#import "/src/component.typ": component
#import "/src/interface.typ": interface
#import "/src/components/wire.typ": wire
#import "/src/dependencies.typ": cetz
#import cetz.draw: anchor, line, rect, move-to, circle, compound-path
#import "/src/mini.typ": variable-arrow, adjustable-arrow


#let resistor-base(uid, name, node, variable: false, heatable: false, adjustable: false, ..params) = {
    assert(type(variable) == bool, message: "variable must be of type bool")
    assert(type(adjustable) == bool, message: "adjustable must be of type bool")

    // Drawing function
    let draw(ctx, position, style) = {
        interface((-style.width / 2, -style.height / 2), (style.width / 2, style.height / 2))

        if style.variant == "iec" {
            rect(
                (-style.width / 2, -style.height / 2),
                (style.width / 2,
                 style.height / 2,),
                fill: white,
                ..style,
            )
        } else {
            style.stroke.insert("join", "bevel")
            let width = style.width - style.extra * 2
            let step = width / (style.zigs * 2)
            let sign = -1
            let x = width / 2
            
            line(
                (-x - style.extra, 0),
                (-x, 0),
                (rel: (step / 2, style.height / 2)),
                ..for _ in range(style.zigs * 2 - 1) {
                    ((rel: (step, style.height * sign)),)
                    sign *= -1
                },
                (x, 0),
                (x + style.extra, 0),
                ..style,
                fill: none
            )
        }
        if variable {
            variable-arrow(style: style.at("arrow", default: (:)))
        } else if adjustable {
            // let arrow-length = .8
            // anchor("a", (0, style.height / 2 + arrow-length))
            // line("a", (0, style.height / 2), mark: (end: ">", fill: black), fill: none)
            adjustable-arrow((0, style.height / 2))
        }
        if heatable {
            for i in range(3) {
                let x = style.width / 4 * (i + 1) - style.width / 2
                line((x, -style.height / 2), (x, style.height / 2), ..style)
            }
        }
        
        if position.len() == 1 {
            move-to("bounds.west")
            anchor("in", (rel: (-ctx.zap.style.pin.length, 0)))
            move-to("bounds.east")
            anchor("out", (rel: (+ctx.zap.style.pin.length, 0)))
        }
        
        wire("bounds.west", "in")
        wire("bounds.east", "out")
    }

    // Componant call
    component(uid, name, node, draw: draw, ..params)
}

#let resistor(name, node, ..params) = resistor-base("resistor", name, node, ..params)
#let rheostat(name, node, ..params) = resistor-base("rheostat", name, node, variable: true, ..params)
#let potentiometer(name, node, ..params) = resistor-base("potentiometer", name, node, adjustable: true, ..params)
#let heater(name, node, ..params) = resistor-base("heater", name, node, heatable: true, ..params)
