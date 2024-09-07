local function spawn_joblo(pos)
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

return spawn_joblo;
