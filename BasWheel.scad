// define if the wheel is compatible with a tire. Options are (custom, pololu90)
tire_compatibility = "custom";

outer_diameter = 60;  // outer diameter of the wheel
outer_thickness = 1;  // outer thickness of the wheel
wheel_height = 10;  // height of the wheel
wheel_extra_height = 0;  // extra height of the wheel

// define hubtype to be used. Options are (servo, servohead, lego, legoturntable, stepper, hubattachment, no, hex, screw_size)
// screw_size options are: "M2", "M2.5", "M3", "M4", "M5", "M6", "M8", "#8", "1/4 Hex", "5/16 Hex" (as per Libs.scad)
hub_type = "M3";

hub_diameter = 5;  // diameter of the hub
hub_thickness = 5;  // thickness of the hub
hub_magnet_count = 0;  // used in the magnet_hub. How many magnets will the magnet_hub has
hub_magnet_margin = 2;  // used in the magnet_hub. Margin that will exist between the magnet hole and the top or the spoke
hub_magnet_diameter = 6;  // used in the magnet_hub. Magnet's diameter
hub_magnet_height = 3;  // used in the magnet_hub. Magnet's height
servo_hub_extra_height = 2;  // used with "servo" hub_type. Extra height of the servo hub
servo_hole_count = 4;  // used with "servo" hub_type. How many screw hole will the servo hub have
servo_hole_ID = 1.5;  // used with "servo" hub_type. Inner hole diameter
servo_hole_OD = 1.5;  // used with "servo" hub_type. Outer hole diameter
servo_attachment_height = 2;  // used with "servo" hub_type. Height of the servo hub base
stepper_axle_height = 6;  // used with "stepper" hub_type. Height of the stepper axle
stepper_axle_OD = 5;  // used with "stepper" hub_type. Outer diameter of the stepper axle
stepper_axle_ID = 3;  // used with "stepper" hub_type. Inner diameter of the stepper axle
stepper_screw_OD = 5;  // used with "stepper" hub_type. Outer diameter of the screw
stepper_screw_ID = 3;  // used with "stepper" hub_type. Inner diameter of the screw
slot_OD = 10;  // used with "hubattachment" hub_type. Outer diameter of the screw slot (attachment to BasHub)
hex_size = 5;  // used with "hex" hub_type. Size of the hex measured from side to side
hex_screw_spacer = 2;  // used with "hex" hub_type. How thick will the spacer between the screw and the axle be
hex_screw_OD = 6;  // used with "hex" hub_type. Outer diameter of the screw
hex_screw_ID = 2;  // used with "hex" hub_type. Inner diameter of the screw
hex_screwhole_depth = 2;  // used with "hex" hub_type. How deep will the hole for the screw be
magnet_offset = 3;  // used with "servo" hub_type. Distance of the magnet holes from the outside
magnet_diameter = 0;  // used with "servo" hub_type. Magnet's diameter
rim_width = 1;  // outer rim width
rim_height = 1;  // outer rim height

// define spoketype to be used. Options are (spiral_left_double, spiral_right_double, spiral_left, spiral_right, spring, dxf)
spoke_type = "spiral_left";

spoke_count = 6;  // number of spokes
spoke_thickness = 1;  // spoke thickness
spoke_support = 25;  // spoke's attachment support to the wheel in degrees (between 5 an 85)
spring_segments = 6;  // used with "spring" spoke_type. Number of segment a spring will have
dxf_filename = "BasSpoke1.dxf";  // used with "dxf" spoke_type. Dxf filename to use as spoke

// flip the tire for printing. Options are (0 - not flipped, 1 - flipped)
flip_wheel = 0;

