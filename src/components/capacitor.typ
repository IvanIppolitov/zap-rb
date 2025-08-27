#import "/src/component.typ": component
#import "/src/interface.typ": interface
#import "/src/components/wire.typ": wire
#import "/src/dependencies.typ": cetz
#import cetz.draw: anchor, line, move-to
#import "/src/mini.typ": variable-arrow


#let capacitor(name, node, variable: false, ..params) = {
    assert(type(variable) == bool, message: "variable must be of type bool")

    // Capacitor style
    let style = (
        width: .8,
        distance: .25
    )

    // Drawing function
    let draw(ctx, position, style) = {
        interface((-style.distance / 2, -style.width / 2), (style.distance / 2, style.width / 2))
        
        if position.len() == 1 {
            move-to("bounds.west")
            anchor("in", (rel: (-ctx.zap.style.pin.length, 0)))
            move-to("bounds.east")
            anchor("out", (rel: (+ctx.zap.style.pin.length, 0)))
        }
        
        wire("in", "bounds.west")
        wire("bounds.east", "out")

        line((-style.distance / 2, -style.width / 2), (-style.distance / 2, style.width / 2), ..style)
        line((style.distance / 2, -style.width / 2), (style.distance / 2, style.width / 2), ..style)
        if (variable) {
            variable-arrow()
        }
    }

    // Componant call
    component("capacitor", name, node, draw: draw, style: style, ..params)
}
