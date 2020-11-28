# Dther's 3D-Printed Parametric Piecepack
(or, the 3DPPP.)

There are a few 3D printed piecepacks floating around.
Unfortunately, all of them have the caveat that they're mono-coloured,
unless you're willing to paint.
Which I'm not.

This project is my attempt at rectifying this problem.
Not only is every piece coloured,
it should, theoretically,
be printable using nothing more than a single-extruder 3d printer
and an absurd number of filament changes.
(I don't have a multi-extrusion printer...)

I'm making this in OpenSCAD.
I only need to "make" one suit, and the rest can be generated
by simply changing the parameters to another suit.
As a bonus, I can also print out the expansions (e.g. Four seasons, elements, card suits)
by simply introducing new .svg files.

## Design Goals

All the models produced by these files should:
 - Be printable on a single-extruder, consumer FFD printer,
 - Be multi-coloured
 - Require next to no post processing. Anything more complicated than pulling off ooze strings and using a sharpie should be optional.

## Licensing

Everything here is provided under [CC-BY-SA-4.0](https://creativecommons.org/licenses/by-sa/4.0/).
The dice.scad file requires the [OpenSCAD BOSL library](https://github.com/revarbat/BOSL)
(The OpenSCAD Belfry OpenSCAD Library library), which is licensed under BSD 2-Clause license.
