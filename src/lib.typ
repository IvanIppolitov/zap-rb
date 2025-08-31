// Import dependencies
#import "dependencies.typ": cetz
#import cetz.draw as draw
#import "/src/canvas.typ": canvas
#import "/src/utils.typ": set-style, get-style, set-params

// Import components
#import "component.typ": component
#import "interface.typ": interface

// Import components
#import "components/wire.typ": wire
#import "components/node.typ": node
#import "components/capacitor.typ": capacitor
#import "components/diode.typ": diode, led, photodiode, schottky, tunnel, zener
#import "components/opamp.typ": opamp
#import "components/switch.typ": switch
#import "components/fuse.typ": afuse, fuse
#import "components/supply.typ": vcc, vee, ground, tlground, rground, sground, tground, nground, pground, cground
#import "components/inductor.typ": inductor
#import "components/resistor.typ": heater, potentiometer, resistor, rheostat
#import "components/source.typ": vsource, dvsource, acvsource, isource, disource, acisource
#import "components/motor.typ": acmotor, dcmotor

// Import transistors
#import "components/transistors/bjt.typ": bjt, npn, pnp
#import "components/transistors/mosfet.typ": mosfet, nmos, nmosd, pmos, pmosd
