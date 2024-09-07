function create_boombox(x,y,basecolor,linecolor,static)
local circlecolor = Color:rgb(basecolor.r - 44, basecolor.g - 38, basecolor.b - 55)
local linecolor = Color:rgb(basecolor.r - 26, basecolor.g - 23, basecolor.b - 32)

-- Creating the base
local box = Scene:add_box({
    position = vec2(x, y),
    size = vec2(1, 0.5),
    color = basecolor,
    is_static = static,
})
local capsule1 = Scene:add_capsule({ -- Top capsule
    position = vec2(x, y + 0.25),
    local_point_a = vec2(-0.5, 0),
    local_point_b = vec2(0.5, 0),
    radius = 0.05,
    is_static = static,
    color = basecolor,
})
local capsule2 = Scene:add_capsule({ -- Bottom capsule
    position = vec2(x, y - 0.25),
    local_point_a = vec2(-0.5, 0),
    local_point_b = vec2(0.5, 0),
    radius = 0.05,
    is_static = static,
    color = basecolor,
})
local capsule3 = Scene:add_capsule({ -- Right capsule
    position = vec2(x + 0.5, y),
    local_point_a = vec2(0,-0.25),
    local_point_b = vec2(0,0.25),
    radius = 0.05,
    is_static = static,
    color = basecolor,
})
local capsule4 = Scene:add_capsule({ -- Left capsule
    position = vec2(x - 0.5, y),
    local_point_a = vec2(0,-0.25),
    local_point_b = vec2(0,0.25),
    radius = 0.05,
    is_static = static,
    color = basecolor,
})
box:bolt_to(capsule1); capsule1:bolt_to(capsule2);
capsule2:bolt_to(capsule3); capsule3:bolt_to(capsule4);
--------------------------------------------------------

-- Creating the handle
local handle1 = Scene:add_capsule({ -- Left handle capsule
    position = vec2(x - 0.4, y + 0.1),
    local_point_a = vec2(0,-0.25),
    local_point_b = vec2(0,0.25),
    radius = 0.05,
    is_static = static,
    color = basecolor,
})
local handle2 = Scene:add_capsule({ -- Right handle capsule
    position = vec2(x + 0.4, y + 0.1),
    local_point_a = vec2(0,-0.25),
    local_point_b = vec2(0,0.25),
    radius = 0.05,
    is_static = static,
    color = basecolor,
})
local handle3 = Scene:add_capsule({ -- Top handle capsule
    position = vec2(x, y + 0.375),
    local_point_a = vec2(-0.4, 0),
    local_point_b = vec2(0.4, 0),
    radius = 0.05,
    is_static = static,
    color = basecolor,
})
handle1:bolt_to(handle2); handle2:bolt_to(handle3);
handle1:bolt_to(capsule1);
--------------------------------------------------------

-- Creating the speaker circles
local circle1 = Scene:add_circle({
    position = vec2(x + 0.275, y - 0.085),
    radius = 0.175,
    color = circlecolor,
    is_static = false,
})
local circle2 = Scene:add_circle({
    position = vec2(x - 0.275, y - 0.085),
    radius = 0.175,
    color = circlecolor,
    is_static = false,
})
circle1:bolt_to(box); circle2:bolt_to(box);
--------------------------------------------------------

-- Creating the detail lines
local line1 = Scene:add_box({
    position = vec2(x, y + 0.135),
    size = vec2(1.1, 0.05),
    color = linecolor,
    is_static = static,
})
local line2 = Scene:add_box({
    position = vec2(x, y + 0.235),
    size = vec2(0.5, 0.05),
    color = linecolor,
    is_static = static,
})
local line3 = Scene:add_box({
    position = vec2(x, y + 0.055),
    size = vec2(0.145, 0.125),
    color = linecolor,
    is_static = static,
})
line1:bolt_to(box); line2:bolt_to(box); line3:bolt_to(box)
end

local controller = Scene:add_component({
    name = "Goobly Controller",
    id = "@frosty/goobly/controller",
    code = require('./packages/@frosoto/scripts/lib/controller.lua', 'string'),
})
function spawn_goobly(pos)
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

function spawn_joblo(pos)
    local leg1 = Scene:add_capsule({
        position = pos - vec2(0.1,0.45),
        local_point_a = vec2(0,-0.2),
        local_point_b = vec2(0,0),
        radius = 0.1,
        color = Color:rgb(97, 46, 131),
        is_static = false,
    })
    local leg2 = Scene:add_capsule({
        position = pos - vec2(0.1,0.695),
        local_point_a = vec2(0,-0.15),
        local_point_b = vec2(0,0),
        radius = 0.1,
        color = Color:rgb(97, 46, 131),
        is_static = false,
    })
    local foot = Scene:add_capsule({
        position = pos - vec2(0.25,0.935),
        local_point_a = vec2(0.2,0),
        local_point_b = vec2(0,0),
        radius = 0.1,
        color = Color:rgb(97, 46, 131),
        is_static = false,
    })
    leg2:bolt_to(foot);foot:set_density(100);leg1:set_restitution(0);leg2:set_restitution(0);leg1:set_density(0.01);leg2:set_density(0.01);
    local joblo = Scene:add_circle({
        name = "joblo",
        position = pos,
        radius = 0.5,
        color = Color:rgb(122, 65, 159),
        is_static = false,
    });joblo:set_restitution(0);joblo:set_density(0.01);Scene:add_hinge_at_world_point({
        point = pos - vec2(0,0.25),
        object_a = joblo,
        object_b = leg1,
    });Scene:add_hinge_at_world_point({
        point = pos - vec2(0.15,0.645),
        object_a = leg1,
        object_b = leg2,
    });
    local eye = Scene:add_circle({
        name = "eyeball",
        position = vec2(pos.x - 0.2, pos.y),
        radius = 0.15,
        color = Color:hex(0xffffff),
        is_static = false,
    });eye:set_restitution(0);eye:set_density(0.01)
    eye:bolt_to(joblo);
    local pupil = Scene:add_circle({
        name = "pupil",
        position = pos - vec2(0.25,0),
        radius = 0.05,
        color = Color:hex(0x000000),
        is_static = false,
    });pupil:temp_set_collides(false);eye:set_restitution(0);eye:set_density(0.01)
    Scene:add_hinge_at_world_point({
        point = pos - vec2(0.225,0),
        object_a = pupil,
        object_b = eye,
        motor_enabled = false,
    });
end;
