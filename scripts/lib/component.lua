function on_step()
    local pos = self:get_position()
    Scene:explode({
        position = vec2(pos.x, pos.y + 0.1),
        radius = 1.2,
        impulse = -0.0075,
    })
    self:set_linear_velocity(vec2(0,0.25))
    if Input:key_pressed('T') then
        self:detach()
    end
end