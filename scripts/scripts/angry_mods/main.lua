-- Use E/Q and A/D to move the slingshot and W to launch it
-- Holy shid i love video gaming
local density = 0.005
local hash = Scene:add_component({
    name = "Slingshot Launcher",
    id = "@frosty/angry_mods/slingshot",
    code = require('./packages/@frosoto/scripts/lib/slingshot.lua', string)
});local debris = Scene:add_component({
    name = "Debris Destroyer",
    id = "@frosty/angry_mods/debris_destroyer",
    code = require('./packages/@frosoto/scripts/lib/debris.lua')
});Scene:reset():add_component(debris)
Scene.background_color = 0x34213d
Scene:set_gravity(vec2(0, -9.805))
print("angry mods time")
local function simulon(x, y, color, density)
    Scene:add_simulon({
        position = vec2(x, y),
            density = density,
            color = color
        })
end;
local function box1(x, y, static)
    local box = Scene:add_box({
        name = "debris",
        position = vec2(x, y),
        size = vec2(1, 2),
        is_static = static,
        color = 0xe5d3b9
    })
    box:set_density(density)
    box:set_restitution(0.2)
end
local function box2(x, y, static)
    local box = Scene:add_box({
        name = "debris",
        position = vec2(x, y),
        size = vec2(2, 1),
        is_static = static,
        color = 0xe5d3b9
    })
    box:set_density(density)
    box:set_restitution(0.2)
end
box2(-9 / 2, -19 / 2, true); box2(-7 / 2, -19 / 2, true); box2(-4 / 2, -19 / 2, true); box1(-2 / 2, -17 / 2, true); box1(-11 / 2, -17 / 2, true)
Scene:add_box({
	position = vec2(18.5, -8.5),
	size = vec2(10, 2.95),
	is_static = true,
	color = 0xe5d3b9
});Scene:add_box({
	position = vec2(18.5 * 1.8, -8.5),
	size = vec2(10, 2.95),
	is_static = true,
	color = 0xe5d3b9
});
for i2=1,2 do
    local x=15 * i2;local y=-6;local h=false;local idk=1;
for i=1,26 do
    x = 15 * i2
    if h == false then
        for i=1,4 do
            box1(x, y, false)
            x+=(4.75 / 2)
        end
        h=true
        y+=3 / 2
    else
        box2(x + 1, y, false)
        x+=5.5 / 2
        box2(x + (1.5 / 2), y, false)
        x+=5 / 2
        box2(x + (1.5 / 2), y, false)
        h=false
        y+=3 / 2
    end
end; end;
simulon(42 / 2, -19 / 2, 0xa9bc67, 0.01);simulon(32 / 2, -19 / 2, 0xa9bc67, 0.01);simulon(37 / 2, -12 / 2, 0xa9bc67, 0.01); simulon(37 /2, 1 / 2, 0xa9bc67, 0.01);
simulon(42 / 2, 19 / 2, 0xa9bc67, 0.01); simulon(32 / 2, 19 / 2, 0xa9bc67, 0.01);simulon(34.5 / 2, 34 / 2, 0xa9bc67, 0.01); simulon(42 / 2, 35 / 2, 0xa9bc67, 0.01);
--simulon(32 / 2, -12 / 2, 0xa9bc67); simulon(37 / 2, 25 / 2, 0xa9bc67);
simulon(-3, -6, 0xe55f50, 0.025); simulon(-3, -5, 0x5bc0fa, 0.01); simulon(-3, -4, 0xe9c937, 0.005); simulon(-3, -3, 0x1e1f3d, 0.025); for i,v in ipairs(Scene:get_all_objects()) do
    if v:get_name() == "Simulon Head" and v.color == Color:hex(0x1e1f3d) then
        v:add_component(Scene:add_component({
            name = "Bomb",
            id = "@frosty/angry_mods/bomb",
            code = [[
                local exploded = false; local seconds = 0;
                function on_collision_start(data)
                    if data.other:get_name() == "debris" and data.other:get_body_type() == BodyType.Dynamic and self.color ~= 0xff0000 and self:temp_get_is_static() == false then
                        Scene:explode({
                            position = self:get_position(),
                            radius = 0.025,
                            impulse = 0.05,
                        })
                        self:set_color(0xff0000); self:set_name("Light"); exploded = true
                    end
                end
                function on_step()
                    if exploded then
                        seconds+=1
                        if seconds == 35 then
                            self:destroy()
                        end
                    end
                end
            ]]
        }))
        v:temp_set_is_static(true)
    elseif v:get_name() == "Simulon Head" and v.color == Color:hex(0xe9c937) then
        v:add_component(Scene:add_component({
            name = "Chuck",
            id = "@frosty/angry_mods/chuck",
            code = [[
                function on_step()
                    if Input:key_just_released('W') and self:get_body_type() == BodyType.Dynamic then
                        self:set_linear_velocity(vec2(25, 25))
                    end
                end
            ]]
        }))
        v:set_body_type(BodyType.Kinematic)
    elseif string.sub(v:get_name(), 1, 7) == "Simulon" and v.color == Color:hex(0x5bc0fa) then
        v:add_component(Scene:add_component({
            name = "The Blues",
            id = "@frosty/angry_mods/blues",
            code = [[
                function on_step()
                    if Input:key_just_released('W') and self:get_body_type() == BodyType.Dynamic then
                        self:detach()
                        self:set_linear_velocity(vec2(30, 30));
                    end
                end
            ]]
        }))
        v:set_body_type(BodyType.Kinematic)
    end
