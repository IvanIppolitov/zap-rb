#let normalize-angle(angle) = {
    angle = angle.deg()
    let raw-angle = calc.rem(if angle < 0 { angle + 360 } else { angle }, 360)
    let str-angle = str(raw-angle) + "deg"
    let angle  = eval(str-angle)
    return angle
}

#let get-label-anchor(angle, tolerance) = {
    let angle-deg = normalize-angle(angle).deg()

    if calc.abs(angle-deg) < tolerance {
        return ("south", "north")
    } else if calc.abs(angle-deg - 90) < tolerance {
        return ("east", "west")
    } else if calc.abs(angle-deg - 180) < tolerance {
        return ("north", "south")
    } else if calc.abs(angle-deg - 270) < tolerance {
        return ("west", "east")
    } else {
        if angle-deg > 0 and angle-deg < 90 {
            return ("south-east", "north-west")
        } else if angle-deg > 90 and angle-deg < 180 {
            return ("north-east", "south-west")
        } else if angle-deg > 180 and angle-deg < 270 {
            return ("north-west", "south-east")
        } else {
            return ("south-west", "north-east")
        }
    }
}

#import "/src/dependencies.typ": cetz

#let set-style(..style) = {
    cetz.draw.set-ctx(ctx => {
        ctx.zap.style = cetz.util.merge-dictionary(ctx.zap.style, style.named())
        return ctx
    })
}

#let get-style(ctx) = {
    let zap-style = ctx.zap.style
    if zap-style.node.fill == auto {
        zap-style.node.fill = zap-style.stroke.paint
    }
    zap-style = cetz.styles.resolve(zap-style)
    if zap-style.inductor.fall == "zap-auto" {
        zap-style.inductor.fall = zap-style.wire.stroke.thickness / 2
    }
    return zap-style
}

#let set-params(..params) = {
    cetz.draw.set-ctx(ctx => {
        ctx.zap.params = cetz.util.merge-dictionary(ctx.zap.params, params.named())
        return ctx
    })
}
