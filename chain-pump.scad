use <lib/pump_4547.scad>

clearance=1;
body_thickness=2;
body_length=10;
foot_width=pump_4547_foot_width()+2*body_thickness;
foot_height=pump_4547_pump_diameter()/2+body_thickness;
foot_length=body_length+20;
foot_size=[foot_width, foot_height, foot_length];

port_diameter=7.45;
port_inner_diameter=port_diameter-body_thickness;
port_height=9.75;

% translate([0,0,-10]) pump_4547();

color("green") {
    difference() {
        union() {
            // foot
            translate(-foot_size/2+[0,foot_height/2,-foot_length/2+body_length]) cube(size=foot_size);
            
            // body
            cylinder(h=body_length, d=pump_4547_pump_diameter());
            
            // port
            translate([-pump_4547_pump_diameter()/2+port_diameter/2,0,body_length/2]) rotate([90,0,0]) difference() {
                cylinder(h=port_height+pump_4547_pump_diameter()/2, d=port_diameter);
                cylinder(h=port_height+pump_4547_pump_diameter()/2, d=port_inner_diameter);
            }
        }


        // opening to pump intake
        translate([0,0,-foot_length+body_length-body_thickness]) cylinder(h=foot_length, d=13);
        
        // internal void
        translate([0,0,body_thickness]) cylinder(h=body_length-2*body_thickness, d=pump_4547_pump_diameter()-2*body_thickness);

        // port opening
        translate([-pump_4547_pump_diameter()/2+port_diameter/2,0,body_length/2]) rotate([90,0,0]) cylinder(h=port_height+pump_4547_pump_diameter()/2, d=port_inner_diameter);
        
        // subtract the pump body
        minkowski() {
            pump_4547();
            sphere(d=clearance);
        }
    }
}
