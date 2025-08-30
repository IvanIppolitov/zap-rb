#import "/src/component.typ": component
#import "/src/interface.typ": interface
#import "/src/components/wire.typ": wire
#import "/src/dependencies.typ": cetz
#import cetz.draw: anchor, arc, line, rect, bezier, move-to

#let inductor(name, node, ..params) = {

    // Drawing function
    let draw(ctx, position, style) = {
        if (style.variant == "iec") {
            rect((-style.width / 2, -style.height / 2), (style.width / 2, style.height / 2), fill: black, ..style)
            interface((-style.width / 2, -style.height / 2), (style.width / 2, style.height / 2))
        } else if (style.variant == "iee") {
            interface((-style.width / 2, -style.height / 2 + style.fall / 2), (style.width / 2, style.height / 2 - style.fall / 2))
            cetz.draw.translate(x: 0., y: -style.fall)
            let bump-radius = style.width / style.bumps / 2
            let sgn = if position.last().at(0) < position.first().at(0) { -1 } else { 1 }
            let start = (-style.width / 2 - bump-radius, 0)
            // line((-width / 2, 0), (rel: (-style.extra, 0)), ..cetz.util.merge-dictionary(style, (stroke: (cap: "square"))))
            // line((+width / 2, 0), (rel: (+style.extra, 0)), ..cetz.util.merge-dictionary(style, (stroke: (cap: "square"))))
            cetz.draw.merge-path(..style, {
                for i in range(style.bumps) {
                    let arc-center = (start.at(0) + bump-radius + i * 2 * bump-radius, 0)
                    arc(arc-center, radius: bump-radius, start: sgn * 180deg, stop: 0deg)
                }
            })
        } else {
            interface((-style.width / 2, -style.height / 2 + style.fall / 2), (style.width / 2, style.height / 2 - style.fall / 2))
            cetz.draw.translate(x: 0., y: -style.fall)
            let ratio = 0.6
            let loop-bottom = style.height * 0.25
            let loop-width = style.width / (ratio * (style.bumps - 1) + 1)
            let step = loop-width * ratio
            let k1 = (0.24, 0.24)
            let k2 = (0.25, 0.55)
            let sgn = if position.last().at(0) < position.first().at(0) { -1 } else { 1 }
            let start = -style.width / 2

            let top-draw(begin) = {
                let a = (begin, 0)
                let c = (a.at(0) + loop-width, 0)
                let b = ((a.at(0) + c.at(0)) / 2, style.height / 2)
                bezier(a, b, (to: a, rel: (0, style.height * k1.at(1))), (to: b, rel: (-loop-width * k1.at(0), 0))) 
                bezier(b, c, (to: b, rel: (loop-width * k1.at(0), 0)), (to: c, rel: (0, style.height * k1.at(1)))) 
            }
            cetz.draw.merge-path(..style, {
                for i in range(style.bumps - 1) {
                    top-draw(start + step * i)
                    let c = (start + step * i + loop-width, 0)
                    let a = (c.at(0) - loop-width * (1. - ratio), 0)
                    let b = ((a.at(0) + c.at(0)) / 2, -loop-bottom)
                    bezier(c, b, (to: c, rel: (0, -loop-bottom * k2.at(1))), (to: b, rel: (loop-width * (1. - ratio) * k2.at(0), 0))) 
                    bezier(b, a, (to: b, rel: (-loop-width * (1. - ratio) * k2.at(0), 0)), (to: a, rel: (0, -loop-bottom * k2.at(1)))) 
                }
                top-draw(start + step * (style.bumps - 1))
            })
        }
        
        if position.len() == 1 {
            move-to("bounds.west")
            anchor("in", (rel: (-ctx.zap.style.pin.length, 0)))
            move-to("bounds.east")
            anchor("out", (rel: (+ctx.zap.style.pin.length, 0)))
        }
        
        wire("in", "bounds.west")
        wire("bounds.east", "out")
    }

    // Componant call
    component("inductor", name, node, draw: draw, ..params)
}
