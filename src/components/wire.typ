#import "/src/dependencies.typ": cetz
#import "/src/utils.typ": get-style
#import cetz.draw: get-ctx, set-ctx, line


#let wire(style: (:), lbind: none, ..params) = {
    get-ctx(ctx => {
        let wire-style = cetz.util.merge-dictionary(get-style(ctx).wire, style)

        if lbind == true or wire-style.lbind and lbind == none and lbind != false {
            set-ctx(ctx => {
                let (ctx, ..points) = cetz.coordinate.resolve(ctx, ..params)
                for index in range(points.len()) {
                    let new-point = cetz.matrix.mul4x4-vec3(ctx.transform, points.at(index))
                    new-point.at(1) = -new-point.at(1)
                    points.at(index) = new-point
                }
                let sum = none
                for index in range(ctx.shared-state.zap.wires.len()) {
                    let branch = ctx.shared-state.zap.wires.at(index)
                    if points.first() == branch.first() {
                        points.remove(0)
                        sum = (points.rev() + branch).rev()
                    } else if points.first() == branch.last() {
                        points.remove(0)
                        sum = branch + points
                    }
                    if sum != none {
                        ctx.shared-state.zap.wires.remove(index)
                        points = sum
                        break
                    }
                }
                sum = none
                for index in range(ctx.shared-state.zap.wires.len()) {
                    let branch = ctx.shared-state.zap.wires.at(index)
                    if points.last() == branch.first() {
                        points.pop()
                        sum = points + branch
                    } else if points.last() == branch.last() {
                        points.pop()
                        sum = branch + points.rev()
                    }
                    if sum != none {
                        ctx.shared-state.zap.wires.at(index) = sum
                        break
                    }
                }
                if sum == none {
                    ctx.shared-state.zap.wires.push(points)
                }
                return ctx
            })
        } else {
            line(..wire-style, ..params)
        }
    })
}
