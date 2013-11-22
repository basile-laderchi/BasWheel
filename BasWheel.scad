outer_diameter = 60;
outer_thickness = 1;
wheel_height = 10;
hub_type = "hubattachment"; // (servo, servohead, lego, stepper, hubattachment, no, screw_size)
hub_diameter = 5;
hub_thickness = 5;
servo_hub_extra_height = 2;
servo_hole_count = 6;
servo_attachment_height = 2;
stepper_axle_height = 6;
stepper_axle_OD = 5;
stepper_axle_ID = 3;
stepper_screw_OD = 5;
stepper_screw_ID = 3;
slot_OD = 10;
slot_height = 2;
magnet_offset = 3;
magnet_diameter = 6;
rim_width = 1;
rim_height = 1;
spoke_type = "spiral_left"; // (spiral_left_double, spiral_right_double, spiral_left, spiral_right, spring)
spoke_count = 6;
spoke_thickness = 1;
spoke_support = 25; // (angle between 5 an 85 degrees)
spring_segments = 6;

/*
 *
 * BasWheel v1.17
 *
 * by Basile Laderchi
 *
 * Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported http://creativecommons.org/licenses/by-nc-sa/3.0/
 *
 * v 1.17, 20 Nov 2013 : Changed license and added hub_type "hubattachment"
 * v 1.16, 18 Nov 2013 : Added hub_type "stepper" (built to match stepper type 28BYJ-48)
 * v 1.15, 18 Sep 2013 : Added hub_type "servohead"
 * v 1.14, 23 Jul 2013 : Added magnet_diameter (used if you need holes for neodymium magnets on the servo_hub) and magnet_offset parameters
 * v 1.13, 18 Jul 2013 : Added hub_type "no" used for push-fit axles
 * v 1.12, 18 Jul 2013 : Added spoke_type "spring", spring_segments variable, changed "double_left" to "spiral_left_double", "double_right" to "spiral_right_double", "left" to "spiral_left" and "right" to "spiral_right"
 * v 1.11, 19 Jun 2013 : Added small spacing between double spokes
 * v 1.10, 18 Jun 2013 : Fixed hub high for the screw to be able to be bolted
 * v 1.09,  6 Jun 2013 : Added hub_type "lego" and added all the variables on top of the file (Customizer ready - not working yet due to imported libraries and external stl file)
 * v 1.08,  5 Jun 2013 : Added support from spoke to wheel
 * v 1.07, 31 May 2013 : Fix servo hub (added a small distance between the main hub and the servo hub)
 * v 1.06, 29 May 2013 : Added servo hub
 * v 1.05, 27 May 2013 : $fn deleted from file and included in function call
 * v 1.04, 24 May 2013 : Added spoke_type "double_right", changed "both" to "double_left"
 * v 1.03, 23 May 2013 : Added parameter screw_size and calculation of hub based on it
 * v 1.02, 22 May 2013 : Screw shaft
 * v 1.01, 21 May 2013 : Rim added
 * v 1.00, 20 May 2013 : Initial release
 *
 */

basWheel(outer_diameter, outer_thickness, wheel_height, hub_type, hub_diameter, hub_thickness, servo_hub_extra_height, servo_hole_count, servo_attachment_height, stepper_axle_height, stepper_axle_OD, stepper_axle_ID, stepper_screw_OD, stepper_screw_ID, slot_OD, slot_height, magnet_offset, magnet_diameter, rim_width, rim_height, spoke_type, spoke_count, spoke_thickness, spoke_support, spring_segments, $fn=100);

use <Libs.scad> // http://www.thingiverse.com/thing:6021
use <MCAD/triangles.scad>
use <MCAD/2Dshapes.scad>

module basWheel(outer_diameter, outer_thickness, height, hub_type, hub_diameter, hub_thickness, servo_hub_extra_height, servo_hole_count, servo_attachment_height, stepper_axle_height, stepper_axle_OD, stepper_axle_ID, stepper_screw_OD, stepper_screw_ID, slot_OD, slot_height, magnet_offset, magnet_diameter, rim_width, rim_height, spoke_type, spoke_count, spoke_thickness, spoke_support, spring_segments) {
	outer_radius = outer_diameter / 2;
	hub_radius = hub_diameter / 2;
	magnet_radius = magnet_diameter / 2;
	hub_screw_thickness = tableEntry(hub_type, "nutThickness") * 2;
	hub_screw_outer_radius = hub_radius + hub_screw_thickness;
	hub_other_outer_radius = hub_radius + hub_thickness;
	spoke_outer_radius = outer_radius - max((outer_thickness - spoke_thickness), 0);

