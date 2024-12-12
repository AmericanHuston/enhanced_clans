local storage = core.get_mod_storage()

core.register_node("clans:sacrifice", {
    description = "The sacrifice block",
    tiles = {"clans_sacrifice_node.png"},
    groups = {immortal = 1},
    diggable = true,
    after_place_node = function(pos, placer)
        local player_clan = storage:get_string(placer:get_player_name() .. "-clan")
        local placed = storage:get_int("sacrifice_exist_" .. player_clan)

        if placed == 1 then
            core.remove_node(pos)
            core.chat_send_player(placer:get_player_name(), "This node already exists for your clan")
        else
            storage:set_int("sacrifice_exist_" .. player_clan, 1)
        end
    end,
    on_punch = function(pos, node, puncher)
        if core.check_player_privs(puncher, { eventadmin=true }) then
            core.dig_node(pos, puncher)
        else
            core.chat_send_player(puncher:get_player_name(), "You aren't allowed to break this node")
        end
    end,
    after_dig_node = function(pos, oldnode, oldmetadata, digger)
        local playercs = digger:get_player_name() .. "-clan"
        local player_clan = storage:get_string(playercs)
        core.chat_send_all("on_dig happened" .. player_clan)
        storage:set_int("sacrifice_exist_" .. player_clan, 0)
    end
})

core.register_on_dieplayer(function(player, reason)
    local nodepos = core.find_node_near(player:get_pos(), 1, "clans:sacrifice")
    local player_level = storage:get_string(player:get_player_name() .. "-level")
    local drop
    if nodepos ~= nil then
        nodepos.x = math.floor(nodepos.x+0.5)
        nodepos.y = math.floor(nodepos.y+0.5)
        nodepos.z = math.floor(nodepos.z+0.5)
        if player_level <= 0 then
            drop = "default:dirt"
        else
            drop = clansmod.random_reward(player_level)
        end
        clansmod.drop(nodepos, ItemStack(drop)) --Soon to be random set of things
    end
end)