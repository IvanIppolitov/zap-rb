#import "/src/dependencies.typ": cetz
#import "/src/styles.typ": default

#let canvas(fallback) = {
    cetz.canvas({
        cetz.draw.set-ctx(ctx => {
            ctx.insert("zap", (default))
            return ctx
        })
        fallback 
    })
}

#let set-style(..style) = {
    cetz.draw.set-ctx(ctx => {
        ctx.zap.at("style") = cetz.util.merge-dictionary(ctx.zap.style, style.named())
        return ctx
    })
}

#let get-style(ctx) = {
    let zap-style = ctx.zap.style
    if zap-style.node.fill == auto {
        zap-style.node.fill = zap-style.stroke.paint
    }
    cetz.styles.resolve(zap-style)
}

#let set-params(..params) = {
    cetz.draw.set-ctx(ctx => {
        ctx.zap.at("params") = cetz.util.merge-dictionary(ctx.zap.params, params.named())
        return ctx
    })
}
