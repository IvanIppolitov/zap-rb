#import "/src/dependencies.typ": cetz
#import "/src/utils.typ": get-style
#import cetz.draw: get-ctx, set-ctx, line


#let wire(style: (:), lbind: false, ..params) = {
    get-ctx(ctx => {
        let wire-style = cetz.util.merge-dictionary(get-style(ctx).wire, style)

        if lbind {
            let (ctx, ..term) = cetz.coordinate.resolve(ctx, ..params)
            set-ctx(ctx => {
                let sum = none
                for index in range(ctx.zap.wires.len()) {
                    let branch = ctx.zap.wires.at(index)
                    if branch.first() == term.first() {
                        sum = term.rev() + branch
                    } else if branch.first() == term.last() {
                        sum = term + branch
                    } else if branch.last() == term.first() {
                        sum = branch + term
                    } else if branch.last() == term.last() {
                        sum = branch + term.rev()
                    }
                    if sum != none {
                        ctx.zap.wires.at(index) = sum
                        break
                    }
                }
                if sum == none {
                    ctx.zap.wires.push(term)
                }
                return ctx
            })
        } else {
            line(..wire-style, ..params)
        }
    })
}
