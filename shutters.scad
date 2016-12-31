/// All units are inches unless otherwise noted
// Window opening size
h_window = 52.5;
w_window = 31 + 1/16;

// Panel slot depth (validate by experiment)
d_slot = 3/8;
// Panel slot width (cut to fit)
w_slot = 1/4;

// Frame thickness
t_frame = 3/4;
// Stile width (measure stock for actual dimension)
w_stile = 2.5;
// rail width (measure stock for actual dimension)
w_rail = 3.5;

// Gap between window frame and shutter
frame_gap = 3/32;
// Gap between window shutters
center_gap = 3/32;

// Center overlap between shutters
shutter_overlap = 1/4;

// Gap between panel and rails and stiles to allow for
// expasion and contraction
panel_gap = 1/16;

// number of shutter leaves
n_leaves = 2;

// Stile length
l_stile = h_window - 2 * frame_gap;
// Rail length visible
l_rail_visible = (w_window - 2 * frame_gap - center_gap 
        - 2 * n_leaves * w_stile);
// Rail length to cut
l_rail_cut = l_rail_visible  + 2 * d_slot;

w_leaf= 2 * w_stile + l_rail_visible; 

// A shutter is two leaves
leaf();
translate([2 * w_leaf + center_gap - shutter_overlap, 0, t_frame]) mirror([0, 0, 1]) mirror([1, 0, 0]) leaf();

// A leaf is 2 stiles, 3 rails (top, middle, bottom) and 2 panels
module leaf() {
    stile();
    difference() {
        translate([2 * w_stile + l_rail_visible,0,0]) mirror([1, 0, 0])stile();
        translate([2 * w_stile + l_rail_visible - shutter_overlap, 0, 0]) cube([shutter_overlap, l_stile, t_frame/2]);
    }
    
    color([0, 0.5, 0]) {
        translate([w_stile - d_slot, 0, 0]) rail();
        translate([w_stile - d_slot, l_stile, 0]) mirror([0, 1, 0]) rail();
    }
}

module stile()
{
    difference() {
        cube([w_stile, l_stile, t_frame]);
        translate([w_stile-d_slot,0,(t_frame-w_slot)/2]) cube([d_slot, l_stile, w_slot]);
    }
}

module rail()
{
    difference() {
        cube([l_rail_cut, w_rail, t_frame]);
        translate([0, w_rail-d_slot,(t_frame-w_slot)/2]) cube([l_rail_cut, d_slot, w_slot]);
        // Tenons
        cube([d_slot,w_rail, (t_frame-w_slot)/2]);
        translate([0,0,t_frame]) mirror ([0, 0, 1]) cube([d_slot,w_rail, (t_frame-w_slot)/2]);
        translate([l_rail_cut, 0, 0]) mirror ([1, 0, 0]) cube([d_slot,w_rail, (t_frame-w_slot)/2]);
        translate([l_rail_cut, 0, t_frame]) mirror([1, 0, 0]) mirror ([0, 0, 1]) cube([d_slot,w_rail, (t_frame-w_slot)/2]);
    }
}
