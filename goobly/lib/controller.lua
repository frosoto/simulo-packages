ragdoll = true; attacking = false; count = 0; local cameraFollow = false;
local function jump()
    local pos = self:get_position(); local onFloor = false; local x = pos.x - 0.5;
    for i=0,1,0.1 do
        local hits = Scene:get_objects_in_circle({
            position = vec2(x + i, pos.y - 0.875),
            radius = 0,
        })
        for i,v in ipairs(hits) do
            if v:get_name() ~= "goobly" then
                onFloor = true
            end
        end
    end
    return onFloor
end;
local goobly = nil
for i,v in ipairs(self:get_connected_objects()) do
    if self:get_name() == "Capsule" and v:get_name() == "goobly" then
        goobly = v; print('found goobly')
    end
    if self:get_name() == "goobly" and v:get_name() == "Capsule" then
        goobly = v; print("found the arm")
    end
end
function on_step()
    if Input:key_just_pressed('X') then
        ragdoll = not ragdoll
    end
    if Input:key_just_pressed('C') then
        cameraFollow = not cameraFollow;
    end
    if cameraFollow and self:get_name() == "goobly" then
        Camera:set_position(self:get_position()); Camera:set_orthographic_scale(0.02)
    end
    if self:get_name() == "goobly" then
        if not ragdoll then
            self:set_angle(0)
            if Input:key_pressed('D') then
                --print("skedaddling right")
                local vel = self:get_linear_velocity()
                self:set_linear_velocity(vec2(5, vel.y))
            end
            if Input:key_pressed('A') then
                --print("skedaddling left")
                local vel = self:get_linear_velocity()
                self:set_linear_velocity(vec2(-5, vel.y))
            end
            if Input:key_pressed('W') and jump() then
                print("YAHOOO")
                local vel = self:get_linear_velocity()
                self:set_linear_velocity(vec2(vel.x, 7.5))
            end
        end
    else
        if not ragdoll and not attacking then
            self:set_angle(1.5707963705062866)
        end
        if Input:key_pressed('E') then
            self:set_angular_velocity(-50); attacking = true
        end
        if attacking then
            count += 1
            if count >= 45 then
                count = 0; attacking = false
            end
        end
    end
end
function on_collision_start(data)
    if attacking and data.other:get_name() ~= "Simulo Planet" then
        data.other:detach(); data.other:apply_force_to_center(vec2(50, 0)); Scene:explode({
            position = data.other:get_position(),
            radius = 0.1,
            impulse = 2,
        }); data.other:set_body_type(BodyType.Dynamic)
    end
end
function on_event(id, data)
    if self:get_name() == "Capsule" and id == "ragdoll" then
        if ragdoll == false then
            ragdoll = true
        else
           ragdoll = false 
        end
    end
end