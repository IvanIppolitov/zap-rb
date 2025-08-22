#import "/src/dependencies.typ": cetz
#import "/src/canvas.typ": get-style
#import cetz.draw: get-ctx, line


#let wire(..params) = {
    get-ctx(ctx => {
        line(..get-style(ctx).wire, ..params)
    })
}
