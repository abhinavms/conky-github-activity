--This is a lua script for use in conky
require 'cairo'
    
function conky_main()
    if conky_window == nil then
        return
    end
    local cs = cairo_xlib_surface_create(conky_window.display,
                                         conky_window.drawable,
                                         conky_window.visual,
                                         conky_window.width,
                                         conky_window.height)
    cr = cairo_create(cs)
    local updates=tonumber(conky_parse('${updates}'))
    if updates>10 then
        
        local f = io.popen('python script.py') -- Runs the command
        local value = f:read("*a") -- Reads the output of command
        
        font="AvantGarde LT Medium"
        red,green,blue,alpha=1,1,1,1
        font_slant=CAIRO_FONT_SLANT_NORMAL
        font_face=CAIRO_FONT_WEIGHT_NORMAL
        cairo_select_font_face (cr, font, font_slant, font_face);
        cairo_set_font_size (cr, 100)
        cairo_set_source_rgba (cr,red,green,blue,alpha)
        cairo_move_to (cr,35,215)
        cairo_show_text (cr,value)
        cairo_stroke (cr)
        

        cairo_destroy(cr)
        cairo_surface_destroy(cs)
        cr=nil
    end
    
end
