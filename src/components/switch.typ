#import "/src/component.typ": component
#import "/src/interface.typ": interface
#import "/src/components/wire.typ": wire
#import "/src/dependencies.typ": cetz
#import cetz.draw: anchor, circle, line, mark, rect, hide, move-to

#let switch(name, node, closed: false, ..params) = {
    // Switch style
    let style = (
        width: .8,
        angle: 35deg
    )

    // Drawing function
    let draw(ctx, position, style) = {
        interface((-style.width / 2, -0.2), (style.width/2, 0.2))
        
        if position.len() == 1 {
            move-to("bounds.west")
            anchor("in", (rel: (-ctx.zap.style.pin.length, 0)))
            move-to("bounds.east")
            anchor("out", (rel: (+ctx.zap.style.pin.length, 0)))
        }
        
        wire("in", "bounds.west")
        wire("bounds.east", "out")

        wire((-style.width/2,0), (radius: style.width / 2, angle: if closed { 0deg } else { style.angle }))
    }

    // Componant call
    component("switch", name, node, draw: draw, style: style, ..params)
}
