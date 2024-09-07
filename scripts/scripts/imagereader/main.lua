Scene:reset()
local image = temp_load_image('./packages/@frosoto/scripts/assets/textures/image.png') -- Replace the "image.png" file with your desired image

local w = image.width
local h = image.height
local pxSize = 0.5 -- Change this to change the pixel size
local static = true
local shape = "box" -- Set this to "box", "circle", "capsule", "rgb", or "simulon"

local lastpixel = nil -- Using this for bolting
for y = (h * pxSize) * -1, 0, pxSize do
    for x=0,w * pxSize,pxSize do
        local pixel = image:get_pixel(vec2((x / pxSize) - 1, (y / pxSize) + (h - 1))) -- The silly equations are just for getting the correct pixel
    
        -- Makes sure it doesn't create transparent pixels
        if pixel.a ~= 0 then
            if shape == "box" then
                local box = Scene:add_box({
                    name = "image pixel",
                    position = vec2(x, (y * -1)),
                    size = vec2(pxSize, pxSize),
                    color = Color:rgb(pixel.r, pixel.g, pixel.b),
                    is_static = static
                })
            elseif shape == "circle" then
                local circle = Scene:add_circle({
                    name = "image pixel",
                    position = vec2(x, (y * -1)),
                    radius = pxSize,
                    color = Color:rgb(pixel.r, pixel.g, pixel.b),
                    is_static = static
                })
            elseif shape == "capsule" then
                local capsule = Scene:add_capsule({
                    position = vec2(x, (y * -1)),
                    local_point_a = vec2(0, pxSize),
                    local_point_b = vec2(0, pxSize * -1),
                    radius = pxSize / 2,
                    is_static = static,
                    color = Color:rgb(pixel.r, pixel.g, pixel.b),
                })
            elseif shape == "rgb" then
                Scene:add_capsule({
                    position = vec2((x*2.1) + ((pxSize / 1.5) * 2), (y * -2)),
                    local_point_a = vec2(0, 1.9/3),
                    local_point_b = vec2(0, -1.9/3),
                    radius = pxSize / 3,
                    is_static = true,
                    color = Color:rgb(0, 0, pixel.b),
                });
                Scene:add_capsule({
                    position = vec2((x*2.1) + (pxSize / 1.5), (y * -2)),
                    local_point_a = vec2(0, 1.9/3),
                    local_point_b = vec2(0, -1.9/3),
                    radius = pxSize / 3,
                    is_static = true,
                    color = Color:rgb(0, pixel.g, 0),
                });
                Scene:add_capsule({
                    position = vec2((x*2.1), (y * -2)),
                    local_point_a = vec2(0, 1.9/3),
                    local_point_b = vec2(0, -1.9/3),
                    radius = pxSize / 3,
                    is_static = true,
                    color = Color:rgb(pixel.r, 0, 0),
                });
            elseif shape == "simulon" then
                Scene:add_simulon({
                    position = vec2(x, (y * -1)),
                    density = 1,
                    color = Color:rgb(pixel.r, pixel.g, pixel.b),
                })
            end
        end
    end
end
