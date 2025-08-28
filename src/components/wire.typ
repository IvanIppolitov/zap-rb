#import "/src/dependencies.typ": cetz
#import "/src/canvas.typ": get-style
#import cetz.draw: get-ctx, line


#let wire(style: (:), ..params) = {
    get-ctx(ctx => {
        let wire-style = cetz.styles.resolve(get-style(ctx).wire, merge: style)
        line(..wire-style, ..params)
    })
}
