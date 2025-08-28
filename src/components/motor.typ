#import "/src/component.typ": component
#import "/src/interface.typ": interface
#import "/src/components/wire.typ": wire
#import "/src/dependencies.typ": cetz
#import cetz.draw: anchor, arc, circle, content, rect, move-to
#import "/src/mini.typ": ac-sign, dc-sign

#let motor(uid, name, node, current: "dc", magnet: false, ..params) = {
    assert(current in ("dc", "ac"), message: "current must be ac or dc")
    assert(type(magnet) == bool, message: "magnet must be bool")
    assert(not (magnet and current == "ac"), message: "magnet only with dcmotor")

    // Drawing function
    let draw(ctx, position, style) = {
        interface((-style.radius, -style.radius), (style.radius, style.radius))

        if position.len() == 1 {
            move-to("bounds.west")
            anchor("in", (rel: (-ctx.zap.style.pin.length, 0)))
            move-to("bounds.east")
            anchor("out", (rel: (+ctx.zap.style.pin.length, 0)))
        }
        
        wire("in", "bounds.west")
        wire("bounds.east", "out")

        if (magnet) {
            rect((-style.magnet-width / 2, -style.magnet-height / 2), (style.magnet-width / 2, style.magnet-height / 2), fill: black)
        }
        circle((0, 0), radius: style.radius, fill: white, ..style)
        content((0, 0), anchor: "south", "M", padding: .03)
        let symbol = if current == "dc" { dc-sign } else { ac-sign }
        content((0, 0), [#cetz.canvas({ symbol() })], anchor: "north", padding: .13)
    }

    // Componant call
    component(uid, name, node, draw: draw, ..params)
}

#let dcmotor(name, node, ..params) = motor("dcmotor", name, node, current: "dc", ..params)
#let acmotor(name, node, ..params) = motor("acmotor", name, node, current: "ac", ..params)
