local controller = Scene:add_component({
    name = "Goobly Controller",
    id = "@frosty/goobly/controller",
    code = require('./scripts/@frosty/goobly/controller.lua', 'string'),
})
local function spawn_goobly(pos)
    local goobly = Scene:add_box({
        name = "goobly",
        position = pos,
        size = vec2(1, 1.75),
        color = Color:hex(0x67f538),
        is_static = false,
    }); goobly:add_component(controller)
    
    local left_eye = Scene:add_circle({
        name = "eyeball",
        position = vec2(pos.x - 0.2, pos.y + 0.55),
        radius = 0.15,
        color = Color:hex(0xffffff),
        is_static = false,
    })
    local right_eye = Scene:add_circle({
        name = "eyeball",
        position = vec2(pos.x + 0.2, pos.y + 0.55),
        radius = 0.15,
        color = Color:hex(0xffffff),
        is_static = false,
    })
    left_eye:bolt_to(goobly); right_eye:bolt_to(goobly);
    local left_pupil = Scene:add_circle({
        name = "pupil",
        position = vec2(pos.x - 0.15, pos.y + 0.55),
        radius = 0.05,
        color = Color:hex(0x000000),
        is_static = false,
    }); left_pupil:temp_set_collides(false)
    Scene:add_hinge_at_world_point({
        point = vec2(pos.x - 0.125, pos.y + 0.55),
        object_a = left_pupil,
        object_b = left_eye,
        motor_enabled = false,
    }); local right_pupil = Scene:add_circle({
        name = "pupil",
        position = vec2(pos.x + 0.25, pos.y + 0.55),
        radius = 0.05,
        color = Color:hex(0x000000),
        is_static = false,
    }); right_pupil:temp_set_collides(false)
    Scene:add_hinge_at_world_point({
        point = vec2(pos.x + 0.225, pos.y + 0.55),
        object_a = right_pupil,
        object_b = right_eye,
        motor_enabled = false,
        motor_speed = 1, -- radians per second
        max_motor_torque = 10, -- maximum torque for the motor, in newton-meters
    });

    local arm = Scene:add_capsule({
        position = vec2(pos.x + 0.65, pos.y + 0.1),
        local_point_a = vec2(0.325, 0),
        local_point_b = vec2(-0.325, 0),
        radius = 0.1,
        color = Color:hex(0x97ff52),
        is_static = false,
    });arm:add_component(controller)
    Scene:add_hinge_at_world_point({
        point = vec2(pos.x + 0.35, pos.y + 0.1),
        object_a = arm,
        object_b = goobly,
    });
end;

return spawn_goobly;