	union() {
		if (tableRow(hub_type) != -1) {
			hub(hub_type, hub_radius, hub_screw_thickness, 0, servo_hole_count, servo_attachment_height, 0, 0, 0, 0, 0, 0, 0, height, 0, 0);
			spokes(spoke_type, hub_screw_outer_radius, outer_thickness, height, spoke_outer_radius, spoke_thickness, spoke_count, spoke_support, spring_segments);
		} else {
			hub(hub_type, hub_radius, hub_thickness, servo_hub_extra_height, servo_hole_count, servo_attachment_height, stepper_axle_height, stepper_axle_OD, stepper_axle_ID, stepper_screw_OD, stepper_screw_ID, slot_OD, slot_height, height, magnet_offset, magnet_radius);
			spokes(spoke_type, hub_other_outer_radius, outer_thickness, height, spoke_outer_radius, spoke_thickness, spoke_count, spoke_support, spring_segments);
		}
		ring(outer_radius, outer_thickness, height);
		rims(outer_radius, rim_width, rim_height, height);
	}
}

module hub(type, inner_radius, thickness, servo_extra_height, servo_hole_count, servo_attachment_height, stepper_axle_height, stepper_axle_OD, stepper_axle_ID, stepper_screw_OD, stepper_screw_ID, slot_OD, slot_height, tire_height, magnet_offset, magnet_radius) {
	padding = 1;
	small_padding = 0.1;
	servo_outer_radius = 18;

	lego_piece_height = 15.6;
	lego_piece_size = 4.72;
	lego_piece_size_new = 4.85;

	servohead_screw_height = 2;

	stepper_axle_outer_radius = stepper_axle_OD / 2;
	stepper_screw_height = 2;
	stepper_screw_outer_radius = stepper_screw_OD / 2;
	stepper_screw_inner_radius = stepper_screw_ID / 2;

	slot_radius = slot_OD / 2;

	radius = inner_radius + thickness;
	height = tire_height + tableEntry(type, "headDiameter") + 0.5;
	hole_z = (height - tire_height) / 2 + tire_height / 2;
	upper_nut_z = (height - tire_height) / 2 + hole_z;
	nut_x = radius - thickness + 0.5;

