function on_update()
    local hits = Scene:raycast({
        origin = self:get_position() - vec2(0,50),
        direction = self:get_up_direction(),
        distance = 1000,
        closest_only = false
    })
    for i,v in ipairs(hits) do
        if v.object ~= nil and v.object ~= self then
            v.object:set_body_type(BodyType.Kinematic); v.object:send_event("finish")
        end
    end
end