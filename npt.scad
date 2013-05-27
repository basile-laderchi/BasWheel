// outer_diameter
// outer_thickness
// height
// hub_diameter
// hub_screw_size
// rim_width
// rim_height
// spoke_count
// spoke_thickness
// spoke_type (double_left, double_right, left, right)
tire(60, 2, 10, 3, "M3", 1, 1, 6, 1, "left", $fn=100);

/*
 * NPT (Non Pneymatic Tire) v1.05
 *
 * by Basile Laderchi
 *
 * Licenced under Creative Commons Attribution-ShareAlike 3.0 Unported http://creativecommons.org/licenses/by-sa/3.0/
 *
 * v 1.05, 27 May 2013: $fn deleted from file and included in function call
 * v 1.04, 24 May 2013: Added spoke_type "double_right", changed "both" to "double_left"
 * v 1.03, 23 May 2013: Added parameter Screw_size and calculation of hub based on it
 * v 1.02, 22 May 2013: Screw shaft
 * v 1.01, 21 May 2013: Rim added
 * v 1.00, 20 May 2013: Initial release
 *
 * notes:
 * Servo horn attachment
 * a disk that screws to the servo horn then a tube that sips over the hub which is kept inplace my the M3 scre
 * 
 */

// http://www.thingiverse.com/thing:6021
use <Libs.scad>

module tire(outer_diameter, outer_thickness, height, hub_diameter, hub_screw_size, rim_width, rim_height, spoke_count, spoke_thickness, spoke_type) {
	outer_radius = outer_diameter / 2;
	hub_radius = hub_diameter / 2	;
	hub_thickness = tableEntry (hub_screw_size, "nutThickness") * 2;
	hub_outer_radius = hub_radius + hub_thickness;
	spoke_outer_radius = outer_radius - max((outer_thickness - spoke_thickness), 0);

	union() {
		hub(hub_radius, hub_thickness, hub_screw_size, height);
		spokes(hub_outer_radius, outer_thickness, height, spoke_outer_radius, spoke_thickness, spoke_count, spoke_type);
		ring(outer_radius, outer_thickness, height);
		rims(outer_radius, height, rim_width, rim_height);
	}
}

module hub(inner_radius, thickness, hub_screw_size, wheel_height) {
	padding = 1;

	radius = inner_radius + thickness;
	height = wheel_height + tableEntry (hub_screw_size, "studDiameter") + 2;
	hole_z = (height - wheel_height) / 2 + wheel_height / 2;
	upper_nut_z = (height - wheel_height) / 2 + hole_z;
	nut_x = radius - thickness + 0.5;

	difference() {
		translate([0, 0, max((height - wheel_height) / 2, 0)]) {
			ring(radius, thickness, max(wheel_height, height));
		}
		translate([0, 0, hole_z]) {
			rotate([0, 90, 0]) {
				bolt(size=hub_screw_size, length=radius + padding);
			}
		}
		hull() {
			translate([nut_x, 0, hole_z]) {
				rotate([0, 90, 0]) {
					hexNut(size=hub_screw_size, center=false, outline=true);
				}
			}
			translate([nut_x, 0, upper_nut_z]) {
				rotate([0, 90, 0]) {
					hexNut(size=hub_screw_size, center=false, outline=true);
				}
			}
		}
	}
}

module spokes(hub_radius, thickness, height, spoke_outer_radius, spoke_thickness, spoke_count, spoke_type) {
	for (i = [0 : spoke_count - 1]) {
		rotate([0, 0, i * (360 / spoke_count)]) {
			if (spoke_type == "double_left") {
				translate([0, 0, height / 4]) {
					spoke(spoke_outer_radius, hub_radius, min(spoke_thickness, thickness), height / 2, true);
				}
				translate([0, 0, -height / 4]) {
					spoke(spoke_outer_radius, hub_radius, min(spoke_thickness, thickness), height / 2, false);
				}
			} else if (spoke_type == "double_right"){
				translate([0, 0, height / 4]) {
					spoke(spoke_outer_radius, hub_radius, min(spoke_thickness, thickness), height / 2, false);
				}
				translate([0, 0, -height / 4]) {
					spoke(spoke_outer_radius, hub_radius, min(spoke_thickness, thickness), height / 2, true);
				}
			} else if (spoke_type == "right"){
				spoke(spoke_outer_radius, hub_radius, min(spoke_thickness, thickness), height, false);
			} else if (spoke_type == "left" ) {
				spoke(spoke_outer_radius, hub_radius, min(spoke_thickness, thickness), height, true);
			}
		}
	}
}

module spoke(outer_radius, inner_radius, thickness, height, reverse) {
	padding = 1;

	spoke_radius = (outer_radius + inner_radius) / 2;

	translate([0, spoke_radius - inner_radius, 0]) {
		difference() {
			ring(spoke_radius, thickness, height);
			if (reverse) {
				translate([-spoke_radius + padding / 2, 0, 0]) {
					cube(size=spoke_radius * 2 + padding, center=true);
				}
			} else {
				translate([spoke_radius + padding / 2, 0, 0]) {
					cube(size=spoke_radius * 2 + padding, center=true);
				}
			}
		}
	}
}

module ring(radius, thickness, height) {
	padding = 0.1;

	inner_radius = radius - thickness;

	difference() {
		cylinder(r=radius, h=height, center=true);
		cylinder(r=inner_radius, h=height + padding, center=true);
	}
}

module rims(radius, height, rim_width, rim_height) {
	translate([0, 0, (height - rim_height) / 2]) {
		difference() {
			rim(radius, height, rim_width, rim_height);
		}
	}
	translate([0, 0, -(height - rim_height) / 2]) {
		rim(radius, height, rim_width, rim_height);
	}
}

module rim(radius, height, rim_width, rim_height) {
	padding = 0.1;

	outer_radius = radius + rim_width;

	difference() {
		cylinder(r=outer_radius, h=rim_height, center=true);
		cylinder(r=radius, h=rim_height + padding, center=true);
	}
}

module bolt(size, length) {
	stud = tableEntry (size, "studDiameter");	

	cylinder(r=stud/2, h=length, $fn=resolution(stud/2));
}
