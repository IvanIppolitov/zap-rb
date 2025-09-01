#import "/src/dependencies.typ": cetz
#import "/src/utils.typ": get-style
#import "components/wire.typ": wire
#import "/src/styles.typ": default

#let canvas(fallback) = {
    cetz.canvas({
        // Init late-binding dictionary
        cetz.draw.set-ctx(ctx => {
            ctx.insert("zap", (default))
            ctx.shared-state.insert("zap", (wires: ()))
            return ctx
        })
        fallback 

        // Drawing late-binding wires
        cetz.draw.get-ctx(ctx => {
            let wires = ctx.shared-state.zap.wires
            for branch in wires {
                if branch.len() == 2 and cetz.vector.dist(..branch) < get-style(ctx).wire.min-length {}
                else { wire(..branch, lbind: false) }
            }
        })
    })
}