	if (type == "servo") {
		union() {
			ring(radius, thickness, tire_height);
			servoHub(servo_outer_radius, radius, inner_radius, servo_extra_height, servo_hole_count, servo_attachment_height, tire_height, magnet_offset, magnet_radius);
		}
	} else if (type == "servohead") {
		difference() {
			cylinder(r=radius, h=tire_height, center=true);
			translate([0, 0, tire_height / 2 + small_padding]) {
				rotate([180, 0, 0]) {
					servo_head(FUTABA_3F_SPLINE, SERVO_HEAD_CLEAR);
				}
			}
			translate([0, 0, - FUTABA_3F_SPLINE[0][1] + tire_height / 2 + small_padding * 2]) {
				rotate([180, 0, 0]) {
					cylinder(r=FUTABA_3F_SPLINE[0][3] / 2, h=servohead_screw_height + small_padding * 2);
				}
			}
			translate([0, 0, - FUTABA_3F_SPLINE[0][1] + tire_height / 2 - servohead_screw_height + small_padding]) {
				rotate([180, 0, 0]) {
					cylinder(r=FUTABA_3F_SPLINE[0][0] / 2, h=tire_height - FUTABA_3F_SPLINE[0][1] - servohead_screw_height + small_padding * 2);
				}
			}
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
	} else if (type == "stepper") {
		difference() {
			cylinder(r=radius, h=tire_height, center=true);
			translate([0, 0, (tire_height - stepper_axle_height + small_padding) / 2]) {
				intersection() {
					cylinder(r=stepper_axle_outer_radius, h=stepper_axle_height + small_padding, center=true);
					cube(size=[stepper_axle_OD + small_padding, stepper_axle_ID, stepper_axle_height + small_padding], center=true);
				}
			}
			translate([0, 0, - (tire_height - stepper_axle_height + small_padding / 2) / 2]) {
				cylinder(r=stepper_screw_inner_radius, h=stepper_screw_height + small_padding, center=true);
			}
			translate([0, 0, - (stepper_axle_height + stepper_screw_height + small_padding) / 2]) {
				cylinder(r=stepper_screw_outer_radius, h=tire_height - stepper_axle_height - 2 + small_padding, center=true);
			}
		}
	} else if (type == "hubattachment") {
		difference() {
			ring(radius, thickness, tire_height);
			translate([0, 0, (tire_height - slot_height + small_padding) / 2]) {
				cylinder(r=slot_radius, h=slot_height + small_padding, center=true);
			}
		}
	} else if (type == "no") {
		ring(radius, thickness, tire_height);
	} else if (tableRow(type) != -1) {
		difference() {
			union() {
				ring(radius, thickness, tire_height);
				translate([0, 0, height / 2]) {
					ring(radius, thickness, height - tire_height);
				}
			}
			translate([radius + padding, 0, hole_z]) {
				rotate([0, -90, 0]) {
					capBolt(type, radius + padding);
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

module servoHub(outer_radius, radius, inner_radius, extra_height, hole_count, attachment_height, tire_height, magnet_offset, magnet_radius) {
	padding = 0.1;

	if (magnet_radius > 0) {
		difference() {
			servoSimpleHub(outer_radius, radius, inner_radius, extra_height, hole_count, attachment_height, tire_height);
			for (i = [0 : hole_count - 1]) {
				rotate([0, 0, i * 360 / hole_count + (360 / hole_count / 2)]) {
					translate([0, outer_radius - magnet_radius - magnet_offset, tire_height / 2 + extra_height - padding]) {
						cylinder(r=magnet_radius, h=attachment_height + padding * 2);
					}
				}
			}
		}
	} else {
		servoSimpleHub(outer_radius, radius, inner_radius, extra_height, hole_count, attachment_height, tire_height);
	}
}

module servoSimpleHub(outer_radius, radius, inner_radius, extra_height, hole_count, attachment_height, tire_height) {
	padding = 0.1;

	translate([0, 0, tire_height / 2]) {
		difference() {
			union() {
				cylinder(r=radius, h=extra_height);
				translate([0, 0, extra_height]) {
					cylinder(r=outer_radius, h=attachment_height);
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

module spokes(type, hub_radius, tire_thickness, height, outer_radius, thickness, count, support, spring_segments) {
	padding = 0.1;
	double_spoke_spacing = 1;

	ring_radius = outer_radius - tire_thickness;
	ring_thickness = ring_radius - hub_radius + padding;
	spring_angle = 360 / count / 2;

	intersection() {
		ring(ring_radius, ring_thickness, height);
		for (i = [0 : count - 1]) {
			rotate([0, 0, i * (360 / count)]) {
				if (type == "spiral_left_double") {
					translate([0, 0, (height + double_spoke_spacing) / 4]) {
						spoke(outer_radius, hub_radius, min(thickness, tire_thickness), (height - double_spoke_spacing) / 2, support, true);
					}
					translate([0, 0, -(height + double_spoke_spacing) / 4]) {
						spoke(outer_radius, hub_radius, min(thickness, tire_thickness), (height - double_spoke_spacing) / 2, support, false);
					}
				} else if (type == "spiral_right_double"){
					translate([0, 0, (height + double_spoke_spacing) / 4]) {
						spoke(outer_radius, hub_radius, min(thickness, tire_thickness), (height - double_spoke_spacing) / 2, support, false);
					}
					translate([0, 0, -(height + double_spoke_spacing) / 4]) {
						spoke(outer_radius, hub_radius, min(thickness, tire_thickness), (height - double_spoke_spacing) / 2, support, true);
					}
				} else if (type == "spiral_right") {
					spoke(outer_radius, hub_radius, min(thickness, tire_thickness), height, support, false);
				} else if (type == "spiral_left") {
					spoke(outer_radius, hub_radius, min(thickness, tire_thickness), height, support, true);
				} else if (type == "spring") {
					spring(spring_angle, spring_segments, outer_radius - tire_thickness, hub_radius, height);
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

module spring(angle, segments, outer_radius, inner_radius, height) {
	spring_thickness = 1;

	half_angle = angle / 2;
	half_spring_thickness = spring_thickness / 2;
	spring_spacing = round((outer_radius - inner_radius + spring_thickness) / (segments + 1) * 100) / 100;
	half_spring_spacing = spring_spacing / 2;
	double_spring_spacing = spring_spacing * 2;
	inner_spring_radius = inner_radius - spring_thickness;
	outer_spring_radius = outer_radius + spring_thickness;
	inner_segment_radius = inner_radius + half_spring_spacing - half_spring_thickness;
	segments_up = floor(segments / 2);
	segments_down = ceil(segments / 2) - 1;

	translate([0, 0, -height / 2]) {
		union() {
			for (i = [1 : segments]) {
				donutSlice3D(inner_spring_radius + spring_spacing * i, inner_radius + spring_spacing * i, -half_angle, half_angle, height);
			}
			for (i = [0 : segments_up]) {
				rotate([0, 0, half_angle]) {
					translate([inner_segment_radius + spring_spacing * i * 2, 0, 0]) {
						donutSlice3D((spring_spacing - spring_thickness) / 2, (spring_spacing + spring_thickness) / 2, 0, 180, height);
					}
				}
			}
			for (i = [0 : segments_down]) {
				rotate([0, 0, 180 - half_angle]) {
					translate([-(inner_segment_radius + spring_spacing * i * 2 + spring_spacing), 0, 0]) {
						donutSlice3D((spring_spacing - spring_thickness) / 2, (spring_spacing + spring_thickness) / 2, 0, 180, height);
					}
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

module donutSlice3D(innerSize, outerSize, start_angle, end_angle, height) {
	linear_extrude(height=height, convexity=10) {
		donutSlice(innerSize, outerSize, start_angle, end_angle);
	}
}

/**
 *  Parts taken from:
 *
 *  Parametric servo arm generator for OpenScad
 *
 *  Copyright (c) 2012 Charles Rincheval.  All rights reserved.
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 *
 *  Last update :
 *  https://github.com/hugokernel/OpenSCAD_ServoArms
 *
 *  http://www.digitalspirit.org/
 */

/**
 *  Head / Tooth parameters
 *  Futaba 3F Standard Spline
 *  http://www.servocity.com/html/futaba_servo_splines.html
 *
 *  First array (head related) :
 *  0. Head external diameter
 *  1. Head heigth
 *  2. Head thickness
 *  3. Head screw diameter
 *
 *  Second array (tooth related) :
 *  0. Tooth count
 *  1. Tooth height
 *  2. Tooth length
 *  3. Tooth width
 */
FUTABA_3F_SPLINE = [
    [5.92, 4, 1.1, 2.5],
    [25, 0.3, 0.7, 0.1]
];

/**
 *  Clear between arm head and servo head
 *  With PLA material, use clear : 0.3, for ABS, use 0.2
 */
SERVO_HEAD_CLEAR = 0.2;

/**
 *  Tooth
 *
 *    |<-w->|
 *    |_____|___
 *    /     \  ^h
 *  _/       \_v
 *   |<--l-->|
 *
 *  - tooth length (l)
 *  - tooth width (w)
 *  - tooth height (h)
 *  - height
 *
 */
module servo_head_tooth(length, width, height, head_height) {
	linear_extrude(height = head_height) {
		polygon([[-length / 2, 0], [-width / 2, height], [width / 2, height], [length / 2,0]]);
	}
}

/**
 *  Servo head
 */
module servo_head(params, clear) {
	head = params[0];
	tooth = params[1];

	head_diameter = head[0];
	head_heigth = head[1];

	tooth_count = tooth[0];
	tooth_height = tooth[1];
	tooth_length = tooth[2];
	tooth_width = tooth[3];

	cylinder(r = head_diameter / 2 - tooth_height + 0.03 + clear, h = head_heigth);

	for (i = [0 : tooth_count]) {
		rotate([0, 0, i * (360 / tooth_count)]) {
			translate([0, head_diameter / 2 - tooth_height + clear, 0]) {
				servo_head_tooth(tooth_length, tooth_width, tooth_height, head_heigth);
			}
		}
	}
}
