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
