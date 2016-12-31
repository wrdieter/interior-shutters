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
// Rail length 
l_rail_visible = (w_window - 2 * frame_gap - center_gap 
        - 2 * n_leaves * w_stile);
l_rail_cut = l_rail_visible  + 2 * d_slot;

stile();
translate([w_stile + l_rail_visible,0,0]) mirror([1, 0, 0])stile();

module stile()
{
    difference() {
        cube([w_stile, l_stile, t_frame]);
        translate([w_stile-d_slot,0,(t_frame-w_slot)/2]) cube([d_slot, l_stile, w_slot]);
    }
}

