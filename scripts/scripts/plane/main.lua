--Scene:reset();local plane=Scene:add_circle({position=vec2(0,-9.2),radius=0.2,color=Color:rgba(0,0,0,0),is_static=false,});plane:add_component(Scene:add_component({name="The Plane hfj",id="@frosty/plane/component",code=require('./scripts/@frosty/plane/component.lua','string'),}));Scene:add_attachment({name="The Plane",component={name="The Plane hfj",code='',},parent=plane,local_position=vec2(0,0),local_angle=0,image='~/packages/@frosoto/assets/textures/plane.png',size=0.001,color=Color:hex(0xffffff),light = {color=0xffffff,intensity=0.5,radius=1.25,}});plane:set_density(0.5)local prevWire=plane;for i=1,2 do local wire=Scene:add_box({position=vec2(0,-9.2-(i*0.35)),size=vec2(0.05,0.35),color=Color:hex(0x333545),is_static=false});Scene:add_hinge_at_world_point({point=vec2(0,-9.4-((i -1)*0.35)),object_a=prevWire,object_b=wire,motor_enabled=false,});prevWire=wire end;Scene:add_hinge_at_world_point({point=vec2(0,-9.4-(2*0.35)),object_a=prevWire,object_b=Scene:add_box({position=vec2(0,-9.2-(2.45*0.35)),size=vec2(0.25,0.15),color=Color:hex(0x333545),is_static=true,}),motor_enabled=false,})
Scene:reset();
local plane = Scene:add_circle({
    position=vec2(0,-9.4),
    radius=0.15,
    color=Color:rgba(0,0,0,0)
    ,is_static = false,
});plane:add_component(Scene:add_component({
    name = "The Plane hfj",
    id = "@frosty/plane/component",
    code = require('./packages/@frosoto/scripts/lib/component.lua', 'string'),
}));Scene:add_attachment({
    name = "The Plane",
    component = {
        name = "The Plane hfj",
        code = '',
    },
    parent = plane,
    local_position = vec2(0,0),
    local_angle = 0,
    image = "~/packages/@frosoto/scripts/assets/textures/plane.png",
    size = 0.00075,
    color = Color:hex(0xffffff),
    light = {
        color = 0xffffff,
        intensity = 0.5,
        radius = 1.25,}
});plane:set_density(1.5)
local prevWire = plane;for i=1,2 do
    local wire = Scene:add_box({
        position = vec2(0, -9.4 - (i * 0.25)),
        size = vec2(0.015, 0.25),
        color = Color:hex(0x333545),
        is_static = false
    });Scene:add_hinge_at_world_point({
        point = vec2(0, -9.6 - ((i-1) * 0.25)),
        object_a = prevWire,
        object_b = wire,
        motor_enabled = false,
    });prevWire = wire
