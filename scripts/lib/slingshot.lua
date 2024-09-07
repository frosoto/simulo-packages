function on_step()
    if Input:key_just_released('W') then
        self:apply_force_to_center(vec2(30, 15))
    end;if Input:key_pressed('E') then
        local pos = self:get_position()
        self:set_position(vec2(pos.x, pos.y + 0.05))
    end;if Input:key_pressed('Q') then
        local pos = self:get_position()
        self:set_position(vec2(pos.x, pos.y - 0.05))
    end;if Input:key_pressed('A') then
        local pos = self:get_position()
        self:set_position(vec2(pos.x - 0.1, pos.y))
    end;if Input:key_pressed('D') then
        local pos = self:get_position()
        self:set_position(vec2(pos.x + 0.1, pos.y))
    end
end