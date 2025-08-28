// All components
// wire, node, capacitor, diode, led, photodiode, schottky, tunnel, zener, opamp, switch, afuse, fuse, earth, frame, ground, vcc, vee, inductor, heater, potentiometer, resistor, rheostat, acvsource, disource, dvsource, isource, vsource, acmotor, dcmotor, bjt, npn, pnp, mosfet, nmos, nmosd, pmos, pmosd

#let default = (
    style: (
        variant: "iec",
        scale: (x: 1.0, y: 1.0),
        stroke: (
            thickness: .6pt,
            paint: black
        ),
        label: (
            variant: auto,
            scale: auto,
            content: none,
            distance: 7pt,
            anchor: "north",
            tolerance: 15
        ),
        pin: (
            variant: auto,
            stroke: auto,
            length: 24pt
        ),
        node: (
            radius: .04,
            stroke: auto,
            fill: auto,
            nofill: white
        ),
        wire: (
            variant: auto,
            stroke: auto
        ),
        debug: (
            radius: .7pt,
            stroke: (
                thickness: .2pt,
                paint: red
            ),
            angle: -30deg,
            shift: 3pt,
            font: 3pt,
            fill: red
        ),

        // Components
        capacitor: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        diode: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        led: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        photodiode: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        schottky: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        tunnel: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        zener: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        opamp: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        switch: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        afuse: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        fuse: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        earth: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        frame: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        ground: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        vcc: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        vee: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        inductor: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        heater: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        potentiometer: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        resistor: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        rheostat: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        acvsource: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        disource: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        dvsource: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        isource: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        vsource: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        acmotor: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        dcmotor: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        bjt: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        npn: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        pnp: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        mosfet: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        nmos: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        nmosd: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        pmos: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
        pmosd: (
            variant: auto,
            scale: auto,
            stroke: auto
        ),
    ),
    params: (
        debug: false
    )
)
