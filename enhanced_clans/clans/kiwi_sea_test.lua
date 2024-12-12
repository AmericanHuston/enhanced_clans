local storage = core.get_mod_storage()

function clansmod.players_per_clan(clan)
    local members

    for _, player in ipairs(core.get_connected_players()) do
        local playercs = player:get_player_name() .. "-clan"
        if storage:get_string(playercs) ~= nil then
            if storage:get_string(playercs) == clan then
                members = members + 1
            end
        end
    end
    return members
end


function clansmod.players_online()
    local ptable = {}
    for _, player in ipairs(core.get_connected_players()) do
        table.insert(ptable, player:get_player_name())
    end

    local online = #ptable
    return online
end

function clansmod.players_in_clan(clan)
    local playercs
    local tbl_players_in_clan = {}
    for i,v in ipairs(core.get_connected_players) do
        playercs = v:get_player_name() .. "-clan"
        if storage:get_string(playercs) == clan then
            table.insert(tbl_players_in_clan, v:get_player_name())
        end
    end
    return tbl_players_in_clan
end

function clansmod.clan_level(currentClan)
    local clan_lvl
    if clansmod.clan_exists(currentClan) then
        local clan_players = clansmod.players_in_clan(currentClan)
        for i, v in ipairs(clan_players) do
            local playerls = v .. "-level" --Player Level Storage
            local player_lvl = storage:get_int(playerls)
            if clan_lvl == nil then
                clan_lvl = player_lvl
            else
                clan_lvl = clan_lvl + player_lvl
            end
            clan_lvl = clan_lvl / #clan_players
        end
        return clan_lvl
    else
        core.log("error", "Clan " .. currentClan .. " not found.")
    end
end

function clansmod.get_player_level(playername)
    local playercs = playername .. "-clan"
    local player_lvl = storage:get_string(playercs)
    return player_lvl
end

-- clansmod.sorting_algorithim. the average is going to be determined by the median, not the mean or mode.
function clansmod.sorting_alg(playername) --Must not be userdata
    local all_clan_average = 0
    local assignable_clans = {}
    local playerls = playername .. "-level"
    for i,v in ipairs(clansmod.clans) do
        local clan = v
        local clan_lvl = clansmod.clan_level(clan)
        local clanls = clan .. "-level"
        storage:set_int(clanls, clan_lvl)
        all_clan_average = all_clan_average + clan_lvl
    end
    all_clan_average = all_clan_average/ #clansmod.clans
    for _,a in ipairs(clansmod.clans) do
        local clan = a
        local clanls = clan .. "-level"
        local clan_lvl = storage:get_int(clanls)
        local players_in_clan = #clansmod.players_in_clan(clan)
        if (storage:get_int(playerls) + clan_lvl)/players_in_clan < all_clan_average then
            table.insert(assignable_clans, clan)
        end
    end
end