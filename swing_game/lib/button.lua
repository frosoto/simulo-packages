local toggled = false;local h,s,v = self:get_color():get_hsv();local basecolor=self:get_color()
function on_collision_start(data)
    local color=data.other:get_color();if color.a == 0 then 
        self:send_event("toggle")
    end
end
function on_event(id,data)
    if id == "toggle" then
        toggled = not toggled;
        if toggled then
            self:set_color(Color:hsv(h, s, v / 3))
        else
            self:set_color(Color:hsv(h, s, v))
        end
        for i,v in ipairs(Scene:get_all_objects()) do
            local color=v:get_color();if v:get_name() == "Dooring it up oh yeah" and (color.r == basecolor.r and color.g == basecolor.g and color.b == basecolor.b) then
                if color.a == 255 then
                    v:set_color(Color:rgba(basecolor.r,basecolor.g,basecolor.b,63.5));v:temp_set_collides(false)
                else
                    v:set_color(Color:rgba(basecolor.r,basecolor.g,basecolor.b,255));v:temp_set_collides(true)
                end
            end
        end
    end
end