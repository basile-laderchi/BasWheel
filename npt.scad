outer_diameter = 60;
outer_thickness = 1;
wheel_height = 10;
hub_type = "lego"; // (servo, lego, screw_size)
hub_diameter = 5;
hub_thickness = 5;
servo_hub_extra_height = 2;
servo_hole_count = 6;
servo_attachment_height = 2;
rim_width = 1;
rim_height = 1;
spoke_type = "left"; // (double_left, double_right, left, right)
spoke_count = 6;
spoke_thickness = 1;
spoke_support = 25; // (angle between 5 an 85 degrees)

/*
 * NPT (Non Pneumatic Tire / Airless Tire) v1.09
 *
 * by Basile Laderchi
 *
 * Licensed under Creative Commons Attribution-ShareAlike 3.0 Unported http://creativecommons.org/licenses/by-sa/3.0/
 *
 * v 1.09, 6 June 2013: Added hub_type "lego" and added all the variables on top of the file (Customizer ready - not working yet due to imported libraries and external stl file)
 * v 1.08, 5 June 2013: Added support from spoke to wheel
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

tire(outer_diameter, outer_thickness, wheel_height, hub_type, hub_diameter, hub_thickness, servo_hub_extra_height, servo_hole_count, servo_attachment_height, rim_width, rim_height, spoke_type, spoke_count, spoke_thickness, spoke_support, $fn=100);

// http://www.thingiverse.com/thing:6021
use <Libs.scad>
use <MCAD/triangles.scad>

module tire(outer_diameter, outer_thickness, height, hub_type, hub_diameter, hub_thickness, servo_hub_extra_height, servo_hole_count, servo_attachment_height, rim_width, rim_height, spoke_type, spoke_count, spoke_thickness, spoke_support) {
	outer_radius = outer_diameter / 2;
	hub_radius = hub_diameter / 2;
	hub_screw_thickness = tableEntry(hub_type, "nutThickness") * 2;
	hub_screw_outer_radius = hub_radius + hub_screw_thickness;
	hub_other_outer_radius = hub_radius + hub_thickness;
	spoke_outer_radius = outer_radius - max((outer_thickness - spoke_thickness), 0);

	union() {
		if (hub_type == "servo" || hub_type == "lego") {
			hub(hub_type, hub_radius, hub_thickness, servo_hub_extra_height, servo_hole_count, servo_attachment_height, height);
			spokes(spoke_type, hub_other_outer_radius, outer_thickness, height, spoke_outer_radius, spoke_thickness, spoke_count, spoke_support);
		} else if (tableRow(hub_type) != -1) {
			hub(hub_type, hub_radius, hub_screw_thickness, 0, servo_hole_count, servo_attachment_height, height);
			spokes(spoke_type, hub_screw_outer_radius, outer_thickness, height, spoke_outer_radius, spoke_thickness, spoke_count, spoke_support);
		}
		ring(outer_radius, outer_thickness, height);
		rims(outer_radius, rim_width, rim_height, height);
	}
}

module hub(type, inner_radius, thickness, servo_extra_height, servo_hole_count, servo_attachment_height, tire_height) {
	padding = 1;

	radius = inner_radius + thickness;
	height = tire_height + tableEntry(type, "studDiameter") + 2;
	hole_z = (height - tire_height) / 2 + tire_height / 2;
	upper_nut_z = (height - tire_height) / 2 + hole_z;
	nut_x = radius - thickness + 0.5;

	lego_piece_height = 15.6;
	lego_piece_size = 4.72;
	lego_piece_size_new = 4.85;

	if (type == "servo") {
		union() {
			ring(radius, thickness, tire_height);
			servoHub(radius, inner_radius, servo_extra_height, servo_hole_count, servo_attachment_height, tire_height);
		}
	} else if (type == "lego") {
		difference() {
			cylinder(r=radius, h=tire_height, center=true);
			rotate([0, 90, 0]) {
				translate([-(tire_height + padding * 2) / 2, -lego_piece_size_new / 2, -lego_piece_size_new / 2]) {
					scale([(tire_height + padding * 2) / lego_piece_height, lego_piece_size_new / lego_piece_size, lego_piece_size_new / lego_piece_size]) {
						import("LegoAxleSize2.stl");
					}
				}
			}
		}
	} else if (tableRow(type) != -1) {
		difference() {
			union() {
				ring(radius, thickness, tire_height);
				translate([0, 0, height / 2]) {
					ring(radius, thickness, height - tire_height);
				}
			}
			translate([0, 0, hole_z]) {
				rotate([0, 90, 0]) {
					bolt(type, radius + padding);
				}
			}
			hull() {
				translate([nut_x, 0, hole_z]) {
					rotate([0, 90, 0]) {
						hexNut(type, false, true);
					}
				}
				translate([nut_x, 0, upper_nut_z]) {
					rotate([0, 90, 0]) {
						hexNut(type, false, true);
					}
				}
			}
		}
	}
}

module servoHub(radius, inner_radius, extra_height, hole_count, attachment_height, tire_height) {
	padding = 0.1;

	translate([0, 0, tire_height / 2]) {
		difference() {
			union() {
				cylinder(r=radius, h=extra_height);
				translate([0, 0, extra_height]) {
					cylinder(r=18, h=attachment_height);
				}
			}
			translate([0, 0, -padding]) {
				cylinder(r=inner_radius, h=attachment_height + extra_height + padding * 2);
			}
			for (i = [0 : hole_count - 1]) {
				rotate([0, 0, i * 360 / hole_count]) {
					hull() {
						translate([0, 5, -padding]) {
							cylinder(r=.75, h=attachment_height + extra_height + padding * 2);
						}
						translate([0, 14, -padding]) {
							cylinder(r=.75, h=attachment_height + extra_height + padding * 2);
						}
					}
				}
			}
		}
	}
}

module spokes(type, hub_radius, tire_thickness, height, outer_radius, thickness, count, support) {
	intersection() {
		cylinder(r=outer_radius - tire_thickness / 2, h=height, center=true);
		for (i = [0 : count - 1]) {
			rotate([0, 0, i * (360 / count)]) {
				if (type == "double_left") {
					translate([0, 0, height / 4]) {
						spoke(outer_radius, hub_radius, min(thickness, tire_thickness), height / 2, support, true);
					}
					translate([0, 0, -height / 4]) {
						spoke(outer_radius, hub_radius, min(thickness, tire_thickness), height / 2, support, false);
					}
				} else if (type == "double_right"){
					translate([0, 0, height / 4]) {
						spoke(outer_radius, hub_radius, min(thickness, tire_thickness), height / 2, support, false);
					}
					translate([0, 0, -height / 4]) {
						spoke(outer_radius, hub_radius, min(thickness, tire_thickness), height / 2, support, true);
					}
				} else if (type == "right") {
					spoke(outer_radius, hub_radius, min(thickness, tire_thickness), height, support, false);
				} else if (type == "left" ) {
					spoke(outer_radius, hub_radius, min(thickness, tire_thickness), height, support, true);
				}
			}
		}
	}
}

module spoke(outer_radius, inner_radius, thickness, height, support, reverse) {
	padding = 1;

	radius = (outer_radius + inner_radius) / 2;
	triangle_x = outer_radius - (thickness / 2);

	union() {
		translate([0, radius - inner_radius, 0]) {
			difference() {
				ring(radius, thickness, height);
				if (reverse) {
					translate([-radius + padding / 2, 0, 0]) {
						cube(size=radius * 2 + padding, center=true);
					}
				} else {
					translate([radius + padding / 2, 0, 0]) {
						cube(size=radius * 2 + padding, center=true);
					}
				}
			}
		}
		if (support >= 5 && support <= 85) {
			difference() {
				translate([0, outer_radius, -height / 2]) {
					if (reverse) {
						rotate([0, 0, -90]) {
							a_triangle(support, outer_radius, height);
						}
					} else {
						mirror([1, 1, 0]) {
							a_triangle(support, outer_radius, height);
						}
					}
				}
				translate([0, radius - inner_radius, 0]) {
					cylinder(r=radius - thickness, h=height + padding, center=true);
				}
			}
		}
	}
}

module rims(radius, width, height, tire_height) {
	translate([0, 0, (tire_height - height) / 2]) {
		difference() {
			rim(radius, width, height);
		}
	}
	translate([0, 0, -(tire_height - height) / 2]) {
		rim(radius, width, height);
	}
}

module rim(radius, width, height) {
	padding = 0.1;

	outer_radius = radius + width;

	difference() {
		cylinder(r=outer_radius, h=height, center=true);
		cylinder(r=radius, h=height + padding, center=true);
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

module bolt(size, length) {
	stud = tableEntry(size, "studDiameter");	

	cylinder(r=stud / 2, h=length, $fn=resolution(stud / 2));
}
