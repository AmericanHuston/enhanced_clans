A little to know about me and my coding:
I'm by no means a professional coder, and as such this code isn't
great. That being said, it all should work as intended. It's all 
still under development.

Local playercs.
Playercs is = to the player name + "-clan".
Playercs is a common variable that has been put in for easier and better access to clan storage.

Local level.
Level is = player name and "-level"
"-Level" is = to the number of people killed(killer) - number of how many times they have died(victim), or total sum of the two variables(killer - victim = level).
Level is an important peice of the sorting alg, it is the variable being divided. 
Level has many uses for example, if you want to use level in your server to keep track of how many times somone has killed or been killed.
All you would need to do is change line 101 from ,klevel ~= 5 to ,klevel ~= whatever number you want.(Must be positive)


Alright, the cool stuff:
tables:
    clansmod
        --- All the functions and global tables
    clansmod.clans
        --- The avaliable clans, by default
end

functions:
    clansmod.ser_clans()
        --- Serializes all the clans
        --- ONLY USE THIS WHEN MODIFYING CLANS PERMENENTLY
    clansmod.deser_clans()
        --- Deserializes all the clans
        --- ONLY USE THIS WHEN RETRIVING PERMEMNET CLANS
    clansmod.add_clan(clanname<string>)
        --- Makes a new clan, premenently
    clansmod.delete_clan(issuername<string>, clanname<string>)
        --- Removes a clan, permemently
    clansmod.add_to_clan(issuer<string>, playername<string>, random<bool>, clan<optional,string>)
        --- Sets a player to a clan, if one isn't given
        --- Its randomly selected from clansmod.clans
    clansmod.remove_from_clan(playername<string>)
        --- Remove the player from their current clan, setting to nil
    clansmod.players_in_clan(clan<string>)
        --- Returns a table with all the players in a clan
    clansmod.change_level_on_die(victim<string>, killer<string>)
        --- victim is who got killed, killer is who is killing
        --- Changes both of their levels
    clansmod.clan_exists(clanname<string>)
        --- checks if a given clan exists
    clansmod.chat_send_clan(clanname<string>, msg<string>)
        --- Sends a chat message (msg) to the players in the clan of clanname
    clansmod.drop(pos<tbl x,y,z>, istack<itemString>)
        --- Drops an item (istack) at a specific location (pos)
    clansmod.random_reward(reward_level<int>)
        --- Returns a reward item, used with clansmod.drop()

playername is = to the player name + the clan of the player.
All this is is playercs a local that has been put in for easier and better access to the player and clan at the same time.