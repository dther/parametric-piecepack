//variables
// dimensions
size=60;
thickness=3;
inlay_depth=0.4;

font="Liberation Sans:style=Bold";

//symbols
ace="svg/moon_large.svg";
corner="svg/moon_small.svg";
corner_size=size/4;
/*
ace="svg/sun_large.svg";
corner="svg/sun_small.svg";
corner_size=size/4;
*/
/*
ace="svg/crown_large.svg";
corner="svg/crown_small.svg";
corner_size=size/4;
*/
/*
ace="svg/arms_large.svg";
corner="svg/arms_small.svg";
corner_size=size/4;
*/

module inlay(rank="", rank_file, corner_file=corner, size=size, depth=inlay_depth, font=font, corner_size=corner_size) {
    translate([0, 0, -(thickness/2)+(depth/2)]) mirror([1,0,0]) {
        union() {
        //Center
        if(rank_file==undef) {
            //0.001 added to remove the surface. makes it hard to align stuff on the build plate.
            linear_extrude(height=depth+0.001, center=true) text(rank, size=size/2, font=font, halign="center", valign="center");
        }
        else {
            linear_extrude(height=depth+0.001, center=true) resize([size/2, size/2, 0]) import(rank_file, center=true);
        }
        
        //corner
        translate([-size/3, size/3, 0]) resize([corner_size, corner_size, 0]) linear_extrude(height=depth+0.001, center=true) import(corner_file, center=true);
        }
    }
}

module tile_body(size=size, thickness=thickness) {
    cube([size,size,thickness], center=true);
}

module top_cross(size=size, tile_thickness=thickness, cross_thickness=inlay_depth) {
    translate([0,0,tile_thickness/2+cross_thickness/2]) {
        union() {
            cube([size/2, 2, cross_thickness], center=true);
            cube([2, size/2, cross_thickness], center=true);
        }
    }
}

module top_corners(size=size, tile_thickness=thickness, top_thickness=inlay_depth) {
    translate([0,0,tile_thickness/2+top_thickness/2]) difference() {
        //TODO
        cube([size, size, top_thickness], center=true);
        cube([size-4, size-4, top_thickness], center=true);
        cube([size/2, size, top_thickness], center=true);
        cube([size, size/2, top_thickness], center=true);
    }
}

module tile(rank="", rank_file, thickness=thickness, size=size) {
union() {
difference() {
    tile_body();
    if (rank_file==undef) {
        inlay(rank=rank, corner_size=corner_size);
    }
    else {
        inlay(rank_file=rank_file, corner_size=corner_size);
    }
}
top_cross();
top_corners();
}
}


translate([-(size+5), 0, 0]) tile();
tile(rank_file=ace);
translate([0, size+5, 0])tile(rank="2");
translate([size+5, 0, 0])tile(rank="3");
translate([size+5, size+5, 0])tile(rank="4");
translate([-(size+5), (size+5), 0 ])tile(rank="5");

/*
translate([-(size+5), 0, 0]) inlay();
inlay(rank_file=ace);
translate([0, size+5, 0])inlay(rank="2");
translate([size+5, 0, 0])inlay(rank="3");
translate([size+5, size+5, 0])inlay(rank="4");
translate([-(size+5), (size+5), 0 ])inlay(rank="5");
*/
