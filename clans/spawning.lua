local storage = core.get_mod_storage()

core.register_on_respawnplayer(function(userdata) --need userdata for name:get/set_pos()
    local player = userdata:get_player_name()
    local playercs = player .. "-clan"
    local clan = storage:get_string(playercs)
    local clanss = clan .. "-spawn"
    local spawnPoint = storage:get_string(clanss)
    spawnPoint = core.deserialize(spawnPoint) or {x = 0, y = 30, z = 0}
    core.after(0.5,function()
        userdata:set_pos(spawnPoint)
    end
    )
end)

core.register_on_dieplayer(function(name, reason)
    local player = name:get_player_name()
    -- local level = storage:get_int(player .. "-level")
    for i,v in pairs(reason) do
        if type(v) == "userdata" then
            core.chat_send_player(player, v:get_player_name() .. " has killed you")
            clansmod.change_level_on_die(player, v:get_player_name())
        end
    end
end
)

core.register_node("clans:clanspawn", {
    description = "Clan Spawn Node",
    tiles = {"clan_spawn_node.png"},
    groups = {immortal = 1},
    after_place_node = function(pos, placer)
        -- This function is run when the chest node is placed.
        -- The following code sets the formspec for chest.
        -- Meta is a way of storing data onto a node.

        local meta = core.get_meta(pos)
        meta:set_string("formspec",
        "formspec_version[4]"..
        "size[8,4]"..
        "label[0.375,0.5;Which clan should spawn members here?]"..
        "field[Clanname;Clanname;;]"..
        "button[3.5,3.0;3,0.8;submit;Submit]")
    end,

    on_receive_fields = function(pos, formname, fields, player)
        if fields.quit then
            return
        end

        if core.check_player_privs(player, { eventadmin=true }) then
            local meta = core.get_meta(pos)
            local clan = fields.Clanname
            local clanss = clan .. "-spawn"
            pos = {x = pos.x, y = pos.y + 0.5, z = pos.z}
            storage:set_string(clanss, core.serialize(pos))
            meta:set_string("clan_on_node", fields.Clanname)

            core.chat_send_all(fields.Clanname)
        else
            core.chat_send_player(player:get_player_name(), "You aren't allowed to submit this form")
        end
    end,
    on_destruct = function(pos)
        local meta = core.get_meta(pos)
        local clan = meta:get_string("clan_on_node")
        local clanSpawnNew = {x = 0, y = 40, z = 0}
        storage:set_string(clan .. "-spawn", core.serialize(clanSpawnNew))
    end,
    on_punch = function(pos, node, puncher)
        if core.check_player_privs(puncher, { eventadmin=true }) then
            core.dig_node(pos)
        else
            core.chat_send_player(puncher:get_player_name(), "You aren't allowed to break this node")
        end
    end
})