end
local X = -1; local Y = -6; local increment1 = 0.15; local increment2 = 0; local prevCap = Scene:add_capsule({
    position = vec2(X, Y),
    local_point_a = vec2(increment1, -0.25),
    local_point_b = vec2(0, 0),
    radius = 0.1,
    is_static = true,
    color = (math.random(0x40, 0xff) * 0x10000) + (math.random(0x40, 0xff) * 0x100) + math.random(0x40, 0xff)
}); X+=increment1;increment1+=0.15;increment2+=0.25; prevCap:add_component(hash)
for i=1,4 do
    print(increment1)
    local cap = Scene:add_capsule({
        position = vec2(X, Y - increment2),
        local_point_a = vec2(increment1, -0.25),
        local_point_b = vec2(0, 0),
        radius = 0.1,
        is_static = false,
        color = (math.random(0x40, 0xff) * 0x10000) + (math.random(0x40, 0xff) * 0x100) + math.random(0x40, 0xff)
    })
    cap:set_density(0.075); cap:add_component(hash); cap:add_component(debris)
    if prevCap ~= nil then
        Scene:add_hinge_at_world_point({
            point = vec2(X, Y - increment2),
            object_a = prevCap,
            object_b = cap,
            motor_enabled = false,
        })
    end
    prevCap = cap
    X+=increment1;increment1+=0.15;increment2+=0.25;
end
for i=1,4 do
    print(increment1)
    local cap = Scene:add_capsule({
        position = vec2(X, Y - increment2),
        local_point_a = vec2(increment1, 0.25),
        local_point_b = vec2(0, 0),
        radius = 0.1,
        is_static = false,
        color = (math.random(0x40, 0xff) * 0x10000) + (math.random(0x40, 0xff) * 0x100) + math.random(0x40, 0xff)
    })
    cap:set_density(0.075); cap:add_component(hash); cap:add_component(debris)
    if prevCap ~= nil then
        Scene:add_hinge_at_world_point({
            point = vec2(X, Y - increment2),
            object_a = prevCap,
            object_b = cap,
            motor_enabled = false,
        })
    end
    prevCap = cap
    X+=increment1;increment1-=0.15;increment2-=0.25;
end;local cap = Scene:add_capsule({
    position = vec2(X, Y - increment2),
    local_point_a = vec2(increment1, 0.25),
    local_point_b = vec2(0, 0),
    radius = 0.1,
    is_static = true,
    color = (math.random(0x40, 0xff) * 0x10000) + (math.random(0x40, 0xff) * 0x100) + math.random(0x40, 0xff)
});Scene:add_hinge_at_world_point({
    point = vec2(X, Y - increment2),
    object_a = prevCap,
    object_b = cap,
    motor_enabled = false,
}); cap:add_component(hash)
