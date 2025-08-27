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
