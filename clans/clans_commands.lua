local storage = core.get_mod_storage()

core.register_chatcommand("showclan", {
    privs = {eventadmin},
    func = function(name, param)
        local temp = core.get_player_by_name(name)
        local player = temp:get_player_name()
        local playercs = param .. "-clan" --player clan storage
        if param == "" then
            local player_clan = storage:get_string(player .. "-clan")
            core.chat_send_player(player, "Your clan is " .. player_clan)
        else
            local player_clan = storage:get_string(playercs)
            core.chat_send_player(player, param .. " is of the clan " .. player_clan)
        end
    end,
    description = "Usage: /showclan <player>"
})

core.register_chatcommand("setclan", {
    privs = {eventadmin},
    func = function(name, param)
        local success = false
        local temp = core.get_player_by_name(name)
        local player = temp:get_player_name()
        local msg, to = param:match("^([%a%d_-]+) (.+)$")
        if param ~= "" then
            for i,v in pairs(clansmod.clans) do
                if to == v then
                    success = true
                    core.chat_send_player(player, "Match found")
                end
            end
            if success then
                local playercs = msg .. "-clan" --player clan storage
                storage:set_string(playercs, to)
                core.chat_send_player(player, "Set player " .. msg .. "'s clan to " .. to)
            else
                core.chat_send_player(player, "Usage: /setclan <player> <clan>")
            end
        else
            core.chat_send_player(player, to .. "Isn't a valid clan")
        end
    end,
    description = "Usage: /setclan <player> <clan>"
})

core.register_chatcommand("clearclan", {
    privs = {eventadmin},
    func = function(name, param)
        local temp = core.get_player_by_name(name)
        local player = temp:get_player_name()
        if param ~= "" then
            local msg = param:match("^([%a%d_-]+)$")
            local playercs = msg .. "-clan" --player clan storage
            storage:set_string(playercs, nil)
            core.chat_send_player(player, "Set player " .. msg .. "'s clan to nil")
        else
            core.chat_send_player(player, "Usage: /clearclan <player>")
        end
    end,
    description = "Usage: /clearclan <player>"
})

core.register_chatcommand("listclans", {
    privs = {eventadmin},
    func = function(name, param)
        local temp = core.get_player_by_name(name)
        local player = temp:get_player_name()
        for i,v in ipairs(clansmod.clans) do
            core.chat_send_player(player, v)
        end
    end
})
core.register_chatcommand("showclan_members", {
    privs = {eventadmin},
    func = function(name, param)
        local temp = core.get_player_by_name(name)
        local player = temp:get_player_name()
        local playercs = player .. "-clan"
        local table = clansmod.players_in_clan(storage:get_string(playercs))
        local str = "The members of " .. storage:get_string(playercs) .. " are: "
        for i,v in ipairs(table) do
            str = str .. v .. ", "
        end
        core.chat_send_player(player, str)
    end,
    description = "Usage: /showclan_members"
})
core.register_chatcommand("newclan", {
    privs = {eventadmin},
    func = function(player, param)
        if param ~= "" then
            local msg = param:match("^([%a%d_-]+)$")
            clansmod.add_clan(msg)
        end
    end,
    description = "Usage: /newclan <clanname>"
})
core.register_chatcommand("rmclan", {
    privs = {eventadmin},
    func = function(name, param)
        local temp = core.get_player_by_name(name)
        local player = temp:get_player_name()
        if param ~= "" then
            local msg = param:match("^([%a%d_-]+)$")
            clansmod.delete_clan(player, msg)
        end
    end,
    description = "Usage: /rmclan <clanname>"
})
core.register_chatcommand("setclan_spawn", {
    privs = {eventadmin},
    func = function(name, param)
        local temp = core.get_player_by_name(name)
        local player = temp:get_player_name()
        if param ~= "" then
            local clanname,vx,vy,vz = param:match("^([%a]+) ([%d]+) (.+) (.+)$")
            local clanss = clanname .. "-spawn" --clan spawn storage
            local spawnPoint = {x = tonumber(vx), y = tonumber(vy), z = tonumber(vz)}
            storage:set_string(clanss, core.serialize(spawnPoint))
        else
            core.chat_send_player(player, "Usage: /setclan_spawn <clanname> <x> <y> <z>")
        end
    end,
    description = "Usage: /setclan_spawn <clanname> <x> <y> <z>"
})

core.register_chatcommand("set_default_spawn", {
    privs = (eventadmin),
    func = function(name, param)
        local temp = core.get_player_by_name(name)
        local player = temp:get_player_name()
        if param ~= "" then
            local vx,vy,vz = param:match("^([%d]+) (.+) (.+)$")
            local spawnPoint = {x = tonumber(vx), y = tonumber(vy), z = tonumber(vz)}
            storage:set_string("default-spawn", core.serialize(spawnPoint))
        else
            core.chat_send_player(player, "Usage: /set_default_spawn <clanname> <x> <y> <z>")
        end
    end,
    description = "Usage: /set_default_spawn <clanname> <x> <y> <z>"
})

core.register_chatcommand("delstuff", {
    description = "For when you make a whopsie",
    func = function(temp)
        local name = core.get_player_by_name(temp)
        local player = name:get_player_name()
        storage:set_int("sacrifice_exist_"..storage:get_string(player.. "-clan"), 0)
    end
})