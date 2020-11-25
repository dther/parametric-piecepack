// This one is the most complicated piece.
// It has to be a net of a cube, which when folded snaps together into a die.
// Faces should be customisable with .svg files.
// This allows for faces to have coloured inlays, 3d printed, with the die "on top".
// See Devin Montes' (MakeAnything)'s multipass 3d printed foldable dice.
// I'd remix it, but the license is incompatible with what I'm trying to do.

// function for finding dimensional difference between top and bottom face:
// basically in short use tan(90/2)
// we know opposite because opposite is desired face thickness
// hypotenuse is irrelevant and we're trying to find adjacent
// because 2*adjacent is equal to how much smaller the upper face needs to be
// vs the base

include <src/BOSL/constants.scad>
use <src/BOSL/shapes.scad>

// Variables
// Dimensions
//tested (sizes, thickness, pin dia, pin len): (22,1,4,6)
face_thickness=1;
face_size=22;
pin_diameter=4;
pin_length=6;
face_plate=0.5;

// Faces (SVG files)
face_1="svg/sun_small_new.svg"; // Ace
face_2=""; // 2
face_3=""; // 3
face_4=""; // 4
face_5=""; // 5
face_6=""; // Null

// Constants
DIHEDRAL_ANGLE=45; //dihedral angle of a square

module face_trunc_pyramid(thickness, size) {
    //TODO: this
    //i don't know if this is right. Investigate.
    // hey hey hey! I used high school math to solve a problem!
    difference=(thickness/tan(DIHEDRAL_ANGLE))*2;
    union() {
        prismoid([size, size], [size-difference, size-difference],
                thickness);
        cube([size, size, face_plate], true);
    }
};

module hinge_socket(diameter, length) {
    union() {
        difference() {
            cyl(length+5, d=diameter, orient=ORIENT_X, $fn = 20);
            hinge_pin(diameter+0.1, length+1);
        }
        //TODO: add support?
    }

};

module hinge_pin(diameter, length) {
    //TODO: this
    union() {
        cyl(length, d=diameter, chamfer=1,chamfang=45, orient=ORIENT_X, $fn = 20);
        translate([0,0,-diameter/2]) {
            cube([length-2, diameter/2, diameter/2], true);
        }
    }
}

module face(thickness=1, size=22, pin_diameter=4, pin_length=6, symbol="", number) {
    //TODO:this
    face_difference=(thickness/tan(DIHEDRAL_ANGLE));
    pin_position=(size/2)-face_difference-(pin_diameter/2);
    union() {
        //agh
        difference() {
            face_trunc_pyramid(thickness, size);
            if (number == undef) {
            linear_extrude(height=0.5, center=true) resize([size/2,size/2,0]) import(symbol, center=true);
            }
            else {
            linear_extrude(height=0.5, center=true) mirror([1,0,0]) text(number, font="Liberation Sans:style=Bold", valign="center", halign="center");
            }
            //Hmm.
        }
        translate([0, pin_position, thickness+pin_diameter/2]){ //find less hacky and inexact pin spacing method
            hinge_socket(pin_diameter, pin_length);
        }
        translate([0, -pin_position, thickness+pin_diameter/2]){
            hinge_socket(pin_diameter, pin_length);
        }
        rotate([0,0,90]) {
            translate([0, pin_position, thickness+pin_diameter/2]){
                hinge_pin(pin_diameter, pin_length);
            }
            translate([0, -pin_position, thickness+pin_diameter/2]){
                hinge_pin(pin_diameter, pin_length);
            }
        }
    }
}

/*
face_trunc_pyramid(face_thickness, face_size);
translate([0,0,4.5]){
hinge_socket(4);
hinge_pin(4);
}
*/
/*
difference() {
union() {
face(face_thickness, face_size, pin_diameter, pin_length);
translate([face_size,0,0]) rotate([0,0,90]) face(face_thickness, face_size, pin_diameter, pin_length);
translate([-face_size,0,0]) rotate([0,0,90]) face(face_thickness, face_size, pin_diameter, pin_length);
translate([2*face_size,0,0]) face(face_thickness, face_size, pin_diameter, pin_length);
translate([0,face_size,0]) rotate([0,0,90]) face(face_thickness, face_size, pin_diameter, pin_length);
translate([0,-face_size,0]) rotate([0,0,90]) face(face_thickness, face_size, pin_diameter, pin_length);
}
*/
union() {
face(face_thickness, face_size, pin_diameter, pin_length, symbol=face_1);
translate([face_size,0,0]) rotate([0,0,90]) face(face_thickness, face_size, pin_diameter, pin_length, number="4");
translate([-face_size,0,0]) rotate([0,0,90]) face(face_thickness, face_size, pin_diameter, pin_length, number="3");
translate([2*face_size,0,0]) face(face_thickness, face_size, pin_diameter, pin_length);
translate([0,face_size,0]) rotate([0,0,90]) face(face_thickness, face_size, pin_diameter, pin_length, number="5");
translate([0,-face_size,0]) rotate([0,0,90]) face(face_thickness, face_size, pin_diameter, pin_length, number="2");
}
/*
}*/
