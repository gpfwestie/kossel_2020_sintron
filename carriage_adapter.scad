roller_x = 19.5;
roller_y = 25;
roller_z = 15;
base_radius = 16/2;

width = roller_x*2 + base_radius*2;
height = 66;
thickness = 7;

carriage_width = 20;
center_x = width/2;
center_y = height/2;

m3_radius = 3.4/2;
m3_nut_h = 3.1;
m3_nut_w  = 5.5+0.2;

m6_radius = 6.3/2;

shoulder_width = 12;
shoulder_radius = width/2-carriage_width/2;

module carriage_adapter()
{
	difference() {
	union() {
		translate([-carriage_width/2,-height/2,0])
			cube([carriage_width,height,thickness]);
		hull() {
			translate([-carriage_width/2,height/6,0])
				cube([carriage_width,height/3,thickness]);
			translate([roller_x,roller_y,0])
				cylinder(r=base_radius,h=thickness,$fn=24);
		}
		hull() {
			translate([-carriage_width/2,-height/2,0])
				cube([carriage_width,height/3,thickness]);
			translate([roller_x,-roller_y,0])
				cylinder(r=base_radius,h=thickness,$fn=24);
		}
		hull() {
			translate([-width/2,0,0])
				cube([shoulder_width, height/2-shoulder_radius,thickness]);
			translate([-roller_x,0,0])
				cylinder(r=base_radius,h=thickness,$fn=24);
		}

		translate([roller_x,roller_y,thickness])
			cylinder(r1=base_radius,r2=9/2,h=roller_z-thickness,$fn=24);
		translate([roller_x,-roller_y,thickness])
			cylinder(r1=base_radius,r2=9/2,h=roller_z-thickness,$fn=24);
		translate([-roller_x,0,thickness])
			cylinder(r1=base_radius,r2=9/2,h=roller_z-thickness,$fn=24);

		translate([-width/2+shoulder_radius,height/2-shoulder_radius,0])
		difference() {
			cylinder(r=shoulder_radius,h=thickness,$fn=48);
			cylinder(r=shoulder_radius-shoulder_width,h=thickness,$fn=48);
			translate([-shoulder_radius,-shoulder_radius,0])
			cube([shoulder_radius,shoulder_radius,thickness]);
		}

		translate([-width/2+6+4,-height/2+13,0]) {
			cube([6,10,thickness+1]);
			cube([carriage_width,10,thickness]);
		}

		translate([-width/2, -height/2+13, 0])
			cube([6,height/2-10,thickness]);
		hull() {
			translate([-width/2, -height/2+13,0])
				cube([6,10,thickness+1]);
			intersection() {
				translate([-roller_x,0,thickness])
					cylinder(r1=base_radius,r2=9/2,h=roller_z-thickness,$fn=24);
				translate([-width/2, -height/2+13,0])
					cube([6,height/2-13,thickness+1]);
			}
		}
	}
	// DIFFERENCE

		translate([-4, -18, 0])
			cube([8, 36, thickness]);

		intersection() {
			translate([-roller_x, 0, 0])
				cylinder(r=base_radius+3, h=thickness, $fn=24);
			translate([-carriage_width/2,-height/2,0])
				cube([carriage_width, height, thickness]);
		}

		for(a=[0,180]) rotate([0,0,a]) {
		translate([-carriage_width/4+1.2,height/2-4.5,0])
		{
			cylinder(r=m3_radius,h=20,$fn=24);
			translate([0, 0, thickness-m3_nut_h])
			cylinder(r=m3_nut_w/2*1.154734411,h=m3_nut_h+1,$fn=6);
		}
		}

		translate([roller_x,roller_y,0]) {
			cylinder(r=m6_radius,h=20,$fn=24);
			cylinder(r1=12/2+0.8, r2=2/2+0.8,h=5,$fn=24);
		}
		translate([roller_x,-roller_y,0]) {
			cylinder(r=m6_radius,h=20,$fn=24);
			cylinder(r1=12/2+0.8, r2=2/2+0.8,h=5,$fn=24);
		}
		translate([-roller_x,0,0]) {
			cylinder(r=m6_radius,h=20,$fn=24);
			cylinder(r1=12/2+0.8, r2=2/2+0.8,h=5,$fn=24);
		}

		translate([-width/2, -height/2+13, 0]) {
		translate([-1, 10/2, (thickness+1)/2])
			rotate([0,90,0])
				cylinder(r=m3_radius, h=width/2, $fn=24);

		translate([6+4+6/2, 10/2, (thickness+1)/2])
		rotate([0,90,0])
			cylinder(r=m3_nut_w/2*1.154734411, h=m3_nut_h, center=true, $fn=6);
		translate([6+4+6/2, 10/2, (thickness+2)*3/4]) 
			cube([m3_nut_h, m3_nut_w, (thickness+2)/2], center=true);
		}			
	}
}

carriage_adapter();