/*
 *
 * BasWheel v1.27
 *
 * by Basile Laderchi
 *
 * Licensed under Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International http://creativecommons.org/licenses/by-nc-sa/4.0/
 *
 * v 1.27, 18 Jun 2014 : Added parameters hex_screw_spacer, hex_screw_OD, hex_screw_ID, hex_screwhole_depth, hub_magnet_count, hub_magnet_margin, hub_magnet_diameter and hub_magnet_height
 * v 1.26,  4 Jun 2014 : Added hub_type "hex" and parameter hex_size
 * v 1.25, 14 Mar 2014 : Added spoke_type "dxf" and parameter dxf_filename
 * v 1.24, 25 Feb 2014 : Added parameters tire_compatibility and flip_wheel
 * v 1.23, 14 Jan 2014 : Fixed bug with parameter outer_thickness
 * v 1.22,  3 Jan 2014 : Added parameter wheel_extra_height
 * v 1.21,  2 Jan 2014 : Added parameters servo_hole_ID and servo_hole_OD
 * v 1.20, 24 Dec 2013 : Added hub_type "legoturntable"
 * v 1.19, 29 Nov 2013 : Changed license from CC BY-NC-SA 3.0 to CC BY-NC-SA 4.0 and added comments to parameters
 * v 1.18, 26 Nov 2013 : Removed parameter slot_height
 * v 1.17, 20 Nov 2013 : Changed license from CC BY-SA 3.0 to CC BY-NC-SA 3.0 and added hub_type "hubattachment"
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

basWheel(tire_compatibility, outer_diameter, outer_thickness, wheel_height, wheel_extra_height, hub_type, hub_diameter, hub_thickness, hub_magnet_count, hub_magnet_margin, hub_magnet_diameter, hub_magnet_height, servo_hub_extra_height, servo_hole_count, servo_hole_ID, servo_hole_OD, servo_attachment_height, stepper_axle_height, stepper_axle_OD, stepper_axle_ID, stepper_screw_OD, stepper_screw_ID, slot_OD, hex_size, hex_screw_spacer, hex_screw_OD, hex_screw_ID, hex_screwhole_depth, magnet_offset, magnet_diameter, rim_width, rim_height, spoke_type, spoke_count, spoke_thickness, spoke_support, spring_segments, dxf_filename, flip_wheel, $fn=100);

use <Libs.scad> // http://www.thingiverse.com/thing:6021
use <MCAD/triangles.scad>
use <MCAD/2Dshapes.scad>

module basWheel(tire_compatibility, outer_diameter, outer_thickness, wheel_height, wheel_extra_height, hub_type, hub_diameter, hub_thickness, hub_magnet_count, hub_magnet_margin, hub_magnet_diameter, hub_magnet_height, servo_hub_extra_height, servo_hole_count, servo_hole_ID, servo_hole_OD, servo_attachment_height, stepper_axle_height, stepper_axle_OD, stepper_axle_ID, stepper_screw_OD, stepper_screw_ID, slot_OD, hex_size, hex_screw_spacer, hex_screw_OD, hex_screw_ID, hex_screwhole_depth, magnet_offset, magnet_diameter, rim_width, rim_height, spoke_type, spoke_count, spoke_thickness, spoke_support, spring_segments, dxf_filename, flip_wheel) {
	wheel_x_rotation = (flip_wheel == 0) ? 0 : 180;

	outer_radius = (tire_compatibility == "pololu90") ? 40 : outer_diameter / 2;
	height = wheel_height;
	extra_height = wheel_extra_height;

	hub_radius = hub_diameter / 2;
	hub_screw_thickness = tableEntry(hub_type, "nutThickness") * 2;
	hub_screw_outer_radius = hub_radius + hub_screw_thickness;
	hub_other_outer_radius = hub_radius + hub_thickness;
	spoke_outer_radius = outer_radius - max((outer_thickness - spoke_thickness), 0);

	rotate([wheel_x_rotation, 0, 0]) {
		union() {
			assign (hub_thickness = (tableRow(hub_type) != -1) ? hub_screw_thickness : hub_thickness,
							servo_hub_extra_height = (tableRow(hub_type) != -1) ? 0 : servo_hub_extra_height,
							stepper_axle_height = (tableRow(hub_type) != -1) ? 0 : stepper_axle_height,
							stepper_axle_OD = (tableRow(hub_type) != -1) ? 0 : stepper_axle_OD,
							stepper_axle_ID = (tableRow(hub_type) != -1) ? 0 : stepper_axle_ID,
							stepper_screw_OD = (tableRow(hub_type) != -1) ? 0 : stepper_screw_OD,
							stepper_screw_ID = (tableRow(hub_type) != -1) ? 0 : stepper_screw_ID,
							slot_OD = (tableRow(hub_type) != -1) ? 0 : slot_OD,
							servo_magnet_offset = (tableRow(hub_type) != -1) ? 0 : magnet_offset,
							servo_magnet_diameter = (tableRow(hub_type) != -1) ? 0 : magnet_diameter) {
				hub(hub_type, hub_radius, hub_thickness, hub_magnet_count, hub_magnet_margin, hub_magnet_diameter, hub_magnet_height, servo_hub_extra_height, servo_hole_count, servo_hole_ID, servo_hole_OD, servo_attachment_height, stepper_axle_height, stepper_axle_OD, stepper_axle_ID, stepper_screw_OD, stepper_screw_ID, slot_OD, hex_size, hex_screw_spacer, hex_screw_OD, hex_screw_ID, hex_screwhole_depth, height, servo_magnet_offset, servo_magnet_diameter);
			}
			assign (hub_outer_radius = (tableRow(hub_type) != -1) ? hub_screw_outer_radius : hub_other_outer_radius) {
				spokes(spoke_type, hub_outer_radius, outer_thickness, height, spoke_outer_radius, spoke_thickness, spoke_count, spoke_support, spring_segments, dxf_filename);
			}
			wheelRing(outer_radius, outer_thickness, height, extra_height);
			rims(tire_compatibility, outer_radius, rim_width, rim_height, height, extra_height);
		}
	}
}

module hub(type, inner_radius, thickness, magnet_count, magnet_margin, magnet_diameter, magnet_height, servo_extra_height, servo_hole_count, servo_hole_ID, servo_hole_OD, servo_attachment_height, stepper_axle_height, stepper_axle_OD, stepper_axle_ID, stepper_screw_OD, stepper_screw_ID, slot_OD, hex_size, hex_screw_spacer, hex_screw_OD, hex_screw_ID, hex_screwhole_depth, tire_height, servo_magnet_offset, servo_magnet_diameter) {
	padding = 1;
	small_padding = 0.1;
	servo_outer_radius = 18;

	radius = inner_radius + thickness;
	height = tire_height + tableEntry(type, "headDiameter") + 0.5;
	half_tire_height = tire_height / 2;

	magnet_radius = magnet_diameter / 2;
	magnet_extra_height = (magnet_count == 0) ? 0 : magnet_diameter + magnet_margin * 2;
	magnet_z = magnet_extra_height / 2;
	magnet_offset_x = radius - magnet_height / 2;

	lego_piece_axlefile_height = 15.6;
	lego_piece_axlefile_size = 4.72;
	lego_piece_height_big = 1.85;
	lego_piece_size_small = 4.75;
	lego_piece_size_big = 4.85;

	servohead_screw_height = 2;

	stepper_axle_outer_radius = stepper_axle_OD / 2;
	stepper_screw_height = 2;
	stepper_screw_outer_radius = stepper_screw_OD / 2;
	stepper_screw_inner_radius = stepper_screw_ID / 2;

	hole_z = (height - tire_height) / 2 + half_tire_height;
	upper_nut_z = (height - tire_height) / 2 + hole_z;
	nut_x = radius - thickness + 0.5;

	// Hexagon Dimensions: http://math.tutorvista.com/geometry/hexagon.html#hexagon-dimensions
	hex_radius = hex_size / sqrt(3);
	hex_height = tire_height + magnet_extra_height - hex_screw_spacer - hex_screwhole_depth;
	hex_screw_inner_radius = hex_screw_ID / 2;
	hex_screw_radius = hex_screw_OD / 2;

	slot_radius = slot_OD / 2;
	slot_height = half_tire_height;

	if (type == "servo") {
		union() {
			ring(radius, thickness, tire_height);
			servoHub(servo_outer_radius, radius, inner_radius, servo_extra_height, servo_hole_count, servo_hole_ID, servo_hole_OD, servo_attachment_height, tire_height, servo_magnet_offset, servo_magnet_diameter);
		}
	} else if (type == "servohead") {
		difference() {
			cylinder(r=radius, h=tire_height, center=true);
			translate([0, 0, half_tire_height + small_padding]) {
				rotate([180, 0, 0]) {
					servo_head(FUTABA_3F_SPLINE, SERVO_HEAD_CLEAR);
				}
			}
			translate([0, 0, - FUTABA_3F_SPLINE[0][1] + half_tire_height + small_padding * 2]) {
				rotate([180, 0, 0]) {
					cylinder(r=FUTABA_3F_SPLINE[0][3] / 2, h=servohead_screw_height + small_padding * 2);
				}
			}
			translate([0, 0, - FUTABA_3F_SPLINE[0][1] + half_tire_height - servohead_screw_height + small_padding]) {
				rotate([180, 0, 0]) {
					cylinder(r=FUTABA_3F_SPLINE[0][0] / 2, h=tire_height - FUTABA_3F_SPLINE[0][1] - servohead_screw_height + small_padding * 2);
				}
			}
		}
	} else if (type == "lego") {
		difference() {
			cylinder(r=radius, h=tire_height, center=true);
			rotate([0, 90, 0]) {
				translate([-(tire_height + padding * 2) / 2, -lego_piece_size_big / 2, -lego_piece_size_big / 2]) {
					scale([(tire_height + padding * 2) / lego_piece_axlefile_height, lego_piece_size_big / lego_piece_axlefile_size, lego_piece_size_big / lego_piece_axlefile_size]) {
						import("LegoAxleSize2.stl");
					}
				}
			}
		}
	} else if (type == "legoturntable") {
		difference() {
			cylinder(r=radius, h=tire_height, center=true);
			translate([0, 0, half_tire_height - lego_piece_height_big]) {
				translate([4, 4, 0]) cylinder(r=lego_piece_size_big / 2, h=lego_piece_height_big + small_padding);
				translate([4, -4, 0]) cylinder(r=lego_piece_size_big / 2, h=lego_piece_height_big + small_padding);
				translate([-4, 4, 0]) cylinder(r=lego_piece_size_big / 2, h=lego_piece_height_big + small_padding);
				translate([-4, -4, 0]) cylinder(r=lego_piece_size_big / 2, h=lego_piece_height_big + small_padding);
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
	} else if (type == "hex") {
    translate([0, 0, magnet_z])
      difference() {
    		difference() {
		    	cylinder(r=radius, h=tire_height + magnet_extra_height, center=true);
     			translate([0, 0, - (tire_height - hex_height) / 2 + hex_screw_spacer + hex_screwhole_depth - magnet_z])
		  	  	cylinder(r=hex_radius, h=hex_height + small_padding, center=true, $fn=6);
    			translate([0, 0, - (tire_height - hex_screw_spacer) / 2 + hex_screwhole_depth - magnet_z])
    				cylinder(r=hex_screw_inner_radius, h=hex_screw_spacer + small_padding, center=true);
		    	translate([0, 0, - (tire_height - hex_screwhole_depth) / 2 - magnet_z])
				    cylinder(r=hex_screw_radius, h=hex_screwhole_depth + small_padding, center=true);
    		}
        for (i = [0 : magnet_count - 1])
          rotate([0, 0, i * 360 / magnet_count])
            translate([magnet_offset_x, 0, half_tire_height])
              rotate([0, 90, 0])
                cylinder(r=magnet_radius, h=magnet_height, center=true);
      }
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

module servoHub(outer_radius, radius, inner_radius, extra_height, hole_count, hole_ID, hole_OD, attachment_height, tire_height, magnet_offset, magnet_diameter) {
	padding = 0.1;

	magnet_radius = magnet_diameter / 2;

	if (magnet_diameter > 0) {
		difference() {
			servoSimpleHub(outer_radius, radius, inner_radius, extra_height, hole_count, hole_ID, hole_OD, attachment_height, tire_height);
			for (i = [0 : hole_count - 1]) {
				rotate([0, 0, i * 360 / hole_count + (360 / hole_count / 2)]) {
					translate([0, outer_radius - magnet_radius - magnet_offset, tire_height / 2 + extra_height - padding]) {
						cylinder(r=magnet_radius, h=attachment_height + padding * 2);
					}
				}
			}
		}
	} else {
		servoSimpleHub(outer_radius, radius, inner_radius, extra_height, hole_count, hole_ID, hole_OD, attachment_height, tire_height);
	}
}

module servoSimpleHub(outer_radius, radius, inner_radius, extra_height, hole_count, hole_ID, hole_OD, attachment_height, tire_height) {
	padding = 0.1;

	inner_hole_radius = hole_ID / 2;
	outer_hole_radius = hole_OD / 2;

	inner_hole_y = radius + inner_hole_radius;
	outer_hole_y = outer_radius - outer_hole_radius - 2;

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
						translate([0, inner_hole_y, -padding]) {
							cylinder(r=inner_hole_radius, h=attachment_height + extra_height + padding * 2);
						}
						translate([0, outer_hole_y, -padding]) {
							cylinder(r=outer_hole_radius, h=attachment_height + extra_height + padding * 2);
						}
					}
				}
			}
		}
	}
}

module spokes(type, hub_radius, tire_thickness, height, outer_radius, thickness, count, support, spring_segments, dxf_filename) {
	padding = 0.1;
	double_spoke_spacing = 1;

	half_height = height / 2;
	ring_thickness = outer_radius - hub_radius + padding;
	spoke_thickness = min(thickness, tire_thickness);
	spring_angle = 360 / count / 2;

	orig = dxf_cross(file=dxf_filename);

	echo("Hub outer radius: ", hub_radius);
	echo("Wheel inner radius: ", outer_radius - spoke_thickness);
	echo("Spoke width: ", outer_radius - spoke_thickness - hub_radius);
	if (type == "dxf") {
		echo("DXF origin: ", orig);
	}

	intersection() {
		ring(outer_radius, ring_thickness, height);
		for (i = [0 : count - 1]) {
			rotate([0, 0, i * (360 / count)]) {
				if (type == "spiral_left_double") {
					translate([0, 0, (height + double_spoke_spacing) / 4]) {
						spoke(outer_radius, hub_radius, spoke_thickness, (height - double_spoke_spacing) / 2, support, true);
					}
					translate([0, 0, -(height + double_spoke_spacing) / 4]) {
						spoke(outer_radius, hub_radius, spoke_thickness, (height - double_spoke_spacing) / 2, support, false);
					}
				} else if (type == "spiral_right_double"){
					translate([0, 0, (height + double_spoke_spacing) / 4]) {
						spoke(outer_radius, hub_radius, spoke_thickness, (height - double_spoke_spacing) / 2, support, false);
					}
					translate([0, 0, -(height + double_spoke_spacing) / 4]) {
						spoke(outer_radius, hub_radius, spoke_thickness, (height - double_spoke_spacing) / 2, support, true);
					}
				} else if (type == "spiral_right") {
					spoke(outer_radius, hub_radius, spoke_thickness, height, support, false);
				} else if (type == "spiral_left") {
					spoke(outer_radius, hub_radius, spoke_thickness, height, support, true);
				} else if (type == "spring") {
					spring(spring_angle, spring_segments, outer_radius - tire_thickness, hub_radius, height);
				} else if (type == "dxf") {
					translate([-orig[0], -orig[1], -half_height]) {
						linear_extrude(height=height, convexity=10) {
							import(file=dxf_filename);
						}
					}
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

module wheelRing(outer_radius, outer_thickness, height, extra_height) {
	ring_z = extra_height / 2;

	translate([0, 0, ring_z]) {
		ring(outer_radius, outer_thickness, height + extra_height);
	}
}

module rims(tire_compatibility, radius, width, height, tire_height, extra_height) {
	top_rim_width = width;
	top_rim_height = (tire_compatibility == "pololu90") ? 0 : height;
	top_rim_z = (tire_height - height) / 2 + extra_height;

	middle_rim_width = (tire_compatibility == "pololu90") ? 3.25 : width;
	middle_rim_height = (tire_compatibility == "pololu90") ? 6.5 : 0;
	middle_rim_z = (extra_height - middle_rim_height) / 2;

	lower_rim_width = width;
	lower_rim_height = (tire_compatibility == "pololu90") ? 0 : height;
	lower_rim_z = -(tire_height - height) / 2;

	if (top_rim_height != 0) {
		translate([0, 0, top_rim_z]) {
			rim(radius, top_rim_width, top_rim_height);
		}
	}
	if (middle_rim_height != 0) {
		//rim(radius, middle_rim_width, middle_rim_height);
		rotate_extrude() {
			translate([radius, middle_rim_z, 0]) {
				polygon(points=[[0, 0], [middle_rim_width, 1], [middle_rim_width, middle_rim_height - 1], [0, middle_rim_height]]);
			}
		}
	}
	if (lower_rim_height != 0) {
		translate([0, 0, lower_rim_z]) {
			rim(radius, lower_rim_width, lower_rim_height);
		}
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
 *  Copyright (c) 2012 Charles Rincheval. All rights reserved.
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
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
