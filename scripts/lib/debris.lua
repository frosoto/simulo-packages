function on_collision_start(data)
    if data.other:get_name() == "debris" and data.other:temp_get_is_static() == false then
        data.other:destroy()
    end
end