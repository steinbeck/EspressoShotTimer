wall_thickness = 2;
base_width = 30;
base_depth = 38;
case_height = 22;

gaggia_steel_thickness = 1.5;
hook_height = 8;



slit_count = 4;
slit_width = 2;

display_width = 19;
display_depth = 15;
 // this should be equal to wall_thickness
 // but this leads to artifacts in openSCAD display
 // so we make it a bit thicker
display_height = 4;

display_window_offset_x=3.5;
display_window_offset_y=13;

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
    gap = ((base_width - (4 * wall_thickness) - (slit_count*slit_width))) / (slit_count -1);
    echo(gap);
    for (i = [0:slit_count - 1]){
       echo(i*(gap+slit_width));
       translate([(2*wall_thickness)+(i*(gap+slit_width)), (4 * wall_thickness), -1])
       cube([2, base_depth - (8 * wall_thickness), wall_thickness + 2]);
    }
}

module cable_inlet()
{
    cube([11,4,3]);
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
    translate([-gaggia_steel_thickness, base_depth - wall_thickness, 0])
    {
        cube([gaggia_steel_thickness, wall_thickness, case_height]);
    }
    translate([-gaggia_steel_thickness - wall_thickness, base_depth - 10, 0])
    {
        cube([wall_thickness, hook_height+wall_thickness, case_height]);
    }

}



module complete_lower_part()
{
    difference(){
        slitted_lower_part();
        translate([6,-1,0])
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
    gap = ((base_width - (4 * wall_thickness) - (slitcount*slitwidth))) / slitcount;
    for (i = [0:2]){
       translate([(2*wall_thickness)+(i*(gap+slitwidth)), (4 * wall_thickness), -1])
       cube([2, base_depth - (8 * wall_thickness), wall_thickness + 2]);
    }
}

module display_window()
{
    cube([display_width,display_depth,display_height]);
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
              translate([display_window_offset_x+wall_thickness, display_window_offset_y+wall_thickness, -1])
            {   
                display_window();
            }
     
        }

    translate([wall_thickness, wall_thickness, wall_thickness])
    {
        snap_frame();
    }
}

slits();

complete_lower_part();

translate([0, -base_depth - 10, 0])
{
    lid();
}


hook();







