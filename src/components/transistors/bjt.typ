#import "/src/component.typ": component
#import "/src/interface.typ": interface
#import "/src/components/wire.typ": wire
#import "/src/dependencies.typ": cetz
#import cetz.draw: anchor, circle, hide, line, mark, translate
#import "/src/mini.typ": center-mark

#let bjt-base(uid, name, node, polarisation: "npn", envelope: false, ..params) = {
    assert(polarisation in ("npn", "pnp"), message: "polarisation must `npn` or `pnp`")
    assert(type(envelope) == bool, message: "envelope must be of type bool")
    assert(params.pos().len() == 0, message: "ground supports only one node")

    // Drawing function
    let draw(ctx, position, style) = {
        interface((-style.radius, -style.radius), (style.radius, style.radius))
        translate((-calc.cos(style.aperture) * style.radius, 0))

        let sgn = if polarisation == "npn" { 1 } else { -1 }
        anchor("base", ((-style.radius, 0), 30%, (style.radius, 0)))
        anchor("e", (-style.aperture * sgn, style.radius))
        anchor("c", (style.aperture * sgn, style.radius))
        anchor("b", (-style.radius, 0))

        if envelope {
            circle((0, 0), radius: style.radius, ..style, name: "circle")
        } else {
            hide(circle((0, 0), radius: style.radius, ..style, name: "circle"))
        }

        line((to: "base", rel: (0, -style.base-height / 2)), (to: "base", rel: (0, style.base-height / 2)), ..style)

        let base = (to: "base", rel: (0, -style.base-distance * sgn))
        let sep = (base, 99%, "e")
        line(base, sep, mark: center-mark(symbol: if sgn == -1 { "<" } else { ">" }), ..style)
        wire(sep, "e")
        
        base = (to: "base", rel: (0, style.base-distance * sgn))
        sep = (base, 99%, "c")
        line(base, sep, ..style)
        wire(sep, "c")

        sep = ("base", 99%, (-style.radius, 0))
        line("base", sep, ..style)
        wire(sep, (-style.radius, 0))
    }

    // Componant call
    component(uid, name, node, draw: draw, ..params, label: none)
}

#let bjt(name, node, ..params) = bjt-base("bjt", name, node, ..params)
#let npn(name, node, ..params) = bjt-base("npn", name, node, polarisation: "npn", ..params)
#let pnp(name, node, ..params) = bjt-base("pnp", name, node, polarisation: "pnp", ..params)
