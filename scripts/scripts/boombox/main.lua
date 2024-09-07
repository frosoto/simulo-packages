local function create_boombox(x,y,basecolor,linecolor,static)
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
create_boombox(0, 0, Color:rgb(106, 76, 149), false)
