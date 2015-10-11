separation = 40;

width = 20;
height = 66;

horn_thickness = 10;
horn_x = 7;
horn_y = 20;

belt_width = 6+1;
belt_x = 6.5;
belt_z = 10-1;
belt_thickness = 0.95;

thickness = belt_z +3;

m3_radius = 3.4/2;
m3_nut_w  = 5.5+0.3;
m3_nut_h = 2.4;

module carriage() {
	difference() {
	union() {
      // Ball joint mount horns.
      for (x = [-1, 1]) {
        scale([x, 1, 1]) intersection() {
          translate([0, 0, horn_thickness/2+1])
            cube([separation, height, horn_thickness+10], center=true);
          translate([horn_x, horn_y, horn_thickness/2]) rotate([0, 90, 0])
            cylinder(r1=14, r2=3.4, h=separation/2-horn_x);
        }
      }

      translate([-width/2, -height/2, -4])
			cube([width, height-6, thickness]);
      translate([-horn_x, horn_y+4, -4])
			cube([horn_x*2, height/2-horn_y-4, thickness]);

		difference() {
		   translate([0, -height/2, 0])
   			cube([width/2, height/2+horn_y-4, belt_z+belt_width]);
		   translate([belt_x+1.4, -height/2, belt_z+belt_width])
   		rotate([0,45,0]) cube([width/2, height/2+horn_y-4, belt_z+belt_width]);
		}
	}

	//translate([-7,horn_y-4,horn_thickness/2])
	//	cube([14,8,belt_z+belt_width]);
	//for(s=[1,-1]) scale([s,1,1])
	//translate([-7-m3_nut_h,horn_y,horn_thickness/2])
	//rotate([0,90,0]) 	rotate([0,0,30])
	//	cylinder(r=m3_nut_w/2*1.154734411, h=m3_nut_h+7.1, $fn=6);

	translate([belt_x-belt_thickness/2, -height/2, belt_z])
		cube([belt_thickness, height, belt_width]);

	for(y=[-height/2:2:horn_y]) {
		translate([belt_x-belt_thickness/2-1.0, y, belt_z])
			cube([1.1,1.25,belt_width+2]);
	}
	translate([belt_x, 0, belt_z+belt_width])
	rotate([0,45,0]) cube([belt_thickness*1.7,height,belt_thickness*1.7], center=true);

	translate([0,horn_y,horn_thickness/2])
	rotate([0,90,0])
		cylinder(r=2, h=separation+1, center=true,$fn=24);

	for(a=[0,180]) rotate([0,0,a]) {
	translate([width/4-1.2,height/2-4.5,-4]) 
		cylinder(r=m3_radius,h=20,$fn=24);
	translate([width/4-1.2,height/2-4.5,6]) 
		cylinder(r=3.2,h=belt_width+belt_z+3,$fn=48);
	}


	}
}

carriage();