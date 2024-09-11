local Type=nil;function on_event(id,data)
    Type = id;    
end
local reachedGoal = false;local count = 0
function on_step()
    count += 1;
    if Type == "horizontal" then
        if reachedGoal then
            self:set_linear_velocity(vec2(-5,0))--self:set_position(self:get_position() - vec2(0,0.025))
        else
            self:set_linear_velocity(vec2(5,0))--self:set_position(self:get_position() + vec2(0,0.025))
        end
    elseif Type == "vertical" then
        if reachedGoal then
            self:set_linear_velocity(vec2(0,-5))--self:set_position(self:get_position() - vec2(0,0.025))
        else
            self:set_linear_velocity(vec2(0,5))--self:set_position(self:get_position() + vec2(0,0.025))
        end
    end
    if count >= 500 then
        count = 0; reachedGoal = not reachedGoal
    end
end