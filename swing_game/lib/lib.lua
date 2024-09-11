function add_trampoline(angle, position)
    local trampoline = Scene:add_component({
        name = "Trampoline",
        id = "@frosoto/swing_game/trampoline",
        code = require('./packages/@frosoto/swing_game/lib/trampoline.lua', 'string'),
    })
    local rest=2.75;local main=Scene:add_box({
        position=position,size=vec2(9, 1),color=Color:hex(0x5487e2),is_static=true
    });local color = main:get_color();for i=1,2 do
        local capsule = Scene:add_capsule({
            position=position+vec2(0,-1.5+(i*1)),local_point_a=vec2(4.35,0),local_point_b=vec2(-4.35,0),radius=0.5,color=color,is_static=false
        });capsule:bolt_to(main);capsule:set_restitution(rest);--capsule:add_component(trampoline)
    end;for i=1,2 do
        local capsule = Scene:add_capsule({
            position=position+vec2(-13.5+(i*9),0),local_point_a=vec2(0,0.5),local_point_b=vec2(0,-0.5),radius=0.4,color=color,is_static=false
        });capsule:bolt_to(main);capsule:set_restitution(rest);--capsule:add_component(trampoline)
    end;main:set_angle(angle);main:set_restitution(rest);main:add_component(trampoline);
    return main;
end
function add_moving_platform(position,Type)
    local platform = Scene:add_component({
        name = "Moving Platform",
        id = "@frosoto/swing_game/platform",
        code = require('./packages/@frosoto/swing_game/lib/platform.lua', 'string'),
    })
    local main=Scene:add_box({
        name="Swing Part",position=position,size=vec2(9, 1),color=Color:hex(0x5487e2),is_static=false
    });local color = main:get_color();main:add_component(platform);main:send_event(Type);for i=1,2 do
        local capsule = Scene:add_capsule({
            position=position+vec2(0,-1.5+(i*1)),local_point_a=vec2(4.35,0),local_point_b=vec2(-4.35,0),radius=0.5,color=color,is_static=false
        });capsule:bolt_to(main);capsule:set_body_type(BodyType.Kinematic)
    end;for i=1,2 do
        local capsule = Scene:add_capsule({
            position=position+vec2(-13.5+(i*9),0),local_point_a=vec2(0,0.5),local_point_b=vec2(0,-0.5),radius=0.4,color=color,is_static=false
        });capsule:bolt_to(main);capsule:set_body_type(BodyType.Kinematic)
    end;main:set_body_type(BodyType.Kinematic);
    Scene:add_attachment({
        name = "Platform Arrow",
        component = {
            name = '',
            code = '',
        },
        parent = main,
        local_position = vec2(0,0),
        local_angle = 0,
        image = "~/packages/@frosoto/swing_game/assets/" .. Type .. ".png",
        size = 0.00075,
        color = Color:hex(0xffffff),
        light = {
            color = 0xffffff,
            intensity = 0,
            radius = 0,}
    });
    return main;
end
function add_finish_line(position)
    local component = Scene:add_component({
        name = "Finish Line",
        id = "@frosoto/swing_game/finishLine",
        code = require('./packages/@frosoto/swing_game/lib/finishLine.lua','string'),
    })
    local finish_line = Scene:add_circle({
        position = position,
        radius = 0.1,
        color = Color:rgba(0,0,0,0),
        is_static = true
    });finish_line:temp_set_collides(false);finish_line:add_component(component);
    Scene:add_attachment({name="finish line",component={name='',code=''},parent=finish_line,local_position=vec2(0,0),local_angle=0,image='~/packages/@frosoto/swing_game/assets/finish_line.png',size=0.05,color=Color:hex(0xffffff),light={
        color = 0xffffff,
        intensity = 0,
        radius = 0,}})
end
local function generate_polygon_points(n, size)
    local points = {}
    for i = 0, n - 1 do
        local angle = (2 * math.pi / n) * i
        table.insert(points, vec2(size * math.cos(angle), size * math.sin(angle)))
    end
    return points
end
function add_spike(angle,position)
    local points = generate_polygon_points(3, 1)
    local spike = Scene:add_polygon({
        name = "Spike yeah yeah yeah",
        position = position,
        points = points,
        color = Color:hex(0x5487e2),
        is_static = true,
        radius = 0,
    })
    spike:set_angle(angle);return spike;
end
function add_swing_circle(position)
    local swing = Scene:add_circle({
        name = "Swing Part",
        position = position,
        radius = 1,
        color = Color:hex(0x5487e2),
        is_static = true,
    })
    Scene:add_attachment({
        name = "Swing Part",
        component = {
            name = '',
            code = '',
        },
        parent = swing,
        local_position = vec2(0,0),
        local_angle = 0,
        image = "~/packages/@frosoto/swing_game/assets/swing.png",
        size = 0.0005,
        color = Color:hex(0xffffff),
        light = {
            color = 0xffffff,
            intensity = 0,
            radius = 0,}
    });
    return swing;
end
function add_door(position,size,color)
    local door = Scene:add_box({
        name = "Dooring it up oh yeah",
        position = position,
        size = size,
        color = color,
        is_static = false,
    });door:set_body_type(BodyType.Kinematic);Scene:add_attachment({name="Door",component={name='',code=''},parent=door,local_position=vec2(0,0),local_angle=0,
    image='~/packages/@frosoto/swing_game/assets/lock.png',size=0.005,color=Color:hex(0x000000),light={color=color,intensity=0,radius=0}});
    local doorCode = Scene:add_component({
        name = "Door",
        id = "@frosoto/swing_game/door",
        code = require('./packages/@frosoto/swing_game/lib/door.lua','string'),
    });door:add_component(doorCode);
    return door
end
function add_button(position,angle,color)
    local button = Scene:add_box({
        name = "Omg toggley buttony",
        position = position,
        size = vec2(1.5,0.5),
        color = color,
        is_static = false,
    });button:set_body_type(BodyType.Kinematic);button:add_component(Scene:add_component({
        name = "Toggle Button",
        id = "@frosoto/swing_game/button",
        code = require('./packages/@frosoto/swing_game/lib/button.lua','string')
    }))
    return button
end