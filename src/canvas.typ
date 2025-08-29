#import "/src/dependencies.typ": cetz
#import "components/wire.typ": wire
#import "/src/styles.typ": default

#let canvas(fallback) = {
    cetz.canvas({
        cetz.draw.set-ctx(ctx => {
            ctx.insert("zap", (default))
            ctx.shared-state.insert("zap", (wires: ()))
            return ctx
        })
        fallback 
        cetz.draw.get-ctx(ctx => {
            let wires = ctx.shared-state.zap.wires
            for branch in wires {
                wire(..branch, lbind: false)
            }
        })
    })
}

// #let set-style(..style) = {
//     cetz.draw.set-ctx(ctx => {
//         ctx.zap.style = cetz.util.merge-dictionary(ctx.zap.style, style.named())
//         return ctx
//     })
// }
//
// #let get-style(ctx) = {
//     let zap-style = ctx.zap.style
//     if zap-style.node.fill == auto {
//         zap-style.node.fill = zap-style.stroke.paint
//     }
//     cetz.styles.resolve(zap-style)
// }
//
// #let set-params(..params) = {
//     cetz.draw.set-ctx(ctx => {
//         ctx.zap.params = cetz.util.merge-dictionary(ctx.zap.params, params.named())
//         return ctx
//     })
// }
