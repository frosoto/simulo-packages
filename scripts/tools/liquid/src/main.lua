function on_update()
    if Input:pointer_just_pressed() or Input:pointer_pressed() then
        on_pointer_down(Input:snap_if_preferred(Input:pointer_pos()),Input:key_pressed('ShiftLeft'))
    end
end

function on_pointer_down(point,shift_pressed)
    print("Pointer down at " .. point.x .. ", " .. point.y)
    runtime_eval{
        input = {
            point = point,
            shift_pressed = shift_pressed
        },
        code = [[
            local function add_water(r,c)
                local inner_circle = Scene:add_circle({
                    position = input.point - vec2(c,r),
                    radius = 0.025,
                    color = Color:rgba(0,0,0,0),
                    is_static = false,
                })
                local outer_circle = Scene:add_circle({
                    position = input.point - vec2(c,r),
                    radius = 0.045,
                    color = Color:rgba(61, 142, 255, 100),
                    is_static = false,
                })
                outer_circle:temp_set_collides(false);outer_circle:bolt_to(inner_circle)
                inner_circle:set_friction(-0.0);inner_circle:set_restitution(0.1);inner_circle:set_density(-0.15)
            end
            local function add_sand(r,c)
                local inner_circle = Scene:add_circle({
                    position = input.point - vec2(c,r),
                    radius = 0.025,
                    color = Color:hex(0xf7c368),
                    is_static = false,
                })
                inner_circle:set_friction(0.95);inner_circle:set_restitution(0.75);inner_circle:set_density(0.05)
            end
            for r=-0.1,0.1,0.1 do
                for c=-0.1,0.1,0.1 do
                    if not input.shift_pressed then
                        add_water(r,c)
                    else
                        add_sand(r,c)
                    end
                end
            end
        ]]
    }
end
