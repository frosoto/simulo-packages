local code = [[
    local mass = self:get_mass()
    function on_step()
        Scene:explode({
            position = self:get_position(),
            radius = 4.5 * mass,
            impulse = -0.2 * mass
        })
        --self:set_linear_velocity(vec2(0,0));
        for i,v in ipairs(Scene:get_objects_in_circle({position=self:get_position(),radius=2.25*mass})) do
            if v ~= self then
                v:apply_force_to_center(-Scene:get_gravity()*v:get_mass());
            end
        end
    end
]]
function on_update()
    if Input:pointer_just_pressed() then
        on_pointer_down(Input:snap_if_preferred(Input:pointer_pos()))
    end
end

function on_pointer_down(point)
    print("Pointer down at " .. point.x .. ", " .. point.y)
    runtime_eval{
        input = {
            point = point,
            code = code
        },
        code = [[
            local hits = Scene:get_objects_in_circle({
                position = input.point,
                radius = 0
            })
            local gravity = Scene:add_component({
                name = "gravity",
                id = "@frosoto/gravity_well/gravity",
                code = input.code
            })
            if hits[1] ~= nil then
                hits[1]:add_component(gravity);
                if not Input:key_pressed('ShiftLeft') then
                    Scene:add_attachment({
                        name = "Gravity Well",
                        component = {
                            name = '',
                            code = '',
                        },
                        parent = hits[1],
                        local_position = vec2(0,0),
                        local_angle = 0,
                        image = "~/packages/@frosoto/epic_tools/tools/gravity/icon.png",
                        size = 0.00075,
                        color = Color:hex(0xffffff),
                        light = {
                            color = 0xffffff,
                            intensity = 0,
                            radius = 0,}
                    });
                end
            else
                local radius = 0.45
                if Input:key_pressed('ShiftLeft') then
                    radius = 0.9
                end
                local well = Scene:add_circle({
                    name = "Gravity Well",
                    position = input.point,
                    radius = radius,
                    color = Color:rgba(111, 157, 255, 64),
                    is_static = false
                });well:add_component(gravity);well:set_body_type(BodyType.Static)
                Scene:add_attachment({
                    name = "Gravity Well",
                    component = {
                        name = '',
                        code = '',
                    },
                    parent = well,
                    local_position = vec2(0,0),
                    local_angle = 0,
                    image = "~/packages/@frosoto/epic_tools/tools/gravity/icon.png",
                    size = 0.00075 * (radius / 0.45),
                    color = Color:hex(0xffffff),
                    light = {
                        color = 0xffffff,
                        intensity = 0,
                        radius = 0
                    }
                });
            end
        ]]
    }
end
