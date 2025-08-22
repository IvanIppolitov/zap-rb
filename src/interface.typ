#import "dependencies.typ": cetz

#let interface(node-a, node-b, ..params) = {
    import cetz.draw: *

    hide(rect(node-a, node-b, name: "bounds"))
}
