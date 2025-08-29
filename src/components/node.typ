#import "/src/dependencies.typ": cetz
#import "/src/utils.typ": get-style
#import cetz.draw: circle, on-layer, get-ctx

#let node(name, position, fill: true, ..params) = {
    assert(type(name) == str, message: "node name must be a string")

    on-layer(1, {
        get-ctx(ctx => {
            let node-style = get-style(ctx).node
            circle(position,
                   radius: node-style.radius,
                   fill: if fill { node-style.fill } else { node-style.nofill },
                   name: name,
                   stroke: node-style.stroke,
                   ..params)
        })
    })
}
