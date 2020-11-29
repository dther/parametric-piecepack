diameter = 24; // Should be less than or equal to half of the tile's size.
thickness = 3;
//You'll want to pause the print and change filaments at layer (thickness/0.1), assuming a layer height of 0.1.
inlay_depth = 0.4; // Depth of suit inlay. Should be dependent on layer height.
//suit = "svg/moon_small.svg"; //svg of suit.
//suit = "svg/sun_small.svg";
//suit = "svg/crown_small.svg";
suit = "svg/arms_small.svg";
ace_file = "svg/coin_ace.svg"; //svg of ace.

/* Extrude a cylinder... */
module coin_body(diameter, thickness) {
    cylinder(thickness, d=diameter, center=false);
}

/* Generate inlay from svg file */
module suit_inlay(file, height, diameter) {
    linear_extrude(height = height)
        resize([diameter/2, 0, 0], auto=true)
            rotate([0,0,90]) mirror([0,1,0]) import(file=file, center=true);
}

module direction_inlay(height, diameter) {
    union() {
    intersection() {
        linear_extrude(height = height) circle(d=diameter-2);
        linear_extrude(height = height)  translate([diameter*0.8,0,0]) circle(d=diameter-2);
    }
    difference() {
        linear_extrude(height = height) circle(d=diameter-2);
        linear_extrude(height = height) circle(d=diameter-4);
    }
    }
}

module rank_direction(height,diameter) {
    intersection() {
        linear_extrude(height = height) circle(d=diameter);
        linear_extrude(height = height) translate([diameter*0.8,0,0]) circle(d=diameter-2);
    }
    difference() {
        linear_extrude(height = height) circle(d=diameter);
        linear_extrude(height = height) circle(d=diameter-2);
    }
}

module rank(height, diameter, rank, file) {
    rotate([0, 0, -90]) linear_extrude(height=height) {
        if (file==undef) {
            text(rank, halign="center", valign="center", font="Liberation Sans:style=Bold");
        }
        else {
            resize([diameter/2, diameter/2]) import(file, center=true);
        }
    }
}

module coin(diameter=diameter, thickness=thickness, suit=suit, inlay_depth=inlay_depth, rank="", file) {
    union() {
    difference() {
        coin_body(diameter, thickness);
        suit_inlay(suit, inlay_depth, diameter);
        direction_inlay(inlay_depth, diameter);
    }
    translate([0,0,thickness]){
        rank_direction(inlay_depth, diameter);
        rank(inlay_depth, diameter, rank, file);
    }
    }
}

/*
difference() {
union() {
translate([diameter+5, 0,0])
coin_body(diameter=diameter-1, thickness=thickness);
coin_body(diameter=diameter-1, thickness=thickness);
translate([diameter+5, -(diameter+5) ,0]) 
coin_body(diameter=diameter-1, thickness=thickness);
translate([0, diameter+5, 0])
coin_body(diameter=diameter-1, thickness=thickness);
translate([0, -(diameter+5), 0])
coin_body(diameter=diameter-1, thickness=thickness);
translate([diameter+5, diameter+5, 0])
coin_body(diameter=diameter-1, thickness=thickness);
}
*/
union() {
translate([diameter+5, 0,0]) coin();
coin(file=ace_file);
translate([diameter+5, -(diameter+5) ,0]) coin(rank="2");
translate([0, diameter+5, 0]) coin(rank="3");
translate([0, -(diameter+5), 0]) coin(rank="4");
translate([diameter+5, diameter+5, 0]) coin(rank="5");
}
//}
