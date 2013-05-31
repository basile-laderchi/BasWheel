// outer_diameter
// outer_thickness
// wheel_height
// hub_diameter
// hub_type (servo, screw_size)
// servo_hub_thickness
// servo_hub_extra_height
// servo_hole_count
// servo_attachment_height
// rim_width
// rim_height
// spoke_count
// spoke_thickness
// spoke_type (double_left, double_right, left, right)
tire(60, 2, 10, 3, "servo", 5, 2, 6, 2, 1, 1, 6, 1, "left", $fn=100);

/*
 * NPT (Non Pneymatic Tire) v1.07
 *
 * by Basile Laderchi
 *
 * Licensed under Creative Commons Attribution-ShareAlike 3.0 Unported http://creativecommons.org/licenses/by-sa/3.0/
 *
 * v 1.07, 31 May 2013: Fix servo hub (added a small distance between the main hub and the servo hub)
 * v 1.06, 29 May 2013: Added servo hub
 * v 1.05, 27 May 2013: $fn deleted from file and included in function call
 * v 1.04, 24 May 2013: Added spoke_type "double_right", changed "both" to "double_left"
 * v 1.03, 23 May 2013: Added parameter Screw_size and calculation of hub based on it
 * v 1.02, 22 May 2013: Screw shaft
 * v 1.01, 21 May 2013: Rim added
 * v 1.00, 20 May 2013: Initial release
 *
 */

// http://www.thingiverse.com/thing:6021
use <Libs.scad>

module tire(outer_diameter, outer_thickness, height, hub_diameter, hub_type, servo_hub_thickness, servo_hub_extra_height, servo_hole_count, servo_attachment_height, rim_width, rim_height, spoke_count, spoke_thickness, spoke_type) {
	outer_radius = outer_diameter / 2;
	hub_radius = hub_diameter / 2;
	hub_screw_thickness = tableEntry (hub_type, "nutThickness") * 2;
	hub_screw_outer_radius = hub_radius + hub_screw_thickness;
	hub_servo_outer_radius = hub_radius + servo_hub_thickness;
	spoke_outer_radius = outer_radius - max((outer_thickness - spoke_thickness), 0);

	union() {
		if (hub_type == "servo") {
			hub(hub_type, hub_radius, servo_hub_thickness, servo_hub_extra_height, servo_hole_count, servo_attachment_height, height);
			spokes(hub_servo_outer_radius, outer_thickness, height, spoke_outer_radius, spoke_thickness, spoke_count, spoke_type);
		} else {
			hub(hub_type, hub_radius, hub_screw_thickness, 0, servo_hole_count, servo_attachment_height, height);
			spokes(hub_screw_outer_radius, outer_thickness, height, spoke_outer_radius, spoke_thickness, spoke_count, spoke_type);
		}
		ring(outer_radius, outer_thickness, height);
		rims(outer_radius, height, rim_width, rim_height);
	}
}

module hub(hub_type, inner_radius, thickness, servo_hub_extra_height, servo_hole_count, servo_attachment_height, wheel_height) {
	padding = 1;

	radius = inner_radius + thickness;
	height = wheel_height + tableEntry (hub_type, "studDiameter") + 2;
	hole_z = (height - wheel_height) / 2 + wheel_height / 2;
	upper_nut_z = (height - wheel_height) / 2 + hole_z;
	nut_x = radius - thickness + 0.5;

	if (hub_type == "servo") {
		union() {
			ring(radius, thickness, wheel_height);
			servo_hub(inner_radius, servo_hub_extra_height, servo_hole_count, servo_attachment_height, wheel_height, radius, $fn=360);
		}
	} else {
		difference() {
			union() {
				ring(radius, thickness, wheel_height);
				translate([0, 0, height / 2]) {
					ring(radius, thickness, height - wheel_height);
				}
			}
			translate([0, 0, hole_z]) {
				rotate([0, 90, 0]) {
					bolt(hub_type, radius + padding);
				}
			}
			hull() {
				translate([nut_x, 0, hole_z]) {
					rotate([0, 90, 0]) {
						hexNut(hub_type, false, true);
					}
				}
				translate([nut_x, 0, upper_nut_z]) {
					rotate([0, 90, 0]) {
						hexNut(hub_type, false, true);
					}
				}
			}
		}
	}
}

module servo_hub(hub_inner_radius, servo_hub_extra_height, servo_hole_count, servo_attachment_height, wheel_height, hub_radius) {
	padding = 0.1;

	translate([0, 0, wheel_height / 2]) {
		difference() {
			union() {
				cylinder(r=hub_radius, h=servo_hub_extra_height);
				translate([0, 0, servo_hub_extra_height]) {
					cylinder(r=18, h=servo_attachment_height);
				}
			}
			translate([0, 0, -padding]) {
				cylinder(r=hub_inner_radius, h=servo_attachment_height + servo_hub_extra_height + padding * 2);
			}
			for (i = [0 : servo_hole_count - 1]) {
				rotate([0, 0, i * 360 / servo_hole_count]) {
					hull() {
						translate([0, 5, -padding]) {
							cylinder(r=.75, h=servo_attachment_height + servo_hub_extra_height + padding * 2, $fn=6);
						}
						translate([0, 14, -padding]) {
							cylinder(r=.75, h=servo_attachment_height + servo_hub_extra_height + padding * 2, $fn=6);
						}
					}
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
			} else if (spoke_type == "right") {
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
