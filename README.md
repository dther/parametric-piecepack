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

## HOW TO PRINT

I'm not done with this section yet, but some recommended ~~reading~~ watching:
 - [Single Extruder Multicolor in Cura Tutorial // Multipass 3D Printing](https://www.youtube.com/watch?v=D7FiT5VqLSg)
 - [Multi Color 3D Print in CURA 3 on Creality Ender 3](https://www.youtube.com/watch?v=1nBnVtOEAiY)

**NOTE!** *Some 3D printers don't properly recognise "Pause" instructions. In particular, mine, an Anycubic I3 MEGA-S,
needed [this script.](https://www.thingiverse.com/thing:4160010/comments) Yours might need an alternative script as well!*

In short, to print the multicoloured components, you need to:
 1. Set your slicer to 0.1mm layer height
 2. Put both the inlay and non-inlay models on the plate
 3. Align inlay models with non-inlay models
 4. Delete the non-inlay models, slice the gcode
 5. Print the inlay
 6. Delete the inlay models and plate the inlay models once more in the exact same position
 7. Set Z-Hop to a value higher than the inlay height (1mm should be more than enough)
 8. **OPTIONAL** If you'd like the top cross and the coin ranks to be coloured, *pause at layer 30* and switch filaments. This isn't necessary on the dice, since the pins fold inside.
 9. Slice and print this while the inlays are still on the bed
 10. If you performed step 8, swap those filaments when the time comes!
 11. Repeat for all the other tiles, dice and coins.

Alternatively, you can just print the pieces in white and paint them all by hand.

### Assembling the dice

Some tips on folding the dice:
 - Be gentle. PLA can be brittle.
 - The inlays can peel off the bed very easily. Don't be shy with the gluestick.
 - They're easier to fold while still warm off the printer.
 - But, they might warp when they're still warm. Take care to only bend at the creases and to avoid bending the faces.
 - If the pins break off/don't hold it square enough for your liking, a 3d pen or a lighter and a steady hand should be enough to melt the edges together.
 Do be careful.

## Licensing

Everything here is provided under [CC-BY-NC-SA-4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/).
The dice.scad file requires the [OpenSCAD BOSL library](https://github.com/revarbat/BOSL)
(The OpenSCAD Belfry OpenSCAD Library library), which is licensed under BSD 2-Clause license.
