#import "/src/component.typ": component
#import "/src/interface.typ": interface
#import "/src/components/wire.typ": wire
#import "/src/dependencies.typ": cetz
#import cetz.draw: anchor, arc, line, rect, move-to

#let inductor(name, node, ..params) = {
    // Inductor style
    let style = (
        width: 1.41,
        height: 1.41 / 3,
        bumps: 3,
        shift: 0.4pt
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
        
        wire("in", "bounds.west", style: (stroke: (cap: "square")))
        wire("bounds.east", "out", style: (stroke: (cap: "square")))

        // move-to("bounds.west")
        // wire((rel: (+style.shift,0)), "in")
        // move-to("bounds.east")
        // wire((rel: (-style.shift,0)), "out")
        //

        let bump-radius = style.width / style.bumps / 2
        if (style.variant == "iec") {
            rect((-style.width / 2, -style.height / 2), (style.width / 2, style.height / 2), fill: black, ..style)
        } else {
            let sgn = if position.last().at(0) < position.first().at(0) { -1 } else { 1 }
            let start = (-style.width / 2 - bump-radius, 0)
            for i in range(style.bumps) {
                let arc-center-x = (
                    start.at(0) + bump-radius + i * 2 * bump-radius
                )
                let arc-center = (arc-center-x, 0)
                arc(arc-center, radius: bump-radius, start: sgn * 180deg, stop: 0deg, ..style)
            }
        }
    }

    // Componant call
    component("inductor", name, node, draw: draw, style: style, ..params)
}
