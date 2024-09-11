require('./packages/@frosoto/swing_game/lib/lib.lua')
Scene:reset():destroy();
local attachmentPart = Scene:add_circle({name="qirtiqwitr0qutqrut8qyrt9yq4045uq2045",position=vec2(0,0),radius=0,color=Color:rgba(0,0,0,0),is_static=true}); Scene:add_attachment({
    name = "bg attachment",
        component = {
            name = '',
            code = '',
        },
        parent = attachmentPart,
        local_position = vec2(0,0),
        local_angle = 0,
        image = "~/packages/@frosoto/swing_game/assets/gradient.webp",
        size = 0.045,
        color = Color:rgba(255,255,255,255),
        light = {
            color = 0xffffff,
            intensity = 0,
            radius = 0,}
}); attachmentPart:temp_set_collides(false);
add_finish_line(vec2(-6 * -25,0))
local player =  Scene:add_circle({
    name = "demo",
    position = vec2(0,0),
    radius = 0.75,
    color = Color:rgba(0,0,0,0),
    is_static = false,
});player:add_component(Scene:add_component({
    name = "player swing script",
    id = "@frosty/swing/component",
    code = require('./packages/@frosoto/swing_game/lib/swingCode.lua', 'string'),
}));
for i=1,6 do
    add_swing_circle(vec2((i - 1) * 25, math.random(7,10)))
end
add_trampoline(0, vec2(0,-20));for i=1,2 do
    add_trampoline(0, vec2(i * 20,math.random(-20.5, -20)))
end
local spike=add_spike(-0.525,vec2(55,-6.525));spike:set_body_type(BodyType.Kinematic);spike:bolt_to(add_moving_platform(vec2(55,-8),"horizontal"));add_moving_platform(vec2(55,-8),"vertical");
add_button(vec2(20,-19),0,Color:hex(0xfeea1d));add_door(vec2(55,0),vec2(15,500),Color:hex(0xfeea1d))
