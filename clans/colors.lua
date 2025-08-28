local colors = {
     gray  = {r = 100, g = 100, b = 100}
     orange            = {r = 245, g = 61,  b = 15}
     swamp_green       = {r = 41,  g = 74,  b = 43}
     dark_forest_green = {r = 23,  g = 74,  b = 1}
     forest_green      = {r = 73,  g = 184, b = 26}
     black             = {r = 0,   g = 0,   b = 0}
     blue              = {r = 35,  g = 42,  b = 250}
}

    local color = {r = redValue, g = greenValue, b = blueValue}
core.register_chatcommand("colorp",{
    privs = {eventadmin},
    local player = temp:get_player_name()
    local player,color = param:match("^([%a%d_-]+) (.+)$")

    player:set_nametag_attributes(color = color)
    player:set_attribute("nametag_color", luanti.serialize(colors[param]))


})