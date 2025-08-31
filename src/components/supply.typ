#import "/src/component.typ": component
#import "/src/interface.typ": interface
#import "/src/components/wire.typ": wire
#import "/src/dependencies.typ": cetz
#import cetz.draw: anchor, line, polygon, arc, circle

#let ground(name, node, type: "ground", envelope: none, ..params) = {
    assert(params.pos().len() == 0, message: "ground supports only one node")

    // Drawing function
    let draw(ctx, position, style) = {
        let center = (0, -style.distance)
        wire((0, 0), center)
        if type == "signal" {
            polygon(center, 3, anchor: "north", radius: style.radius, angle: -90deg, name: "polygon", ..style)
            let (width, height) = cetz.util.measure(ctx, "polygon")
            interface((-width / 2, -height / 2), (width / 2, height / 2))
        } else if type == "reference" {
            line((to: center, rel: (-style.width / 2, 0)), (rel: (style.width, 0)), ..style)
            interface((-style.width / 2, -style.distance), (style.width / 2, 0))
        } else if type == "chassis" {
            let step = style.chassis.width / (style.number - 1)
            let start = (-style.chassis.width / 2, -style.distance)
            let end = (+style.chassis.width / 2, -style.distance)
            line((to: start, rel: (-90deg - style.chassis.angle, style.chassis.depth)),
                 start, end,
                 (rel: (-90deg - style.chassis.angle, style.chassis.depth)),
                 stroke: style.stroke)
            for i in range(1, style.number - 1) {
                line((to: start, rel: (step * i, 0)),
                     (rel: (angle: -90deg - style.chassis.angle, radius: style.chassis.depth)),
                     stroke: style.stroke)
            }
            interface((to: start, rel: (-90deg - style.chassis.angle, style.chassis.depth)), (style.chassis.width / 2, 0))
        } else {
            for i in range(style.number) {
                let w = style.width - style.steph * i
                line((to: center, rel: (-w / 2, -style.stepv * i)), (rel: (w, 0)), ..style)
            }
            let height = style.distance + style.stepv * 2
            interface((-style.width / 2, -height), (style.width / 2, 0))
            
            if envelope == "noiseless" {
                arc("bounds.south", radius: style.envelope-radius, start: 0deg, stop: 180deg, anchor: "origin", stroke: style.stroke)
            } else if envelope == "protect" {
                circle(center, radius: style.envelope-radius, stroke: style.stroke)
            }
        }
        anchor("c", (0,0))
    }

    // Componant call
    component("ground", name, node, draw: draw, ..params)
}

#let tlground(name, node, ..params) = ground(name, node, distance: 0, ..params)
#let rground(name, node, ..params) = ground(name, node, type: "reference", ..params)
#let sground(name, node, ..params) = ground(name, node, type: "signal", ..params)
#let tground(name, node, ..params) = ground(name, node, distance: 0, type: "reference", ..params)
#let nground(name, node, ..params) = ground(name, node, envelope: "noiseless", ..params)
#let pground(name, node, ..params) = ground(name, node, envelope: "protect", ..params)
#let cground(name, node, ..params) = ground(name, node, type: "chassis", ..params)


#let vcc(name, node, ..params) = {

    // Drawing function
    let draw(ctx, position, style) = {
        let top = (0, style.distance)
        wire((0, 0), top)
        line((to: top, rel: (radius: style.radius, angle: -90deg - style.angle)), top,
             (rel: (radius: style.radius, angle: -90deg + style.angle)), stroke: style.stroke)

        let (width, height) = (calc.sin(style.angle) * style.radius * 2, style.distance)
        interface((-width / 2, 0), (width / 2, style.distance))
        anchor("c", (0,0))
    }

    // Componant call
    component("vcc", name, node, draw: draw, ..params)
}

#let vee(name, node, ..params) = {

    // Drawing function
    let draw(ctx, position, style) = {
        let top = (0, -style.distance)
        wire((0, 0), top)
        line((to: top, rel: (radius: style.radius, angle: 90deg + style.angle)), top,
             (rel: (radius: style.radius, angle: 90deg - style.angle)), stroke: style.stroke)

        let (width, height) = (calc.sin(style.angle) * style.radius * 2, style.distance)
        interface((-width / 2, -style.distance), (width / 2, 0))
    }

    // Componant call
    component("vee", name, node, draw: draw, ..params)
}
