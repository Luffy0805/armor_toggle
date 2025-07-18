-- Internationalization support
local S = minetest.get_translator(minetest.get_current_modname())

local mod_storage = minetest.get_mod_storage()
local hidden_players = {}
local last_raw_textures = {}

-- Effets visuels et sonores lors du changement d’état d’armure
-- Effets visuels et sonores lors du changement d’état d’armure
local function play_effects(player, mode)
    local pos = player:get_pos()
    if not pos then return end

    pos.y = pos.y + 1  -- Effets légèrement au-dessus du joueur

    local texture = "test.png"
    local glow = 10

    -- Particules colorées selon mode
    minetest.add_particlespawner({
        amount = 30,
        time = 0.2,
        minpos = vector.subtract(pos, 0.5),
        maxpos = vector.add(pos, 0.5),
        minvel = {x = -0.5, y = 0.2, z = -0.5},
        maxvel = {x = 0.5, y = 2, z = 0.5},
        minacc = {x = 0, y = -2, z = 0},
        maxacc = {x = 0, y = -3, z = 0},
        minexptime = 0.5,
        maxexptime = 0.9,
        minsize = 3,
        maxsize = 4.5,
        texture = texture,
        glow = glow,
    })

    -- Sons génériques
    minetest.sound_play("smooth_swish", {
        pos = pos,
        max_hear_distance = 10,
        gain = 1.0,
    })
end


-- Charger l'état du joueur / Load the player's state
local function load_player_state(name)
    return mod_storage:get_string(name) == "hidden"
end

-- Sauvegarder l'état / Save the state
local function save_player_state(name, hidden)
    mod_storage:set_string(name, hidden and "hidden" or "visible")
    hidden_players[name] = hidden and true or nil
end

-- Cacher l’armure / Hide the armor
local function hide_armor(player)
    local name = player:get_player_name()
    if not name or not armor.textures then return end

    local skin = armor.textures[name] and armor.textures[name].skin or "character.png"
    local props = player:get_properties()
    props.textures = {
        skin,
        "blank.png", "blank.png", "blank.png",
        "blank.png", "blank.png"
    }
    player:set_properties(props)
end

-- Afficher l’armure / Show the armor
local function show_armor(player)
    if armor and armor.update_player_visuals then
        armor:update_player_visuals(player)
    end
end

-- Vérifie si toutes les textures d’armure sont blank.png / Check if all armor textures are blank.png
local function is_armor_blank(textures)
    for i = 2, #textures do
        if textures[i] ~= "blank.png" then
            return false
        end
    end
    return true
end

-- Commande principale / Main command
minetest.register_chatcommand("armor_view", {
    params = "<on|off|status>",
    description = S("Hide or show the 3D armor"),
    func = function(name, param, silent)
        local player = minetest.get_player_by_name(name)
        if not player then return false, S("Player not found.") end

        param = param:lower()
        if param == "off" then
			save_player_state(name, true)
			hide_armor(player)
			if not silent then play_effects(player) end
			return true, S("3D armor hidden.")
		elseif param == "on" then
			save_player_state(name, false)
			show_armor(player)
			if not silent then play_effects(player) end
			return true, S("3D armor shown again.")
        elseif param == "status" or param == "" then
            if hidden_players[name] then
                return true, S("3D armor is currently **hidden**.")
            else
                return true, S("3D armor is currently **visible**.")
            end
        else
            return false, "Usage : /armor_view <on|off|status>"
        end
    end
})

-- Commande courte /av / Short command /av
minetest.register_chatcommand("av", {
    description = S("Toggle armor visibility"),
    func = function(name)
        local player = minetest.get_player_by_name(name)
        if not player then return false, S("Player not found.") end

        if hidden_players[name] then
            save_player_state(name, false)
            show_armor(player)
			play_effects(player)
            return true, S("3D armor shown again.")
        else
            save_player_state(name, true)
            hide_armor(player)
			play_effects(player)
            return true, S("3D armor hidden.")
        end
    end
})

-- Appliquer l'état avec délai 
-- Apply state with delay
minetest.register_on_joinplayer(function(player)
    local name = player:get_player_name()
    if not name then return end

    local was_hidden = load_player_state(name)
    hidden_players[name] = was_hidden and true or nil

    local delay = 0.5 -- délai fixe, pas de condition

    minetest.after(delay, function()
        if not player:is_player() then return end
        if was_hidden then
            minetest.chatcommands["armor_view"].func(name, "off", true)
        else
            minetest.chatcommands["armor_view"].func(name, "on", true)
        end
    end)
end)


-- Vérifie régulièrement si les textures ont changé / Regularly checks if textures have changed
minetest.register_globalstep(function()
    for _, player in ipairs(minetest.get_connected_players()) do
        local name = player:get_player_name()
        if not name then return end

        local props = player:get_properties()
        local textures = props.textures or {}
        local current_str = table.concat(textures, ",")

        if last_raw_textures[name] ~= current_str then
            last_raw_textures[name] = current_str

            -- Si armure est censée être cachée mais textures visibles → recacher
            -- If armor is supposed to be hidden but textures are visible → hide again
            if hidden_players[name] and not is_armor_blank(textures) then
                minetest.chatcommands["armor_view"].func(name, "off", true)
            end
        end
    end
end)


