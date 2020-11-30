//This one is the simplest...
file="svg/crown_meeple.svg";

linear_extrude(height=10,center=true) import(file, center=true);
//for size comparison
//translate([50, 0, 0]) linear_extrude(height=10,center=true) import("svg/sun_meeple.svg", center=true);