end;Scene:add_hinge_at_world_point({
    point = vec2(0, -9.6 - (2 * 0.25)),
    object_a = prevWire,
    object_b = Scene:add_box({
        position = vec2(0, -9.4 - (2.45 * 0.25)),
        size = vec2(0.15,0.15),
        color = Color:hex(0x333545),
        is_static = true,
    }),
    motor_enabled = false,
});Scene:add_attachment({
    name = "Liam Plecak",
    component = {
        name = "Liam hfj",
        code = '',
    },
    parent = Scene:add_box({
        position = vec2(0,-8),
        size = vec2(0.0150, 0.0150),
        color = Color:rgba(0,0,0,0),
        is_static = false,
    }),
    local_position = vec2(0,0),
    local_angle = 0,
    image = "~/packages/@frosoto/scripts/assets/textures/liam.webp",
    size = 0.0000275,
    color = Color:hex(0xffffff),
    light = {
        color = 0xffffff,
        intensity = 0,
        radius = 0,}
});Scene:add_attachment({
    name = "Bryce Hansen",
    component = {
        name = "Bryce hfj",
        code = '',
    },
    parent = Scene:add_box({
        position = vec2(0,-8),
        size = vec2(0.01, 0.02),
        color = Color:rgba(0,0,0,0),
        is_static = false,
    }),
    local_position = vec2(0,0),
    local_angle = 0,
    image = "~/packages/@frosoto/scripts/assets/textures/bryce.webp",
    size = 0.00003,
    color = Color:hex(0xffffff),
    light = {
        color = 0xffffff,
        intensity = 0,
        radius = 0,}
});Scene:add_attachment({
    name = "Folder yeahyeahyeah",
    component = {
        name = "Folder hfj",
        code = '',
    },
    parent = Scene:add_box({
        position = vec2(0,-8),
        size = vec2(0.02, 0.02),
        color = Color:rgba(0,0,0,0),
        is_static = false,
    }),
    local_position = vec2(0,0),
    local_angle = 0,
    image = "~/packages/@frosoto/scripts/assets/textures/folder.webp",
    size = 0.00003,
    color = Color:hex(0xffffff),
    light = {
        color = 0xffffff,
        intensity = 0,
        radius = 0,}
});Scene:add_attachment({
    name = "Amelia Euler",
    component = {
        name = "Amelia hfj",
        code = '',
    },
    parent = Scene:add_box({
        position = vec2(0,-8),
        size = vec2(0.02, 0.02),
        color = Color:rgba(0,0,0,0),
        is_static = false,
    }),
    local_position = vec2(0,0),
    local_angle = 0,
    image = "~/packages/@frosoto/scripts/assets/textures/amelia.webp",
    size = 0.00003,
    color = Color:hex(0xffffff),
    light = {
        color = 0xffffff,
        intensity = 0,
        radius = 0,}
});Scene:add_attachment({
    name = "Charlotte Stern",
    component = {
        name = "Charlotte hfj",
        code = '',
    },
    parent = Scene:add_box({
        position = vec2(0,-8),
        size = vec2(0.02, 0.02),
        color = Color:rgba(0,0,0,0),
        is_static = false,
    }),
    local_position = vec2(0,0),
    local_angle = 0,
    image = "~/packages/@frosoto/scripts/assets/textures/charlotte.webp",
    size = 0.00003,
    color = Color:hex(0xffffff),
    light = {
        color = 0xffffff,
        intensity = 0,
        radius = 0,}
});Scene:add_attachment({
    name = "Taylor Nolan",
    component = {
        name = "Taylor hfj",
        code = '',
    },
    parent = Scene:add_box({
        position = vec2(0,-8),
        size = vec2(0.02, 0.02),
        color = Color:rgba(0,0,0,0),
        is_static = false,
    }),
    local_position = vec2(0,0),
    local_angle = 0,
    image = "~/packages/@frosoto/scripts/assets/textures/taylor.webp",
    size = 0.00003,
    color = Color:hex(0xffffff),
    light = {
        color = 0xffffff,
        intensity = 0,
        radius = 0,}
});Scene:add_attachment({
    name = "Atom hfj",
    component = {
        name = '',
        code = '',
    },
    parent = Scene:add_box({
        position = vec2(0,-8),
        size = vec2(0.02, 0.02),
        color = Color:rgba(0,0,0,0),
        is_static = false,
    }),
    local_position = vec2(0,0),
    local_angle = 0,
    image = "~/packages/@frosoto/scripts/assets/textures/atom.webp",
    size = 0.00003,
    color = Color:hex(0xffffff),
    light = {
        color = 0xffffff,
        intensity = 0,
        radius = 0,}
});Scene:add_attachment({
    name = "circle hfj",
    component = {
        name = '',
        code = '',
    },
    parent = Scene:add_box({
        position = vec2(0,-8),
        size = vec2(0.02, 0.02),
        color = Color:rgba(0,0,0,0),
        is_static = false,
    }),
    local_position = vec2(0,0),
    local_angle = 0,
    image = "~/packages/@frosoto/scripts/assets/textures/circle.webp",
    size = 0.00003,
    color = Color:hex(0xffffff),
    light = {
        color = 0xffffff,
        intensity = 0,
        radius = 0,}
});Scene:add_attachment({
    name = "Stone hfj",
    component = {
        name = '',
        code = '',
    },
    parent = Scene:add_box({
        position = vec2(0,-8),
        size = vec2(0.02, 0.02),
        color = Color:rgba(0,0,0,0),
        is_static = false,
    }),
    local_position = vec2(0,0),
    local_angle = 0,
    image = "~/packages/@frosoto/scripts/assets/textures/stone.webp",
    size = 0.00003,
    color = Color:hex(0xffffff),
    light = {
        color = 0xffffff,
        intensity = 0,
        radius = 0,}
});Scene:add_attachment({
    name = "Airy",
    component = {
        name = "Airy hfj",
        code = '',
    },
    parent = Scene:add_box({
        position = vec2(-1,-10),
        size = vec2(0.65, 1.15),
        color = Color:rgba(255,0,0,0),
        is_static = false,
    }),
    local_position = vec2(0,0),
    local_angle = 0,
    image = "~/packages/@frosoto/scripts/assets/textures/airy.webp",
    size = 0.0015,
    color = Color:hex(0xffffff),
    light = {
        color = 0xffffff,
        intensity = 0,
        radius = 0,}
});
