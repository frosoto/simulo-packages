function on_update()
    if Input:pointer_just_pressed() then
        on_pointer_down(Input:snap_if_preferred(Input:pointer_pos()))
    end
end

function on_pointer_down(point)
    print("Pointer down at " .. point.x .. ", " .. point.y)
    runtime_eval{
        input = {
            point = point
        },
        code = [[
            local hits = Scene:get_objects_in_circle({
                position = input.point,
                radius = 0
            })
            if hits[1] ~= nil then
                hits[1]:set_angle(0); hits[1]:set_angle_locked(true)
                if not Input:key_pressed('ShiftLeft') then
                    Scene:add_attachment({
                        name = "Gyroscope",
                        component = {
                            name = '',
                            code = '',
                        },
                        parent = hits[1],
                        local_position = vec2(0,0),
                        local_angle = 0,
                        image = "~/packages/@frosoto/epic_tools/tools/gyroscope/icon.png",
                        size = 0.00075,
                        color = Color:hex(0xffffff),
                        light = {
                            color = 0xffffff,
                            intensity = 0,
                            radius = 0,}
                    });
                end
            end
        ]]
    }
end
