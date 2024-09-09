local line = nil;local lineExists = false;local lineCenter = nil;local hinge = nil
local function swingCheck()
    local magnitudes = {};local lowestDist = nil;
    local hits = Scene:get_objects_in_circle({
        position = self:get_position(),
        radius = 10,
    })
    for i,v in ipairs(hits) do
        if v ~= self and v:get_name() == "Swing Part" then
            local dist = (self:get_position() - v:get_position()):magnitude()
            table.insert(magnitudes, dist)
            if (lowestDist ~= nil and dist < lowestDist) or (lowestDist == nil) then
                lowestDist = v;
            end
        end
    end
    return lowestDist
end

function on_step()
    Camera:set_position(self:get_position())
    local obj = swingCheck();
    if line ~= nil then
        lineExists = true
    else
        lineExists = false
    end
    if Input:key_pressed('D') then
        local vel = self:get_linear_velocity()
        self:set_linear_velocity(vec2(15, vel.y))
    elseif Input:key_pressed('A') then
        local vel = self:get_linear_velocity()
        self:set_linear_velocity(vec2(-15, vel.y))
    end
    if Input:key_pressed('W') then
        local hits = Scene:get_objects_in_circle({
            position = self:get_position() - vec2(0,0.81),
            radius = 0.1,
        })
        if hits[1] ~= nil and hits[1] ~= self then
            self:apply_force_to_center(vec2(0, 500))
        end
    end
    if (Input:key_pressed('E') and obj ~= nil) and lineExists == false  then
        local line_start = obj:get_position() - vec2(0,1); local line_end = self:get_position() + vec2(0,0.75)
        local vel = self:get_linear_velocity()
        lineCenter = Scene:add_circle({
            position = line_start - line_end,
            radius = 0.5,
            color = Color:rgba(127, 255, 127, 0),
            is_static = true,
        });lineCenter:temp_set_collides(false)
        line = Scene:add_capsule({
            position = line_start - line_end,
            local_point_a = lineCenter:get_local_point(line_start),
            local_point_b = lineCenter:get_local_point(line_end),
            radius = 0.1,
            color = Color:hex(0xffffff),
            is_static = false,
        });line:bolt_to(self);hinge = Scene:add_hinge_at_world_point({
            point = line_start,
            object_a = obj,
            object_b = line,
        }); line:temp_set_collides(false); self:set_linear_velocity(vel)
    elseif lineExists == true and lineExists and line ~= nil and not (Input:key_pressed('E')) then
        if lineExists == true then
            line:detach(); line:destroy(); lineExists = false; line = nil; lineCenter:destroy(); lineCenter = nil; hinge:destroy()
        end
    end
end
