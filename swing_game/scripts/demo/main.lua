Scene:reset()
local player =  Scene:add_circle({
    position = vec2(0,-9),
    radius = 0.75,
    color = Color:hex(0xff0000),
    is_static = false,
})
player:add_component(Scene:add_component({
    name = "player swing script",
    id = "@frosty/swing/component",
    code = require('./packages/@frosoto/swing_game/lib/swingCode.lua', 'string'),
}))

for i=1,5 do
    Scene:add_circle({
        name = "Swing Part",
        position = vec2((i - 3) * 15, 2),
        radius = 1,
        color = Color:hex(0xffffff),
        is_static = true,
    })
end
