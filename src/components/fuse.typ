#import "/src/component.typ": component
#import "/src/interface.typ": interface
#import "/src/components/wire.typ": wire
#import "/src/dependencies.typ": cetz
#import cetz.draw: anchor, circle, floating, line, rect, move-to

#let fuse(name, node, asymmetric: false, ..params) = {
    assert(type(asymmetric) == bool, message: "asymmetric must be of type bool")

    // Drawing function
    let draw(ctx, position, style) = {
        interface((-style.width / 2, -style.height / 2), (style.width / 2, style.height / 2))

        if position.len() == 1 {
            move-to("bounds.west")
            anchor("in", (rel: (-ctx.zap.style.pin.length, 0)))
            move-to("bounds.east")
            anchor("out", (rel: (+ctx.zap.style.pin.length, 0)))
        }
        
        wire("in", "bounds.west")
        wire("bounds.east", "out")

        rect((-style.width / 2, -style.height / 2), (style.width / 2, style.height / 2), fill: white, ..style)
        wire((-style.width / 2, 0), (style.width / 2, 0))
        if (asymmetric) {
            rect((-style.width / 2, -style.height / 2), (-style.width / 2 + float(style.asymmetry * style.width), style.height / 2), fill: black)
        }
    }

    // Componant call
    component("fuse", name, node, draw: draw, ..params)
}

#let afuse(name, node, ..params) = fuse(name, node, asymmetric: true, ..params)
