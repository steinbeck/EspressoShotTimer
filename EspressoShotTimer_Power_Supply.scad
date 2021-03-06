wall_thickness = 2;
base_width = 88;
base_depth = 44;
case_height = 25;
gaggia_steel_thickness = 0.5;
slitcount = 8;
slitwidth = 2;


/*
*   Definition of body. 
*/

module base()
{
  cube([base_width,base_depth, case_height]);
}

module interior()
{
  cube([base_width-4,base_depth-4,case_height]);
}

module base_block() {
  difference() {
    base();
    translate([wall_thickness,wall_thickness,wall_thickness])
        interior();
  }
}

module bottom_slits() {    
    gap = ((base_width - (10 * wall_thickness) - (slitcount*slitwidth))) / slitcount;
    for (i = [0:8]){
       translate([(5*wall_thickness)+(i*(gap+slitwidth)), (4 * wall_thickness), -1])
       cube([2, base_depth - (8 * wall_thickness), wall_thickness + 2]);
    }
}

module cable_inlet()
{
    cube([10,4,6]);
}

module slitted_lower_part()
{
    difference(){
        base_block();
        bottom_slits();
        }
}

module hook()
{
    translate([-gaggia_steel_thickness, base_depth - 1, 0])
    {
        cube([gaggia_steel_thickness, 1, case_height]);
    }
    translate([-gaggia_steel_thickness - wall_thickness, base_depth - 10, 0])
    {
        cube([wall_thickness, 10, case_height]);
    }

}



module complete_lower_part()
{
    difference(){
        slitted_lower_part();
        translate([4,-1,6])
        {
            cable_inlet();
        }
    }
}

/*
* Lid definition starts here
*/

module lid_body()
{

        cube([base_width,base_depth, wall_thickness]);
}


module top_slits() {    
    gap = ((base_width - (10 * wall_thickness) - (slitcount*slitwidth))) / slitcount;
    for (i = [0:8]){
       translate([(5*wall_thickness)+(i*(gap+slitwidth)), (4 * wall_thickness), -1])
       cube([2, base_depth - (8 * wall_thickness), wall_thickness + 2]);
    }
}


module snap_frame()
{
    difference(){
        cube([base_width - wall_thickness*2,base_depth  - wall_thickness*2, wall_thickness]);
        translate([wall_thickness, wall_thickness, -1]){   
            cube([base_width - wall_thickness*4,base_depth  - wall_thickness*4, wall_thickness +2]);
        }
    }
}


module lid()
{
    difference()
    {
        lid_body();
         
        top_slits();
    }
    translate([wall_thickness, wall_thickness, wall_thickness])
    {
        snap_frame();
    }
}

//slits();

complete_lower_part();

translate([0, -base_depth - 10, 0])
{
    lid();
}

hook();







