self:set_density(0.05); Scene:add_attachment({
    name = "Goobly Image",
    component = {
        name = '',
        code = '',
    },
    parent = self,
    local_position = vec2(0.15,0),
    local_angle = 0,
    image = "~/packages/@frosoto/swing_game/assets/goobly.webp",
    size = 0.001,
    color = Color:hex(0xffffff),
    light = {
        color = 0xffffff,
        intensity = 0,
        radius = 0,}
});
local line = nil;local lineExists = false;local lineCenter = nil;local hinge = nil
for i,v in ipairs(Scene:get_all_objects()) do
    if v:get_name() == "qirtiqwitr0qutqrut8qyrt9yq4045uq2045" then
        attachmentPart = v
    end
end
local function swingCheck()
    local magnitudes = {};local lowestDist = nil;
    local hits = Scene:get_all_objects()
    for i,v in ipairs(hits) do
        if v ~= self and (v:get_name() == "Swing Part" or v:get_name() == "Omg toggley buttony") then
            local dist = (self:get_position() - v:get_position()):magnitude()
            table.insert(magnitudes, dist)
            if (lowestDist ~= nil and dist < (self:get_position() - lowestDist:get_position()):magnitude()) or (lowestDist == nil) then
                lowestDist = v;
            end
        end
    end
    return lowestDist
end
local function reset()
    local level = self:get_name(); require('./packages/@frosoto/swing_game/lib/levels/' .. level .. '.lua')
end
function on_step()
    local pos=self:get_position();Camera:set_position(vec2(pos.x,0));Camera:set_orthographic_scale(0.095); attachmentPart:set_position(vec2(pos.x,0))
end
function on_update()
    local pos = self:get_position()
    lineExists = line ~= nil
    if Input:key_just_pressed('R') or (pos.y < -30 and lineExists == false) then
        reset();return
    end
    if ((Input:key_pressed('E') or Input:pointer_pressed()) and obj ~= nil) and lineExists == false  then
        if obj:get_name() == "Omg toggley buttony" then
            obj:send_event("toggle")
        end
        print("found a swing part called",obj:get_name(),"at",obj:get_position())
        line_start = obj:get_position() - vec2(0,0); line_end = self:get_position() - vec2(0,0)
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
            color = Color:hex(0x74e537),
            is_static = false,
        });line:bolt_to(self);hinge = Scene:add_hinge_at_world_point({
            point = line_start,
            object_a = obj,
            object_b = line,
        }); line:temp_set_collides(false);local vel=self:get_linear_velocity();self:set_linear_velocity(vel+vec2(1.5,0.75));if obj:get_name() ~= "Omg toggley buttony" then obj:set_color(Color:hex(0x74e537)) end
    elseif lineExists == true and lineExists and line ~= nil and not (Input:key_pressed('E') or Input:pointer_pressed()) then
        if lineExists == true then
            local hits = Scene:get_objects_in_circle({
                position = line_start,
                radius = 0,
            })
            if hits[1] then
                if hits[1]:get_name() == "Swing Part" then
                    obj = hits[1]
                end
            end
            line:detach(); line:destroy(); lineExists = false; line = nil; lineCenter:destroy(); lineCenter = nil; hinge:destroy(); if obj:get_name() ~= "Omg toggley buttony" then obj:set_color(Color:hex(0x5487e2)) end
        end
    end
    obj = swingCheck();
end
function on_collision_start(data)
    if data.other:get_name() == "Spike yeah yeah yeah" then
        reset()
    end
end
function on_event(id,data)
    --omg line 100
    if id == "finish" and self:get_name() ~= "demo" then
        local level = tonumber(string.sub(self:get_name(),6,string.len(self:get_name()))); require('./packages/@frosoto/swing_game/lib/levels/level' .. level + 1 .. '.lua')
    elseif id == "finish" then
        require('./packages/@frosoto/swing_game/lib/levels/demo.lua')
    end
end